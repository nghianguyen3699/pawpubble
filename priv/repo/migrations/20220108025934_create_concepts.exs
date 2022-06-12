defmodule Pawpubbleclone.Repo.Migrations.CreateConcepts do
  use Ecto.Migration

  def change do
    create table(:concepts) do
      add :name, :string

      timestamps()
    end

    create unique_index(:concepts, [:name])
  end
end
