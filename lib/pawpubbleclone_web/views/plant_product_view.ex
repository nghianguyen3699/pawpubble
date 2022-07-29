defmodule PawpubblecloneWeb.Plant_productView do

  use PawpubblecloneWeb, :view

  alias Pawpubbleclone.Repo
  # alias Pawpubbleclone.Categorys
  alias Pawpubbleclone.Plants

  def category_select_options(options) do
    for option <- options, do: {option.name, option.id}
  end

  def get_only_category(categorys) do
    category_list =
      categorys
      |> Enum.uniq_by(fn [_, _, x, _] -> [x] end)
      for [x, _, _, _] <- category_list do
        x
        |> Plants.get_plant_product!()
        |> Repo.preload(:category)
      end
  end

  def get_only_category_name(categorys, category) do
    for [x, _, y, _] <- categorys do
      if y == category do
        x
        |> Plants.get_plant_product!()
        |> Repo.preload(:category)
      end
    end
     |> Enum.filter(& !is_nil(&1))
  end



end
