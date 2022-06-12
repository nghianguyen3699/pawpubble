defmodule Pawpubbleclone.PlantTest do
  use Pawpubbleclone.DataCase

  alias Pawpubbleclone.Plant

  describe "plants" do
    alias Pawpubbleclone.Plant.Plant_product

    import Pawpubbleclone.PlantFixtures

    @invalid_attrs %{name: nil, price: nil}

    test "list_plants/0 returns all plants" do
      plant_product = plant_product_fixture()
      assert Plant.list_plants() == [plant_product]
    end

    test "get_plant_product!/1 returns the plant_product with given id" do
      plant_product = plant_product_fixture()
      assert Plant.get_plant_product!(plant_product.id) == plant_product
    end

    test "create_plant_product/1 with valid data creates a plant_product" do
      valid_attrs = %{name: "some name", price: "120.5"}

      assert {:ok, %Plant_product{} = plant_product} = Plant.create_plant_product(valid_attrs)
      assert plant_product.name == "some name"
      assert plant_product.price == Decimal.new("120.5")
    end

    test "create_plant_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plant.create_plant_product(@invalid_attrs)
    end

    test "update_plant_product/2 with valid data updates the plant_product" do
      plant_product = plant_product_fixture()
      update_attrs = %{name: "some updated name", price: "456.7"}

      assert {:ok, %Plant_product{} = plant_product} = Plant.update_plant_product(plant_product, update_attrs)
      assert plant_product.name == "some updated name"
      assert plant_product.price == Decimal.new("456.7")
    end

    test "update_plant_product/2 with invalid data returns error changeset" do
      plant_product = plant_product_fixture()
      assert {:error, %Ecto.Changeset{}} = Plant.update_plant_product(plant_product, @invalid_attrs)
      assert plant_product == Plant.get_plant_product!(plant_product.id)
    end

    test "delete_plant_product/1 deletes the plant_product" do
      plant_product = plant_product_fixture()
      assert {:ok, %Plant_product{}} = Plant.delete_plant_product(plant_product)
      assert_raise Ecto.NoResultsError, fn -> Plant.get_plant_product!(plant_product.id) end
    end

    test "change_plant_product/1 returns a plant_product changeset" do
      plant_product = plant_product_fixture()
      assert %Ecto.Changeset{} = Plant.change_plant_product(plant_product)
    end
  end
end
