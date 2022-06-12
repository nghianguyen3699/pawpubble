defmodule Pawpubbleclone.Orders do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Orders.Order_session

  def get_order(id) do
    Repo.get(Order_session, id)
  end

  def get_order!(name) do
    Repo.get_by!(Order_session, %{name: name})
  end

  def get_order_by(params) do
    Repo.get_by(Order_session, params)
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
