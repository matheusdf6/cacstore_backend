defmodule Cacstore.Data.Repositories.CouponRepository do
  alias Cacstore.Domain.Repositories.CouponRepositoryContract
  alias Cacstore.Data.Schemas.CouponSchema
  alias Cacstore.Repo
  alias Ecto.Multi

  @behaviour CouponRepositoryContract

  @impl CouponRepositoryContract
  def exists?(code) do
    { result, _args } = find(code)
    result
  end

  @impl CouponRepositoryContract
  def create(params) do
    params
    |> CouponSchema.changeset()
    |> Repo.insert()
    |> CouponSchema.to_coupon()
  end

  @impl CouponRepositoryContract
  def find(code) do
    case Repo.get_by(CouponSchema, code: code) do
      nil -> { :not_found, "Coupon not found" }
      coupon -> { :ok, CouponSchema.to_coupon(coupon) }
    end
  end

  @impl CouponRepositoryContract
  def get_all() do
    coupons = Repo.all(CouponSchema)
              |> Enum.map( fn(schema) -> CouponSchema.to_coupon(schema) end )
    {:ok, coupons}
  end

  @impl CouponRepositoryContract
  def update( %{ id: id } = params) do
    Multi.new()
    |> Multi.run(:find_coupon, fn repo, _changes -> find_coupon(repo, id) end )
    |> Multi.run(:update_coupon, fn repo, %{ find_coupon: coupon } -> update_coupon(coupon, repo, params) end )
    |> Repo.transaction()
    |> transaction_response(:update_coupon)
  end

  @impl CouponRepositoryContract
  def delete( id ) do
    Multi.new()
    |> Multi.run(:find_coupon, fn repo, _changes -> find_coupon(repo, id) end )
    |> Multi.run(:delete_coupon, fn repo, %{ find_coupon: coupon } -> delete_coupon(coupon, repo) end )
    |> Repo.transaction()
    |> transaction_response(:delete_coupon)
  end

  defp find_coupon(repo, id) do
    case repo.get(CouponSchema, id) do
      nil -> {:not_found, "Coupon not found"}
      coupon -> {:ok, coupon}
    end
  end

  defp update_coupon({:not_found, reason}, _repo, _params ), do: { :error, reason }
  defp update_coupon( %CouponSchema{} = coupon, repo, params) do
    coupon
    |> CouponSchema.changeset(params)
    |> repo.update()
    |> CouponSchema.to_coupon()
  end

  defp delete_coupon({:not_found, reason}, _repo ), do: { :error, reason }
  defp delete_coupon(%CouponSchema{} = coupon, repo ) do
    case repo.delete(coupon) do
        { :ok, _struct } -> { :ok, "Coupon deleted"}
        { :error, _reason } -> { :error, "An error occurred" }
    end
  end

  defp transaction_response({:error, _operation, reason, _changes}, _operation_name), do: { :error, reason }
  defp transaction_response({:ok, changes }, operation_name ), do: { :ok, Map.get(changes, operation_name) }

end
