defmodule Pawpubbleclone.Repo.Migrations.AddRevenueToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :revenue, :decimal
    end
  end
end
