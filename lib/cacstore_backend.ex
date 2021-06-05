defmodule Cacstore do
  alias Cacstore.Domain.Actions.Products.Create, as: CreateProduct
  alias Cacstore.Domain.Actions.Products.Find, as: FindProduct
  alias Cacstore.Domain.Actions.Products.GetAll, as: GetAllProducts
  alias Cacstore.Domain.Actions.Products.Update, as: UpdateProduct
  alias Cacstore.Domain.Actions.Products.Delete, as: DeleteProduct
  alias Cacstore.Domain.Actions.Coupons.Create, as: CreateCoupon
  alias Cacstore.Domain.Actions.Coupons.Find, as: FindCoupon
  alias Cacstore.Domain.Actions.Coupons.GetAll, as: GetAllCoupons
  alias Cacstore.Domain.Actions.Coupons.Update, as: UpdateCoupon
  alias Cacstore.Domain.Actions.Coupons.Delete, as: DeleteCoupon
  alias Cacstore.Domain.Actions.Cart.GetInfo, as: GetCartInfo
  alias Cacstore.Domain.Actions.Cart.Clean, as: CleanCart
  alias Cacstore.Domain.Actions.Cart.InsertItem, as: InsertCartItem
  alias Cacstore.Domain.Actions.Cart.UpdateItem, as: UpdateCartItem
  alias Cacstore.Domain.Actions.Cart.RemoveItem, as: RemoveCartItem
  alias Cacstore.Domain.Actions.Cart.InsertCoupon, as: InsertCartCoupon
  alias Cacstore.Domain.Actions.Cart.RemoveCoupon, as: RemoveCartCoupon

  @moduledoc """
  Cacstore keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate create_product(params), to: CreateProduct, as: :call
  defdelegate find_product(params), to: FindProduct, as: :call
  defdelegate get_all_products(), to: GetAllProducts, as: :call
  defdelegate update_product(params), to: UpdateProduct, as: :call
  defdelegate delete_product(params), to: DeleteProduct, as: :call

  defdelegate create_coupon(params), to: CreateCoupon, as: :call
  defdelegate find_coupon(params), to: FindCoupon, as: :call
  defdelegate get_all_coupons(), to: GetAllCoupons, as: :call
  defdelegate update_coupon(params), to: UpdateCoupon, as: :call
  defdelegate delete_coupon(params), to: DeleteCoupon, as: :call

  defdelegate get_cart_info(params), to: GetCartInfo, as: :call
  defdelegate clean_cart(params), to: CleanCart, as: :call
  defdelegate insert_cart_item(params), to: InsertCartItem, as: :call
  defdelegate update_cart_item(params), to: UpdateCartItem, as: :call
  defdelegate remove_cart_item(params), to: RemoveCartItem, as: :call
  defdelegate insert_cart_coupon(params), to: InsertCartCoupon, as: :call
  defdelegate remove_cart_coupon(params), to: RemoveCartCoupon, as: :call
end
