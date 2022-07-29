defmodule Pawpubbleclone.Orders do

  import Ecto.Query
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Orders.Order_session
  alias Pawpubbleclone.Shipping.Shippings

  def get_order(id) do
    Repo.get(Order_session, id)
  end

  def get_order!(order_code) do
    Repo.get_by!(Order_session, %{order_code: order_code})
  end

  def get_all_order_by_user(user_id) do
    order =
      from(i in Order_session, join: s in Shippings,
                               on: s.id == i.shipping_id,
                               where: i.user_id == ^user_id,
                               select: {i.order_code, i.total_price, i.inserted_at, s.value, i.bill_of_lading_no, i.quantity})
        |> Repo.all()
  end

  def list_orders() do
    Repo.all(Order_session)
  end

  def create_order(atts \\ %{}) do
    %Order_session{}
    |> Order_session.changeset(atts)
    |> Repo.insert()
  end

  def delete(%Order_session{} = order) do
    Repo.delete(order)
  end
end
