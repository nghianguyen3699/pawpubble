defmodule Pawpubbleclone.Repo.Migrations.CreateProductOrder do
  use Ecto.Migration

  def change do
    create table(:product_orders) do
      add :order_number, references(:orders, on_delete: :nothing)
      add :product_id, references(:plants, on_delete: :nothing)
      add :quantity, :integer

      timestamps()
    end
  end
end
