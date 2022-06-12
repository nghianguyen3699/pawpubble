defmodule PawpubblecloneWeb.Api.ShippingController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Shipping

  def index(conn, _params) do
    shippings = Shipping.list_shippings()
    render(conn, "index.json", shippings: shippings)
  end

  def show(conn, %{"id" => id}) do
    shipping = Shipping.get_shipping(id)
    render(conn, "show.json", shipping: shipping)
  end
end
