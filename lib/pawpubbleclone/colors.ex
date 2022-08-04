defmodule Pawpubbleclone.Colors do

  import Ecto.Query
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Colors.ColorCore
  alias Pawpubbleclone.Plant.Plant_product

  def get_color(id) do
    Repo.get(ColorCore, id)
  end

  def get_color!(name) do
    Repo.get_by!(ColorCore, %{name: name})
  end

  def get_color_by(params) do
    Repo.get_by(ColorCore, params)
  end

  def list_colors() do
    Repo.all(ColorCore)
  end

  def list_colors_base_concept(concept_id) do
    colors =
      from(p in Plant_product, where: p.concept_id == ^concept_id, select: p.color_id)
        |> Repo.all()
        |> Enum.uniq_by(fn c -> c end)
        |> Enum.reject(&is_nil/1)
    for i <- colors do
      get_color(i)
    end
  end

  def create_color(atts \\ %{}) do
    %ColorCore{}
    |> ColorCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%ColorCore{} = color) do
    Repo.delete(color)
  end
end
