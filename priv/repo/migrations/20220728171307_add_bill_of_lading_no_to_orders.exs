defmodule Pawpubbleclone.Repo.Migrations.AddBillOfLadingNoToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :bill_of_lading_no, :string
    end
  end
end
