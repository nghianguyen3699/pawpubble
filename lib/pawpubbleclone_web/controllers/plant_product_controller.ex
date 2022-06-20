defmodule PawpubblecloneWeb.Plant_productController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Plants
  alias Pawpubbleclone.Plant.Plant_product
  alias Pawpubbleclone.{Concepts, Colors, Sizes, Categorys}
  plug :authenticate_user when action in [:index, :show]
  plug :load_concepts_category when action in [:new, :create, :edit, :update]
  plug :load_colors_category when action in [:new, :create, :edit, :update]
  plug :load_sizes_category when action in [:new, :create, :edit, :update]
  plug :load_categorys_category when action in [:new, :create, :edit, :update]


  def index(conn, _params) do
    plants =
      Plants.get_products_base_category()
      |> Repo.preload([:category, :color, :concept])
    colors = Colors.list_colors()
    render(conn, "index.html", plants: plants, colors: colors)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Plants.change_plant_product(%Plant_product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plant_product" => plant_product_params}) do
    case Plants.create_plant_product(plant_product_params) do
      {:ok, plant_product} ->
        conn
        |> put_flash(:info, "Plant product created successfully.")
        |> redirect(to: Routes.plant_product_path(conn, :show, plant_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"name" => name}) do
    plant_categorys = Plants.get_products_base_category()
    plant_product = Plants.get_plant_product_by_name!(name)
    personnalizeds_collec = Plants.get_all_plant_product_by_name!(name)
    render(conn, "show.html",  [plant_product: plant_product, all_plant_product: personnalizeds_collec, plant_categorys: plant_categorys])
  end
  # def show_concept(conn) do
  #   # IO.inspect(name)
  #   # plant_product = Plant.get_plant_product_by_name!(name)
  #   render(conn, "show_concept.html", plant_product: Plant_product)
  # end

  def edit(conn, %{"id" => id}) do
    plant_product = Plants.get_plant_product!(id)
    changeset = Plants.change_plant_product(plant_product)
    render(conn, "edit.html", plant_product: plant_product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plant_product" => plant_product_params}) do
    plant_product = Plants.get_plant_product!(id)

    case Plants.update_plant_product(plant_product, plant_product_params) do
      {:ok, plant_product} ->
        conn
        |> put_flash(:info, "Plant product updated successfully.")
        |> redirect(to: Routes.plant_product_path(conn, :show, plant_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", plant_product: plant_product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plant_product = Plants.get_plant_product!(id)
    {:ok, _plant_product} = Plants.delete_plant_product(plant_product)

    conn
    |> put_flash(:info, "Plant product deleted successfully.")
    |> redirect(to: Routes.plant_product_path(conn, :index))
  end

  def create_cart(conn) do
    IO.inspect(conn)
    # case Plants.create_plant_product(plant_product_params) do
    #   {:ok, plant_product} ->
    #     conn
    #     |> put_flash(:info, "Plant product created successfully.")
    #     |> redirect(to: Routes.plant_product_path(conn, :show, plant_product))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end


  defp load_concepts_category(conn, _) do
      assign(conn, :concepts, Concepts.list_concepts())
  end
  defp load_colors_category(conn, _) do
      assign(conn, :colors, Colors.list_colors())
  end
  defp load_sizes_category(conn, _) do
      assign(conn, :sizes, Sizes.list_sizes())
  end
  defp load_categorys_category(conn, _) do
      assign(conn, :categorys, Categorys.list_categorys())
  end

end
