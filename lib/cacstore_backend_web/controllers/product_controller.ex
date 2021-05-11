defmodule CacstoreWeb.ProductController do
    alias Cacstore.Domain.Entities.Product

    use CacstoreWeb, :controller

    def index( conn, params ) do
      with {:ok, %Product{} = product } <- Cacstore.create_product(params) do
        conn
        |> put_status(200)
        |> render("product.json", product: product)
      else
        _ -> conn
        |> put_status(400)
        |> render("Error")
      end
    end
end
