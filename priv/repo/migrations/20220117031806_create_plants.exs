defmodule Pawpubbleclone.Repo.Migrations.CreatePlants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string
      add :price, :decimal
      add :sku, :string
      add :concept_id, references(:concepts, on_delete: :nothing)
      add :color_id, references(:colors, on_delete: :nothing)
      add :size_id, references(:sizes, on_delete: :nothing)
      add :category_id, references(:categorys, on_delete: :nothing)

      timestamps()
    end

    create index(:plants, [:concept_id])
    create index(:plants, [:color_id])
    create index(:plants, [:size_id])
    create index(:plants, [:category_id])
  end
end
