defmodule Pawpubbleclone.Shopping.Shopping_session do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "shopping_sessions" do

    field :total, :decimal
    belongs_to :user, Pawpubbleclone.Accounts.User

    timestamps()
  end

  # def changeset(shopping_session, params \\ %{}) do
  #   shopping_session
  #   |> cast(params, [:total, :user_id])
  #   |> validate_required(:total, :user_id)
  #   |> assoc_constraint(:user)
  # end
end
