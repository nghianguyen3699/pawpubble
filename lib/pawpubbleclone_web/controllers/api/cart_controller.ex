defmodule PawpubblecloneWeb.Api.CartController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Carts

  def index(conn, _) do
    carts =
    conn
    |> fetch_session()
    |> get_session(:user_id)
    |> Carts.list_cart_query()
    render(conn, "index.json", carts: carts)
  end

  def show(conn, %{"id" => id}) do
    cart = Carts.get_cart(id)
    render(conn, "show.json", cart: cart)
  end
end
