defmodule Pawpubbleclone.Colors.ColorCore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "colors" do
    field :name, :string
    field :code, :string
    field :rgb, :string
    timestamps()
  end

  def changeset(color, params \\ %{}) do
    color
    |> cast(params, [:name, :code, :rgb])
    |> validate_required([:name, :code, :rgb])
    |> unique_constraint([:name, :code, :rgb])
  end
end
