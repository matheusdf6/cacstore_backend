defmodule CacstoreWeb.ProductView do
  use CacstoreWeb, :view

  def render("product.json", _params) do
    %{
      message: "ok"
    }
  end
end
