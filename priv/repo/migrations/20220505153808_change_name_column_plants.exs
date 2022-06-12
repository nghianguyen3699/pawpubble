defmodule Pawpubbleclone.Repo.Migrations.ChangeNameColumnPlants do
  use Ecto.Migration

  def change do
    rename table(:personalizeds), to: table(:plants)
    rename table(:plants), :product_id, to: :concept_id
    rename table(:plants), :form_id, to: :category_id

  end
end
