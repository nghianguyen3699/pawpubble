defmodule Pawpubbleclone.Repo.Migrations.AddImgToCategory do
  use Ecto.Migration

  def change do
    alter table(:categorys) do
      add :img, :string
    end
  end
end
