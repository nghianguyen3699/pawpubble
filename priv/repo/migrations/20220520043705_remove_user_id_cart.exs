defmodule Pawpubbleclone.Repo.Migrations.RemoveUserIdCart do
  use Ecto.Migration

  def change do
    alter table(:carts) do
      remove :user_id
      add :user_id, references(:users, on_delete: :nothing)

    end
  end
end
