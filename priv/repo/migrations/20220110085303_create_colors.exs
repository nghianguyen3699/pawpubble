defmodule Pawpubbleclone.Repo.Migrations.CreateColors do
  use Ecto.Migration

  def change do
    create table(:colors) do
      add :name, :string

      timestamps()
    end

    create unique_index(:colors, [:name])
  end
end
