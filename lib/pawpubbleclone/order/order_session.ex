defmodule Pawpubbleclone.Orders.Order_session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    belongs_to :user, Pawpubbleclone.Accounts.User
    field :quantity, :integer
    field :name, :string
    field :phone, :integer
    field :address, :string
    field :note, :string
    field :order_code, :string
    belongs_to :shipping, Pawpubbleclone.Shipping.Shippings
    belongs_to :voucher, Pawpubbleclone.Voucher.Vouchers
    field :total_price, :decimal
    timestamps()
  end

  def changeset(order, params \\ %{}) do
    order
    |> cast(params, [:name, :quantity, :phone, :order_code, :address, :note, :total_price, :user_id, :shipping_id, :voucher_id ])
    |> validate_required([:name, :quantity, :phone, :address, :note, :total_price, :user_id, :shipping_id ])
  end


end
