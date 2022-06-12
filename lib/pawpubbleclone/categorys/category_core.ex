defmodule Pawpubbleclone.Categorys.CategoryCore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categorys" do
    field :target, :string
    field :category, :string
    field :name, :string
    field :description, :string
    field :img, :string

    timestamps()
  end

  def changeset(category, params \\ %{}) do
    category
    |> cast(params, [:target, :category, :name, :description, :img])
    |> validate_required([:target, :category, :name, :description, :img])
  end
end
