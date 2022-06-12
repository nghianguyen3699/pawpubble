defmodule Pawpubbleclone.Repo.Migrations.CreateOrderProduct do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users, on_delete: :nothing)
      # add :product_id, references(:plants, on_delete: :nothing)
      add :quantity, :integer
      add :name, :string
      add :email, :string
      add :phone, :integer
      add :address, :string
      add :note, :string
      add :shipping_id, references(:shippings, on_delete: :nothing)
      add :voucher_id, references(:vouchers, on_delete: :nothing)
      add :order_number, :integer
      add :total_price, :decimal

      timestamps()
    end

  end
end
