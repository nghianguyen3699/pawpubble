defmodule Pawpubbleclone.PlantFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pawpubbleclone.Plant` context.
  """

  @doc """
  Generate a plant_product.
  """
  def plant_product_fixture(attrs \\ %{}) do
    {:ok, plant_product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: "120.5"
      })
      |> Pawpubbleclone.Plant.create_plant_product()

    plant_product
  end
end
