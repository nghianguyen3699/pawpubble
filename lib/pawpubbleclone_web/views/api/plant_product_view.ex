defmodule PawpubblecloneWeb.Api.Plant_productView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{plants: plants}) do
    %{data: render_many(plants, PawpubblecloneWeb.Api.Plant_productView, "plant_product.json")}
  end
  def render("show.json", %{plant: plant}) do
    %{data: render_one(plant, PawpubblecloneWeb.Api.Plant_productView, "plant_product.json")}
  end


  def render("plant_product.json", %{plant_product: plant_product}) do
    # require IEx;
    # IEx.pry
    %{
      id: plant_product.id,
      name: plant_product.name,
      price: plant_product.price,
      sku: plant_product.sku,
      img: plant_product.img,
      quantity: plant_product.quantity,
      revenue: plant_product.revenue,
      number_click: plant_product.number_click,
      color: render_one(plant_product.color, PawpubblecloneWeb.Api.ColorView, "color.json"),
      size: render_one(plant_product.size, PawpubblecloneWeb.Api.SizeView, "size.json"),
      category: render_one(plant_product.category, PawpubblecloneWeb.Api.CategoryView, "category.json"),
      concept: render_one(plant_product.concept, PawpubblecloneWeb.Api.ConceptView, "concept.json")
    }
  end
end
