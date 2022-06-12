defmodule Pawpubbleclone.Concepts.ConceptCore do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Phoenix.Param, key: :name}

  schema "concepts" do
    field :name, :string

    timestamps()
  end

  def changeset(concept, params \\ %{}) do
    concept
    |> cast(params, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name)
  end
end
