defmodule Pawpubbleclone.Repo.Migrations.ChangeNameColumnCart do
  use Ecto.Migration

  def change do
    rename table(:carts), :session_id, to: :user_id
  end
end
