defmodule Cacstore.Data.CartServer do
  alias Cacstore.Domain.Entities.Cart
  use GenServer

  def init(args) do
    {:ok, args}
  end

  # PUBLIC

  def create(cart_hash) do
    GenServer.start(__MODULE__, %Cart{}, name: {:global, cart_hash })
  end

  def clean(cart_server) do
    GenServer.cast(cart_server, {:clean } )
  end

  def contains_product?(cart_server, product_id) do
    GenServer.call(cart_server, {:lookup_item, product_id})
  end

  def get_cart_info(cart_server) do
    :sys.get_state(cart_server)
  end

  def update_item(cart_server, product_id, quantity) do
    GenServer.cast(cart_server, {:update_item, product_id, quantity})
  end

  def remove_item(cart_server, product_id) do
    GenServer.cast(cart_server, {:remove_item, product_id} )
  end

  def insert_coupon(cart_server, coupon_id) do
    GenServer.cast(cart_server, {:new_coupon, coupon_id})
  end

  def remove_coupon(cart_server) do
    GenServer.cast(cart_server, {:remove_coupon } )
  end

  # CALLBACKS

  def handle_cast({:clean }, _cart ) do
    { :noreply, %Cart{} }
  end

  def handle_cast({:update_item, product_id, quantity }, cart ) do
    { :noreply, %Cart{ cart | products: Map.update(cart.products, product_id, quantity, fn previous -> previous + quantity end ) } }
  end

  def handle_cast({:remove_item, product_id }, cart ) do
    { :noreply, %Cart{ cart | products: Map.delete(cart, product_id) } }
  end

  def handle_cast({:new_coupon, coupon }, cart ) do
    { :noreply, %Cart{ cart | coupon: coupon } }
  end

  def handle_cast({:remove_coupon }, cart ) do
    { :noreply, %Cart{ cart | coupon: :nil } }
  end

  def handle_call({:lookup_item, product_id}, _from, cart ) do
    {:reply, { :ok, Map.has_key?(cart.products, product_id) }, cart }
  end

end
