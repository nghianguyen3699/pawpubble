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
                               select: {i.order_code, i.total_price, i.inserted_at, s.value, i.bill_of_lading_no, i.quantity},
                               order_by: [desc: i.updated_at])
        |> Repo.all()
  end

  def get_new_orders(period) do
    to_day = Date.utc_today()
    from( u in Order_session, select: u.inserted_at)
      |> Repo.all()
      |> Enum.map(fn d -> Date.diff(to_day, NaiveDateTime.to_date(d))  end)
      |> Enum.map(fn d -> if d <= period, do: d end)
      |> Enum.filter(& !is_nil(&1))
  end

  def list_orders() do
    Repo.all(Order_session)
  end

  def create_order(atts \\ %{}) do
    %Order_session{}
    |> Order_session.changeset(atts)
    |> Repo.insert()
  end

  def update_orders(%Order_session{} = order, params) do
    order
     |> Order_session.changeset(params)
     |> Repo.update()
  end

  def delete(%Order_session{} = order) do
    Repo.delete(order)
  end
end
