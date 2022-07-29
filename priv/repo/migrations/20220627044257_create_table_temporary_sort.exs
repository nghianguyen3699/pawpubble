defmodule Pawpubbleclone.Repo.Migrations.CreateTableTemporarySort do
  use Ecto.Migration

  def change do
    create table(:temporarysort) do
      add :concept_id, references(:concepts, on_delete: :nothing)
      add :category_id, references(:categorys, on_delete: :nothing)
      add :color_id, references(:colors, on_delete: :nothing)
      add :size_id, references(:sizes, on_delete: :nothing)

      timestamps()
    end
  end
end
