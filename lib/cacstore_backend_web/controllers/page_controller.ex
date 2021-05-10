defmodule CacstoreWeb.PageController do
  use CacstoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
