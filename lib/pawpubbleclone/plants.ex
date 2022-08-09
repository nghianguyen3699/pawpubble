defmodule Pawpubbleclone.Plants do
  @moduledoc """
  The Plant context.
  """
  import Plug.Conn

  import Ecto.Query, warn: false
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.{Concepts, Colors, Sizes, Categorys}
  alias Pawpubbleclone.Plant.Plant_product
  alias Pawpubbleclone.Categorys.CategoryCore


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

  def get_plant_product_by_concept(params) do
    #   Enum.random(1..100)
    query_name_products = from(p in Plant_product, where: p.concept_id == ^params, select: p.name)
      |> Repo.all()
      |> Enum.uniq_by(fn x -> x end)
    IO.inspect(Enum.at(query_name_products, 0))
    list =
      for p <- 0..(Enum.count(query_name_products) - 1)  do
        index_name = Enum.at(query_name_products, p)
        query = from(p in Plant_product, where: p.name == ^index_name, select: {p.id, p.category_id, p.color_id})
          |> Repo.all()
          |> Enum.uniq_by(fn {_, x, y} -> {x, y} end)
          |> Enum.map(fn {x, _, _} -> x end)
        list_product =
          for i <- 1..2 do
            random_id = Enum.random(query)
            from(q in Plant_product, where: q.id == ^random_id, select: q)
            |> Repo.all()
          end
        Enum.map(list_product, fn [i] -> i end)
      end
     |> List.flatten() |> Repo.preload([:category, :concept, :color, :size])
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


  def update_plant_product(%Plant_product{} = plant_product, atts) do
    plant_product
    |> Plant_product.changeset(atts)
    # |> IO.inspect()
    |> Repo.update()
  end

  def delete_plant_product(%Plant_product{} = plant_product) do
    Repo.delete(plant_product)
  end

  def get_products_base_atributes(concept_id) do
    products =
    from( i in Plant_product, where: i.concept_id == ^concept_id, select: {i.id, i.category_id, i.name, i.color_id, i.price })
     |> Repo.all()
     |> Enum.uniq_by(fn {_, x, y, z, _} -> {x, y, z} end)

    for {x, _, _, _, _} <- products do
      x
       |> get_plant_product!()
    end
  end

  def get_products_base_color(concept_id, colors_id) do
    # query = Enum.map(String.split(colors_id, "_"), fn x -> {:color_id, x} end)
    products =
      for c <- String.split(colors_id, "_") do
        from( i in Plant_product, where: i.concept_id == ^concept_id and i.color_id == ^c, select: {i.id, i.category_id, i.name, i.color_id})
         |> Repo.all()
         |> Enum.uniq_by(fn {_, x, y, z} -> {x, y, z} end)
      end
      |> List.flatten()
    for {x, _, _, _} <- products do
      x
        |> get_plant_product!()
    end
  end

  def get_all_categorys_base_products(concept_id, name) do
    categorys =
      from(i in Plant_product, where: i.concept_id == ^concept_id and i.name == ^name, select: {i.id, i.category_id, i.name})
       |> Repo.all()
       |> Enum.uniq_by(fn {_, x, y} -> {x, y} end)

    for {x, _, _} <- categorys do
      x
      |> get_plant_product!()
    end
  end

  def get_products_base_target(concept_id, target_name) do
    # Categorys.list_categorys()
    products =
        from( i in Plant_product, join: c in CategoryCore,
                                  on: c.target == ^target_name,
                                  where: i.concept_id == ^concept_id and c.id == i.category_id,
                                  select: {i.id, c.target, i.category_id, i.name, i.color_id})
         |> Repo.all()
         |> Enum.uniq_by(fn {_, _, y, z, t} -> { y, z, t} end)

    for {x, _, _, _, _} <- products do
      x
      |> get_plant_product!()
    end
  end

  def get_products_base_target_category(concept_id, target_name, category_name) do
    IO.inspect(category_name)
    products =
      for d <- String.split(category_name, "_")  do
        from( i in Plant_product, join: c in CategoryCore,
                                  on: c.target == ^target_name and c.category == ^d,
                                  where: i.concept_id == ^concept_id and c.id == i.category_id,
                                  select: {i.id, c.target, i.category_id, i.name, i.color_id})
           |> Repo.all()
           |> Enum.uniq_by(fn {_, _, y, z, t} -> { y, z, t} end)
      end
      |> List.flatten()
    for {x, _, _, _, _} <- products do
      x
        |> get_plant_product!()
    end
  end

  def get_products_base_target_category_name(concept_id, target_name, category_name, category_detail) do
    # IO.inspect(category_name)
    products =
    for d <- String.split(category_name, "_")  do
      for n <- String.split(category_detail, "_")  do
        IO.inspect(d)
        from( i in Plant_product, join: c in CategoryCore,
                                  on: c.target == ^target_name and c.category == ^d and c.name == ^n,
                                  where: i.concept_id == ^concept_id and c.id == i.category_id,
                                  select: {i.id, c.target, i.category_id, i.name, i.color_id})
           |> Repo.all()
           |> Enum.uniq_by(fn {_, _, y, z, t} -> { y, z, t} end)
      end
    end
      |> List.flatten()
    for {x, _, _, _, _} <- products do
      x
        |> get_plant_product!()
    end
  end

  def get_products_recomment() do
    name_products =
      from( p in Plant_product, select: p.name )
        |> Repo.all()
        |> Enum.uniq_by(fn x -> x end)
    for n <- name_products do
      from( p in Plant_product, where: p.name == ^n, order_by: p.revenue )
        |> Repo.all()
        |> hd()
    end
  end

  def load_categorys_base_product(concept_id, category) do
    categorys =
      from( i in Plant_product, where: i.concept_id == ^concept_id, select: {i.id, i.category_id})
       |> Repo.all()
       |> Enum.uniq_by(fn {_,x} -> {x} end)
    categorys
        |> Enum.map(fn {x, _} -> x |> get_plant_product!() |> Repo.preload(:category) end)
        |> Enum.map(fn x -> [x.id, x.category.target, x.category.category, x.category.name] end)
        |> Enum.uniq_by(fn [_, _, _, x] ->  [x] end )
        |> Enum.map(fn x -> if Enum.at(x, 1) == category do x end end )
        |> Enum.filter(& !is_nil(&1))

  end

  def get_total_revenue() do
    Enum.map(list_plants, fn x -> x.revenue end)
    |> Enum.filter(& !is_nil(&1))
    |> Enum.reduce(fn p, acc -> p + acc end)
    |> trunc()
  end

  def change_plant_product(%Plant_product{} = plant_product, attrs \\ %{}) do
    Plant_product.changeset(plant_product, attrs)
  end

  def load_concepts_category(conn, _) do
    assign(conn, :concepts, Concepts.list_concepts())
  end

  def load_colors_category(conn, _) do
      assign(conn, :colors, Colors.list_colors())
  end

  def load_sizes_category(conn, _) do
      assign(conn, :sizes, Sizes.list_sizes())
  end

  def load_categorys_category(conn, _) do
      assign(conn, :categorys, Categorys.list_categorys())
  end
end
