defmodule CacstoreWeb.ProductController do
    use CacstoreWeb, :controller

    def index( conn, _params ) do
      conn
      |> put_status(200)
      |> render("product.json")
    end
end
