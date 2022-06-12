defmodule Pawpubbleclone.Repo.Migrations.AddDescriptionToCategory do
  use Ecto.Migration

  def change do
    alter table(:categorys) do
      add :description, :string
    end
  end
end
