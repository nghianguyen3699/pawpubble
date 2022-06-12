defmodule Pawpubbleclone.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do

    field :quantity, :integer
    belongs_to :user, Pawpubbleclone.Accounts.User
    belongs_to :product, Pawpubbleclone.Plant.Plant_product

    timestamps()
  end

  def changeset(cart, params \\ %{}) do
    IO.inspect(params)
    cart
    |> cast(params, [:quantity, :product_id, :user_id])
    |> validate_required(:product_id)
    |> assoc_constraint(:user)
    |> assoc_constraint(:product)
  end
end
