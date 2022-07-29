defmodule Pawpubbleclone.Temporary.TemporarySort do
  use Ecto.Schema
  import Ecto.Changeset

  schema "temporarysort" do
    belongs_to :concept, Pawpubbleclone.Concepts.ConceptCore
    belongs_to :category, Pawpubbleclone.Categorys.CategoryCore
    belongs_to :color, Pawpubbleclone.Colors.ColorCore
    belongs_to :size, Pawpubbleclone.Sizes.SizeCore


    timestamps()
  end

  def changeset(concept, params \\ %{}) do
    concept
    |> cast(params, [:concept_id, :category_id, :color_id, :size_id])
    # |> validate_required([:concept_id, :category_id, :color_id, :size_id])
  end
end
