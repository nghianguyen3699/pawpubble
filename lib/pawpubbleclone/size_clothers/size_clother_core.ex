defmodule Pawpubbleclone.SizeClother.SizeClotherCore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "size_clothers" do
    field :shirt_length_in, :integer
    field :chest_width_in, :integer
    field :shirt_length_cm, :integer
    field :chest_width_cm, :integer
    belongs_to :size, Pawpubbleclone.Sizes.SizeCore
    belongs_to :category, Pawpubbleclone.Categorys.CategoryCore

    timestamps()
  end

  def changeset(size_clother, params \\ %{}) do
    size_clother
    |> cast(params, [:shirt_length_in, :chest_width_in, :shirt_length_cm, :chest_width_cm, :size_id, :category_id])
    |> validate_required([:shirt_length_in, :chest_width_in, :shirt_length_cm, :chest_width_cm, :size_id, :category_id])
  end
end
