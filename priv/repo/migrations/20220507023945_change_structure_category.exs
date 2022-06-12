defmodule Pawpubbleclone.Repo.Migrations.ChangeStructureCategory do
  use Ecto.Migration

  def change do
    alter table(:categorys) do
      remove :name
      add :target, :string
      add :category, :string
      add :name, :string

    end
    create unique_index(:categorys, :name)
  end
end
