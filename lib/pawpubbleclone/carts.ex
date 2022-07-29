defmodule Pawpubbleclone.Carts do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Carts.Cart
  import Ecto.Query

  def get_cart(id) do
    Repo.get(Cart, id)
  end

  def get_cart!(product_id) do
    Repo.get_by!(Cart, %{product_id: product_id})
  end

  def get_cart_by(params) do
    Repo.get_by(Cart, params)
  end

  def list_cart() do
    Repo.all(Cart)
  end

  def list_cart_query(id) do
    if id == nil do
      nil
    else
      query = from u in "carts",
                  where: u.user_id == ^id,
                  select: %{  id: u.id,
                              product_id: u.product_id,
                              user_id: u.user_id,
                              quantity: u.quantity
                  },
                  order_by: [desc: u.updated_at]
      Repo.all(query)
    end
  end
  def check_cart(user_id, product_id) do
    query = from u in "carts",
                where: u.user_id == ^user_id and u.product_id == ^product_id,
                select: %{
                  quantity: u.quantity,
                  id: u.id
                }
    Repo.all(query)
  end

  def update(%Cart{} = cart, attrs ) do
    cart
    |> Cart.changeset(attrs)
    |> Repo.update()
  end

  def create_cart(atts \\ %{}) do
    %Cart{}
    |> Cart.changeset(atts)
    |> Repo.insert()
  end

  def delete(%Cart{} = cart) do
    Repo.delete(cart)
  end
end
