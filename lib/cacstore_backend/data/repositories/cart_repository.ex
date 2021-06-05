defmodule Cacstore.Data.Repositories.CartRepository do
  alias Cacstore.Domain.Repositories.CartRepositoryContract
  alias Cacstore.Data.CartServer
  alias Cacstore.Data.CartRegistry
  alias Cacstore.Domain.Entities.Cart
  alias Cacstore.Domain.Entities.Coupon

  @product_repository Application.get_env(:cacstore_backend, :product_repository)
  @coupon_repository Application.get_env(:cacstore_backend, :coupon_repository)
  @behaviour CartRepositoryContract

  @impl CartRepositoryContract
  def get_info( hash  )  do
    with cart_server <- locate_cart(hash),
         cart <- CartServer.get_cart_info(cart_server),
         { :ok, products } <- populate_products_info(cart),
         coupon <- populate_coupon_info(cart),
         { subtotal, total } <- calculate_totals(products, coupon)
      do
        %Cart{ id: hash, coupon: coupon, products: products, total: total, subtotal: subtotal }
      else
        _ -> %Cart{ id: hash }
    end
  end

  @impl CartRepositoryContract
  def clean( hash ) do
    hash
    |> locate_cart()
    |> CartServer.clean()
  end

  @impl CartRepositoryContract
  def insert_item( hash , product , quantity  ) do
    with :ok <- @product_repository.exists?(product),
        cart <- locate_cart(hash),
        :ok <- CartServer.update_item(cart, product, quantity)
      do
        { :ok, "Item inserted" }
      else
        :not_found -> { :error, "Product not exists" }
        _ -> { :error, "The item could not be inserted"}
    end
  end

  @impl CartRepositoryContract
  def remove_item( hash , product  ) do
    hash
    |> locate_cart()
    |> CartServer.remove_item(product)
  end

  @impl CartRepositoryContract
  def update_item( hash , product , quantity  ) do
    with :ok <- @product_repository.exists?(product),
        cart <- locate_cart(hash),
        :ok <- CartServer.update_item(cart, product, quantity)
      do
        { :ok, "Item updated" }
      else
        :not_found  -> { :error, "Product not exists" }
        _ -> { :error, "The item could not be updated"}
    end
  end

  @impl CartRepositoryContract
  def insert_coupon( hash , coupon ) do
    with :ok <- @coupon_repository.exists?(coupon),
        cart <- locate_cart(hash),
        :ok <- CartServer.insert_coupon(cart, coupon)
      do
        { :ok, "Coupon inserted" }
      else
        :not_found  -> { :error, "Coupon not exists" }
        _ -> { :error, "The coupon could not be inserted"}
    end

  end

  @impl CartRepositoryContract
  def remove_coupon( hash ) do
    hash
    |> locate_cart()
    |> CartServer.remove_coupon()
  end

  defp locate_cart( hash ) do
    Process.whereis(CartRegistry)
    |> CartRegistry.locate_cart(hash)
  end

  defp populate_products_info( %Cart{ products: products  } ) do
    products
    |> Map.keys()
    |> @product_repository.get_many()
  end

  defp populate_coupon_info( %Cart{ coupon: coupon } ) do
    case @coupon_repository.find(coupon) do
      { :ok, coupon } -> coupon
      _ ->  nil
    end
  end

  defp calculate_totals( products, :nil ) do
    subtotal = calculate_subtotal(products)
    { subtotal, subtotal }
  end

  defp calculate_totals( products, %Coupon{ type_of_discount: "fixed", discount: discount } ) do
    subtotal = calculate_subtotal(products)
    { subtotal, subtotal - discount }
  end

  defp calculate_totals( products, %Coupon{ type_of_discount: "percent", discount: discount } ) do
    subtotal = calculate_subtotal(products)
    { subtotal, subtotal - ( discount * subtotal ) / 100 }
  end

  defp calculate_subtotal(products), do: Enum.reduce(products, 0, fn(p, acc) -> sum_price(p, acc) end)

  defp sum_price(p, acc) when not is_nil(p.sale_price) and p.sale_price > 0, do: p.sale_price + acc
  defp sum_price(p, acc), do: p.price + acc
end
