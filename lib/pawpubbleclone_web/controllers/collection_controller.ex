defmodule PawpubblecloneWeb.CollectionController do
  use PawpubblecloneWeb, :controller

  import Plug.Conn
  import Pawpubbleclone.Plants
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Plant.Plant_product
  alias Pawpubbleclone.Colors
  alias Pawpubbleclone.Categorys
  alias Pawpubbleclone.Concepts
  alias Pawpubbleclone.Size_clothers

  plug :load_concepts_category when action in [:new, :create, :edit, :update]
  plug :load_colors_category when action in [:new, :create, :edit, :update]
  plug :load_sizes_category when action in [:new, :create, :edit, :update]
  plug :load_categorys_category when action in [:new, :create, :edit, :update]


  def index(conn, params) do
    first_concept = Concepts.get_concept(9).slug
    second_concept = Concepts.get_concept(10).slug
    concept_id =
      cond do
        params["concept"] == first_concept -> 9
        params["concept"] == second_concept -> 10
      end
    concept = Concepts.get_concept(concept_id)
    plants =
      case Map.keys(params) do
        ["category", "category_detail","concept", "filter"] -> get_products_base_target_category_name(concept_id,
                                                                                                      params["filter"],
                                                                                                      params["category"],
                                                                                                      params["category_detail"])
                                                                |> Repo.preload([:category, :color, :concept])
        ["concept", "category", "filter"] -> get_products_base_target_category(concept_id, params["filter"], params["category"])
                                    |> Repo.preload([:category, :color, :concept])
        ["concept", "filter"] -> get_products_base_target(concept_id, params["filter"])
                        |> Repo.preload([:category, :color, :concept])
        ["concept", "sort_color"] -> get_products_base_color(concept_id, params["sort_color"])
                            |> Repo.preload([:category, :color, :concept])
        ["concept", "sort"] -> sort_key = params["sort"]
                      case sort_key do
                        "lowestprice" -> get_products_base_atributes(concept_id)
                                          |> Repo.preload([:category, :color, :concept])
                                          |> Enum.sort_by(fn (p) -> p.price end, :asc)
                        "highestprice" -> get_products_base_atributes(concept_id)
                                          |> Repo.preload([:category, :color, :concept])
                                          |> Enum.sort_by(fn (p) -> p.price end, :desc)
                        "topselling" -> get_products_base_atributes(concept_id)
                                          |> Repo.preload([:category, :color, :concept])
                                          |> Enum.sort_by(fn (p) -> p.revenue end, :desc)
                      end
        ["concept"] -> get_products_base_atributes(concept_id)
                |> Repo.preload([:category, :color, :concept])
                |> Enum.shuffle()
      end

    colors = Colors.list_colors_base_concept(concept_id)
    targets = Categorys.get_category_target(concept_id)
    categorys =
      if params["filter"] do
        load_categorys_base_product(concept_id, params["filter"])
      else
          nil
      end
    render(conn, "index.html", concept: concept, plants: plants, colors: colors, targets: targets, categorys: categorys)
  end

  def new(conn, _) do
    changeset = change_plant_product(%Plant_product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plant_product" => plant_product_params}) do
    case create_plant_product(plant_product_params) do
      {:ok, plant_product} ->
        conn
        |> put_flash(:info, "Plant product created successfully.")
        |> redirect(to: Routes.collection_path(conn, :show, plant_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, params = %{"name" => name}) do
    first_concept = Concepts.get_concept(9).slug
    second_concept = Concepts.get_concept(10).slug
    concept_id =
      cond do
        params["concept"] == first_concept -> 9
        params["concept"] == second_concept -> 10
      end
    concept = Concepts.get_concept(concept_id)
    plant_categorys = get_all_categorys_base_products(concept_id, name)
                      |> Repo.preload([:category])
                      IO.inspect(plant_categorys)
    plant_product = get_plant_product_by_name!(name)
    personnalizeds_collec = get_all_plant_product_by_name!(name)
    render(conn, "show.html",  [concept: concept, name: name, plant_product: plant_product, all_plant_product: personnalizeds_collec, plant_categorys: plant_categorys])
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
        |> redirect(to: Routes.admin_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", plant_product: plant_product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plant_product = get_plant_product!(id)
    {:ok, _plant_product} = delete_plant_product(plant_product)

    conn
    |> put_flash(:info, "Plant product deleted successfully.")
    |> redirect(to: Routes.collection_path(conn, :index))
  end

  def create_cart(conn) do
    IO.inspect(conn)
    # case create_plant_product(plant_product_params) do
    #   {:ok, plant_product} ->
    #     conn
    #     |> put_flash(:info, "Plant product created successfully.")
    #     |> redirect(to: Routes.collection_path(conn, :show, plant_product))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end


end
