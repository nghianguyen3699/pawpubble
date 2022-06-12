defmodule Pawpubbleclone.Repo.Migrations.CreateShipping do
  use Ecto.Migration

  def change do
    create table(:shippings) do
      add :name, :string
      add :value, :decimal

      timestamps()
    end
  end
end
