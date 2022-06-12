defmodule Pawpubbleclone.Repo.Migrations.AddCodeToColors do
  use Ecto.Migration

  def change do
    alter table(:colors) do
      add :code, :string

    end
  end
end
