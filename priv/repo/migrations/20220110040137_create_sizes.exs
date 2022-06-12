defmodule Pawpubbleclone.Repo.Migrations.CreateSizes do
  use Ecto.Migration

  def change do
    create table(:sizes) do
      add :name, :string

      timestamps()
    end

    create unique_index(:sizes, [:name])
  end
end
