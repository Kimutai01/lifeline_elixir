defmodule LifelineElixirWeb.PageController do
  use LifelineElixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
