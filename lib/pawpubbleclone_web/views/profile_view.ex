defmodule PawpubblecloneWeb.ProfileView do
  use PawpubblecloneWeb, :view

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Product_Orders
  alias Pawpubbleclone.Plants

  def hiddenPartEmail(email) do
    email
     |> String.replace(String.slice(email, 2..(String.length(email) - 3)), String.duplicate("*", String.length(email) - 4))
  end

  def hiddenPartPhone(phone) do
    phone
     |> String.replace(String.slice(phone, 2..(String.length(phone) - 3)), String.duplicate("*", String.length(phone) - 4))
  end

  def showFirstCharacterName(name) do
    name
     |> String.first()
     |> String.upcase()
  end

  # def getTotalPrice(orders_product) do
  #   x =
  #   for order <- orders_product do
  #     # IO.inspect(order)
  #     for product <- List.first(order) do
  #       [Plants.get_plant_product!(product.product_id)
  #         |> Repo.preload([:category, :color, :size, :concept]), product.quantity]
  #     end
  #   end
  #   |> Enum.with_index()

  #   for i <- x do
  #     Tuple.to_list(i)
  #   end
  # end

  def analyzeOrders(orders) do
    orders_product =
      for {order_code, _, _, _, _, _, _} <- orders do
        order_list =
        {
          list_products_one_order =
        order_code
          |> Product_Orders.get_product_order!()
        }
        # |> Tuple.append(total_price)
        |> Tuple.to_list()
      end
    x =
      for order <- orders_product do
        for product <- List.first(order) do
          [Plants.get_plant_product!(product.product_id)
            |> Repo.preload([:category, :color, :size, :concept]), product.quantity]
        end
      end
      |> Enum.with_index()

      for i <- x do
        Tuple.to_list(i)
      end
  end

  def convertTupleToList(orders) do
    for i <- orders do
      Tuple.to_list(i)
    end
  end
end
