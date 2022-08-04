defmodule PawpubblecloneWeb.Plant_productControllerTest do
  use PawpubblecloneWeb.ConnCase

  import Pawpubbleclone.PlantFixtures

  @create_attrs %{name: "some name", price: "120.5"}
  @update_attrs %{name: "some updated name", price: "456.7"}
  @invalid_attrs %{name: nil, price: nil}

  describe "index" do
    test "lists all plants", %{conn: conn} do
      conn = get(conn, Routes.collection_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Plants"
    end
  end

  describe "new plant_product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.collection_path(conn, :new))
      assert html_response(conn, 200) =~ "New Personnalized collec"
    end
  end

  describe "create plant_product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.collection_path(conn, :create), plant_product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.collection_path(conn, :show, id)

      conn = get(conn, Routes.collection_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Personnalized collec"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.collection_path(conn, :create), plant_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Personnalized collec"
    end
  end

  describe "edit plant_product" do
    setup [:create_plant_product]

    test "renders form for editing chosen plant_product", %{conn: conn, plant_product: plant_product} do
      conn = get(conn, Routes.collection_path(conn, :edit, plant_product))
      assert html_response(conn, 200) =~ "Edit Personnalized collec"
    end
  end

  describe "update plant_product" do
    setup [:create_plant_product]

    test "redirects when data is valid", %{conn: conn, plant_product: plant_product} do
      conn = put(conn, Routes.collection_path(conn, :update, plant_product), plant_product: @update_attrs)
      assert redirected_to(conn) == Routes.collection_path(conn, :show, plant_product)

      conn = get(conn, Routes.collection_path(conn, :show, plant_product))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, plant_product: plant_product} do
      conn = put(conn, Routes.collection_path(conn, :update, plant_product), plant_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Personnalized collec"
    end
  end

  describe "delete plant_product" do
    setup [:create_plant_product]

    test "deletes chosen plant_product", %{conn: conn, plant_product: plant_product} do
      conn = delete(conn, Routes.collection_path(conn, :delete, plant_product))
      assert redirected_to(conn) == Routes.collection_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.collection_path(conn, :show, plant_product))
      end
    end
  end

  defp create_plant_product(_) do
    plant_product = plant_product_fixture()
    %{plant_product: plant_product}
  end
end
