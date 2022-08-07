defmodule Pawpubbleclone.Repo.Migrations.CreateTableSizeClothers do
  use Ecto.Migration

  def change do
    create table(:size_clothers) do
      add :category_id, references(:categorys, on_delete: :nothing)
      add :size_id, references(:sizes, on_delete: :nothing)
      add :shirt_length_in, :integer
      add :chest_width_in, :integer
      add :chest_height_cm, :integer
      add :chest_width_cm, :integer

      timestamps()
    end

    create index(:size_clothers, [:category_id])
    create index(:size_clothers, [:size_id])
  end
end
