defmodule Pawpubbleclone.Repo.Migrations.CreateTemporaryTableSortProduct do
  use Ecto.Migration

  def change do
    create table(:temporarySortProducts) do
      add :product_id, references(:plants, on_delete: :nothing)

      timestamps()
    end
  end
end
