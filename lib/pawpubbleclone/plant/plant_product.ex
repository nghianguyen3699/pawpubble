defmodule Pawpubbleclone.Plant.Plant_product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plants" do
    field :name, :string
    field :price, :decimal
    field :sku, :string
    field :img, :string
    field :quantity, :integer
    field :revenue, :decimal
    field :number_click, :integer
    belongs_to :concept, Pawpubbleclone.Concepts.ConceptCore
    belongs_to :color, Pawpubbleclone.Colors.ColorCore
    belongs_to :size, Pawpubbleclone.Sizes.SizeCore
    belongs_to :category, Pawpubbleclone.Categorys.CategoryCore

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(plant_product, attrs) do
    plant_product
    |> cast(attrs, [:name, :price, :sku, :img, :quantity, :concept_id, :color_id, :size_id, :category_id, :revenue, :number_click])
    |> validate_required([:name, :price, :sku, :img, :quantity])
    |> assoc_constraint(:concept)
    |> assoc_constraint(:color)
    |> assoc_constraint(:size)
    |> assoc_constraint(:category)
  end
end
