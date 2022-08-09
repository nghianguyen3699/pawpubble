defmodule Pawpubbleclone.Repo.Migrations.ChangeTypeRevenueUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :revenue, :float
    end
  end
end
