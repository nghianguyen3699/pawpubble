defmodule PawpubblecloneWeb.CheckoutController do
  use PawpubblecloneWeb, :controller

  # alias Pawpubbleclone.Carts
  # alias Pawpubbleclone.Plants
  def index(conn, params) do
    IO.inspect(params)
    render(conn, "index.html", products: params)
  end
  def checkout(conn, %{ "products" => products}) do
    # IO.inspect(products)
    list = []
    list_products =
    for product <- products do
      product = for {key, val} <- product, into: %{}, do: {String.to_atom(key), val}
      list ++ product
      # IO.inspect(product)
    end
    render(conn, "index.html", products: list_products)
    # conn
    #  |> redirect(to: Routes.checkout_path(conn, :index), products: list_products)
  end
end
