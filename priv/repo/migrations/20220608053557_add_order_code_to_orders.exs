defmodule Pawpubbleclone.Repo.Migrations.AddOrderCodeToOrders do
  use Ecto.Migration

  def change do
    alter table(:product_orders) do
      add :order_code, :string
    end
    alter table(:orders) do
      add :order_code, :string
    end
  end
end
