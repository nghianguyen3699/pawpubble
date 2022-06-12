defmodule Pawpubbleclone.Plants do
  @moduledoc """
  The Plant context.
  """

  import Ecto.Query, warn: false
  alias Pawpubbleclone.Repo

  alias Pawpubbleclone.Plant.Plant_product


  def list_plants do
    Repo.all(Plant_product)
  end

  def list_plants_association do
    list_plants().preload
  end

  def get_plant_product!(id), do: Repo.get!(Plant_product, id)


  def get_plant_product_by_name!(params) do
    query = from p in Plant_product, where: p.name == ^params, select: p
    Repo.all(query)
    hd(Repo.all(query))
  end

  def get_plant_product_by_sku!(sku) do
    # IO.inspect(sku)
    Repo.get_by!(Plant_product, %{sku: sku})
  end

  def get_all_plant_product_by_name!(params) do
    query = from p in Plant_product, where: p.name == ^params, select: p
    Repo.all(query)
  end

  def get_product_home_page() do

  end

  def create_plant_product(attrs \\ %{}) do
    %Plant_product{}
    |> Plant_product.changeset(attrs)
    # |> Ecto.Changeset.put_assoc(:product, product)
    # |> Ecto.Changeset.put_assoc(:form, form)
    # |> Ecto.Changeset.put_assoc(:size, size)
    # |> Ecto.Changeset.put_assoc(:color, color)
    |> Repo.insert()
  end


  def update_plant_product(%Plant_product{} = plant_product, attrs) do
    plant_product
    |> Plant_product.changeset(attrs)
    |> Repo.update()
  end

  def delete_plant_product(%Plant_product{} = plant_product) do
    Repo.delete(plant_product)
  end


  def change_plant_product(%Plant_product{} = plant_product, attrs \\ %{}) do
    Plant_product.changeset(plant_product, attrs)
  end
end
