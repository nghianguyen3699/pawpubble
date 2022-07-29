defmodule Pawpubbleclone.Repo.Migrations.AddGenderAndBirthdayToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :gender, :string
      add :birthday, :utc_datetime
    end
  end
end
