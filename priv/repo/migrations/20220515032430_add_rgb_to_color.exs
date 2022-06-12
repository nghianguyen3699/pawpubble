defmodule Pawpubbleclone.Repo.Migrations.AddRgbToColor do
  use Ecto.Migration

  def change do
    alter table(:colors) do
      add :rgb, :string
    end
  end
end
