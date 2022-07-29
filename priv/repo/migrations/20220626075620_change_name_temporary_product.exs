defmodule Pawpubbleclone.Repo.Migrations.ChangeNameTemporaryProduct do
  use Ecto.Migration

  def change do
    rename table(:temporarySortProducts), to: table(:temporaryproducts)
  end
end
