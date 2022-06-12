defmodule Pawpubbleclone.Repo.Migrations.AddRevenueAndNumberOfClicksToPlants do
  use Ecto.Migration

  def change do
    alter table(:plants) do
      add :revenue, :decimal
      add :number_click, :integer
    end
  end
end
