defmodule PawpubblecloneWeb.Api.ShippingView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{shippings: shippings}) do
    %{data: render_many(shippings, PawpubblecloneWeb.Api.ShippingView, "shipping.json")}
  end
  def render("show.json", %{shipping: shipping}) do
    %{data: render_one(shipping, PawpubblecloneWeb.Api.ShippingView, "shipping.json")}
  end


  def render("shipping.json", %{shipping: shipping}) do
    %{
      id: shipping.id,
      name: shipping.name,
      value: shipping.value
    }
  end
end
