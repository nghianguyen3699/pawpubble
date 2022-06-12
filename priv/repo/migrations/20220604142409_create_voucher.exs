defmodule Pawpubbleclone.Repo.Migrations.CreateVoucher do
  use Ecto.Migration

  def change do
    create table(:vouchers) do
      add :name, :string
      add :value, :decimal
      add :time_start, :utc_datetime
      add :time_end, :utc_datetime

      timestamps()
    end
  end
end
