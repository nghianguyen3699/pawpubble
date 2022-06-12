defmodule Pawpubbleclone.Repo.Migrations.Create do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add :session_id, references(:shopping_sessions, on_delete: :nothing)
      add :product_id, references(:plants, on_delete: :nothing)
      add :quantity, :integer

      timestamps()
    end

    create index(:carts, [:session_id])
    create index(:carts, [:product_id])
  end
end
