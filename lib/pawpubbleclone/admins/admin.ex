defmodule Pawpubbleclone.Accounts.Admins do
  use Ecto.Schema
  import Ecto.Changeset

  schema "admins" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :code, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:password_hash, :email, :name, :code])
    |> validate_required(:email)
  end
end
