defmodule PawpubblecloneWeb.Api.CartView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{carts: carts}) do
    if carts == nil do
      %{data: nil}
    else
      %{data: render_many(carts, PawpubblecloneWeb.Api.CartView, "cart.json")}
    end
  end
  def render("show.json", %{cart: cart}) do
    %{data: render_one(cart, PawpubblecloneWeb.Api.CartView, "cart.json")}
  end


  def render("cart.json", %{cart: cart}) do
    %{
      id: cart.id,
      product_id: cart.product_id,
      user_id: cart.user_id,
      quantity: cart.quantity
    }
  end
end
