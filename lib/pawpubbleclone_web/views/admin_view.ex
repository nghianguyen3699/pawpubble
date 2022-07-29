defmodule PawpubblecloneWeb.AdminView do
  use PawpubblecloneWeb, :view
  import Scrivener.HTML
  alias Pawpubbleclone.Product_Orders
  alias Pawpubbleclone.Repo

  def category_select_options(options) do
    for option <- options, do: {option.name, option.id}
  end

  def getProductPurchase(order_code) do
    products =
      order_code
        |> Product_Orders.get_product_order!()
        |> Repo.preload(:product)
    IO.inspect(products)
    for product <- products do
      [Repo.preload(product.product, [:size, :color, :category, :concept]), product.quantity]
    end
  end
end
