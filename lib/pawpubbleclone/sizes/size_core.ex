defmodule Pawpubbleclone.Sizes.SizeCore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sizes" do
    field :name, :string

    timestamps()
  end

  def changeset(size, params \\ %{}) do
    size
    |> cast(params, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name)
  end
end
