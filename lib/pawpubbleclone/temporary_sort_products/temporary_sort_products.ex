defmodule Pawpubbleclone.Temporary.TemporarySortProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "temporaryproducts" do
    belongs_to :product, Pawpubbleclone.Plant.Plant_product


    timestamps()
  end

  def changeset(concept, params \\ %{}) do
    concept
    |> cast(params, [:product_id])
    |> validate_required([:product_id])
  end
end
