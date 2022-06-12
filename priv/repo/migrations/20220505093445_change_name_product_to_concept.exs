defmodule Pawpubbleclone.Repo.Migrations.ChangeNameProductToConcept do
  use Ecto.Migration

  def change do
    rename table(:products), to: table(:concepts)
  end
end
