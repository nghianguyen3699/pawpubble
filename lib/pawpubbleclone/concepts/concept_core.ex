defmodule Pawpubbleclone.Concepts.ConceptCore do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Phoenix.Param, key: :name}

  schema "concepts" do
    field :name, :string
    field :slug, :string
    field :decription, :string

    timestamps()
  end

  def changeset(concept, params \\ %{}) do
    concept
    |> cast(params, [:name, :slug, :decription])
    |> validate_required([:name, :slug, :decription])
    |> unique_constraint([:name, :slug, :decription])
  end
end
