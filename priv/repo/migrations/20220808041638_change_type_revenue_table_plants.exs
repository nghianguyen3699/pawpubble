defmodule Pawpubbleclone.Repo.Migrations.ChangeTypeRevenueTablePlants do
  use Ecto.Migration

  def change do
    alter table(:plants) do
      modify :revenue, :float
    end
  end
end
