defmodule Pawpubbleclone.Repo.Migrations.AddCartToUser do
  use Ecto.Migration

  def change do
    create table(:shopping_sessions) do
      add :user_id, references(:users, on_delete: :nothing)
      add :total, :decimal

      timestamps()
    end

    create index(:shopping_sessions, [:user_id])
  end
end
