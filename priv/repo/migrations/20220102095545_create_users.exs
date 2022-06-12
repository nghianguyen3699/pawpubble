defmodule Pawpubbleclone.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :phone, :integer
      add :password_hash, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:users, [:name, :email, :phone])
  end
end
