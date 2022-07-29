defmodule PawpubblecloneWeb.Plant_productController do
  use PawpubblecloneWeb, :controller

  import Plug.Conn
  import Pawpubbleclone.Plants
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Plant.Plant_product
  alias Pawpubbleclone.Colors
  alias Pawpubbleclone.Categorys

  plug :load_concepts_category when action in [:new, :create, :edit, :update]
  plug :load_colors_category when action in [:new, :create, :edit, :update]
  plug :load_sizes_category when action in [:new, :create, :edit, :update]
  plug :load_categorys_category when action in [:new, :create, :edit, :update]


  def index(conn, params) do
    IO.inspect(Map.keys(params))

    plants =
      case Map.keys(params) do
        ["category", "category_detail", "filter"] -> get_products_base_target_category_name(params["filter"], params["category"], params["category_detail"])
        ["category", "filter"] -> get_products_base_target_category(params["filter"], params["category"])
                                    |> Repo.preload([:category, :color, :concept])
        ["filter"] -> get_products_base_target(params["filter"])
                        |> Repo.preload([:category, :color, :concept])
        ["sort_color"] -> get_products_base_color(params["sort_color"])
                            |> Repo.preload([:category, :color, :concept])
        ["sort"] -> sort_key = params["sort"]
                      case sort_key do
                        "lowestprice" -> get_products_base_atributes()
                                          |> Repo.preload([:category, :color, :concept])
                                          |> Enum.sort_by(fn (p) -> p.price end, :asc)
                        "highestprice" -> get_products_base_atributes()
                                          |> Repo.preload([:category, :color, :concept])
                                          |> Enum.sort_by(fn (p) -> p.price end, :desc)
                        "topselling" -> get_products_base_atributes()
                                          |> Repo.preload([:category, :color, :concept])
                                          |> Enum.sort_by(fn (p) -> p.revenue end, :desc)
                      end
        [] -> get_products_base_atributes()
                |> Repo.preload([:category, :color, :concept])
                |> Enum.shuffle()
      end



    colors = Colors.list_colors()
    targets = Categorys.get_category_target()
    categorys =
      if params["filter"] do
        load_categorys_base_product(params["filter"])
      else
         nil
      end
    # IO.inspect(targets)
    render(conn, "index.html", plants: plants, colors: colors, targets: targets, categorys: categorys)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = change_plant_product(%Plant_product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plant_product" => plant_product_params}) do
    case create_plant_product(plant_product_params) do
      {:ok, plant_product} ->
        conn
        |> put_flash(:info, "Plant product created successfully.")
        |> redirect(to: Routes.plant_product_path(conn, :show, plant_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"name" => name}) do
    plant_categorys = get_all_categorys_base_products(name)
                      |> Repo.preload([:category])
    plant_product = get_plant_product_by_name!(name)
    personnalizeds_collec = get_all_plant_product_by_name!(name)
    render(conn, "show.html",  [plant_product: plant_product, all_plant_product: personnalizeds_collec, plant_categorys: plant_categorys])
  end
  # def show_concept(conn) do
  #   # IO.inspect(name)
  #   # plant_product = Plant.get_plant_product_by_name!(name)
  #   render(conn, "show_concept.html", plant_product: Plant_product)
  # end

  def edit(conn, %{"id" => id}) do
    plant_product = get_plant_product!(id)
    changeset = change_plant_product(plant_product)
    render(conn, "edit.html", plant_product: plant_product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plant_product" => plant_product_params}) do
    plant_product = get_plant_product!(id)

    case update_plant_product(plant_product, plant_product_params) do
      {:ok, plant_product} ->
        conn
        |> put_flash(:info, "Plant product updated successfully.")
        |> redirect(to: Routes.plant_product_path(conn, :show, plant_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", plant_product: plant_product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plant_product = get_plant_product!(id)
    {:ok, _plant_product} = delete_plant_product(plant_product)

    conn
    |> put_flash(:info, "Plant product deleted successfully.")
    |> redirect(to: Routes.plant_product_path(conn, :index))
  end

  def create_cart(conn) do
    IO.inspect(conn)
    # case create_plant_product(plant_product_params) do
    #   {:ok, plant_product} ->
    #     conn
    #     |> put_flash(:info, "Plant product created successfully.")
    #     |> redirect(to: Routes.plant_product_path(conn, :show, plant_product))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end


end
