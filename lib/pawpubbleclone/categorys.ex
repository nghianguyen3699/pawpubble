defmodule Pawpubbleclone.Categorys do

  import Ecto.Query
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Categorys.CategoryCore
  alias Pawpubbleclone.Plant.Plant_product
  alias Pawpubbleclone.Plants

  def get_category(id) do
    Repo.get(CategoryCore, id)
  end

  def get_category!(name) do
    Repo.get_by!(CategoryCore, %{name: name})
  end

  def get_category_by(params) do
    Repo.get_by(CategoryCore, params)
  end

  def get_category_target(concept_id) do
    targets =
      # from( c in CategoryCore, select: { c.id, c.target })
      #  |> Repo.all()
      #  |> Enum.uniq_by(fn {_, x} -> {x} end)
      from( c in Plant_product, where: c.concept_id == ^concept_id, select: { c.id, c.category_id })
        |> Repo.all()
        |> Enum.uniq_by(fn {_, x} -> {x} end)

      for {x, _,} <- targets do
        product =
          x
            |> Plants.get_plant_product!()
            |> Repo.preload(:category)
        product.category.target
      end
      |> Enum.uniq_by(fn x -> x end)
  end

  def get_category_name(filter) do
    # categorys_name =
      from( c in CategoryCore, where: c.target == ^filter, select: {c.id, c.target, c.category, c.name})
        |> Repo.all()
        |> Enum.uniq_by(fn {_, _, _, z} -> { z} end)
  end

  def list_categorys() do
    Repo.all(CategoryCore)
  end

  def create_category(atts \\ %{}) do
    %CategoryCore{}
    |> CategoryCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%CategoryCore{} = category) do
    Repo.delete(category)
  end
end
