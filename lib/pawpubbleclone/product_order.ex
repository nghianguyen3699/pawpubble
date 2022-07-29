defmodule Pawpubbleclone.Product_Orders do

  import Ecto.Query
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Product_Orders.Product_order

  def get_product_order(id) do
    Repo.get(Product_order, id)
  end

  def get_product_order!(order_code) do
    product_order =
      from(i in Product_order, where: i.order_code == ^order_code, select: i)
      |> Repo.all()
  end

  def get_product_order_by(params) do
    Repo.get_by(Product_order, params)
  end

  def list_product_orders() do
    Repo.all(Product_order)
  end

  def create_product_order(atts \\ %{}) do
    %Product_order{}
    |> Product_order.changeset(atts)
    |> Repo.insert()
  end

  def delete(%Product_order{} = product_order) do
    Repo.delete(product_order)
  end
end
