defmodule Pawpubbleclone.Repo.Migrations.AddSlugToConcepts do
  use Ecto.Migration

  def change do
    alter table(:concepts) do
      add :slug, :string
    end
  end
end
