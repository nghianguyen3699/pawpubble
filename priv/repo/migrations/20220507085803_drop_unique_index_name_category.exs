defmodule Pawpubbleclone.Repo.Migrations.DropUniqueIndexNameCategory do
  use Ecto.Migration

  def up do
    drop index("categorys", [:name])
  end
end
