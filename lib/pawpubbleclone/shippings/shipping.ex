defmodule Pawpubbleclone.Shipping.Shippings do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Phoenix.Param, key: :name}

  schema "shippings" do
    field :name, :string
    field :value, :decimal

    timestamps()
  end

  def changeset(concept, params \\ %{}) do
    concept
    |> cast(params, [:name, :value])
    |> validate_required([:name, :value])
    |> unique_constraint([:name])
  end
end
