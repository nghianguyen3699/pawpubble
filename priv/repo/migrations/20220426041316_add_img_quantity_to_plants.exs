defmodule Pawpubbleclone.Repo.Migrations.AddImgQuantityToPlants do
  use Ecto.Migration

  def change do
    alter table(:personalizeds) do
      add :img, :string
      add :quantity, :integer

    end
  end
end
