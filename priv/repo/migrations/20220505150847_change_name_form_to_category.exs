defmodule Pawpubbleclone.Repo.Migrations.ChangeNameFormToCategory do
  use Ecto.Migration

  def change do
    rename table(:forms), to: table(:categorys)
  end
end
