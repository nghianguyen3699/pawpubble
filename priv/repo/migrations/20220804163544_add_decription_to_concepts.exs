defmodule Pawpubbleclone.Repo.Migrations.AddDecriptionToConcepts do
  use Ecto.Migration

  def change do
    alter table(:concepts) do
      add :decription, :string
    end
  end
end
