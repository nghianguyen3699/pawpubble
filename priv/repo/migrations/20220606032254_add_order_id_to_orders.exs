defmodule Pawpubbleclone.Repo.Migrations.AddOrderIdToOrders do
  use Ecto.Migration

  def change do
    alter table(:product_orders) do
      add :order_id, references(:orders, on_delete: :nothing)
    end
  end
end
