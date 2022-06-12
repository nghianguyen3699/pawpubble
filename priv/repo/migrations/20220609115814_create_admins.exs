defmodule Pawpubbleclone.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :code, :string

      timestamps()
    end
  end
end
