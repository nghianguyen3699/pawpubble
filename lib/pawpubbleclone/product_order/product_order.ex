defmodule Pawpubbleclone.Product_Orders.Product_order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_orders" do
    field :order_code, :string
    belongs_to :product, Pawpubbleclone.Plant.Plant_product
    field :quantity, :integer

    timestamps()
  end

  def changeset(product, params \\ %{}) do
    product
    |> cast(params, [:order_code, :product_id, :quantity])
    |> validate_required([:order_code, :product_id, :quantity])
    # |> unique_constraint([:name, :code, :rgb])
  end
end
