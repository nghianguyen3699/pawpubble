defmodule PawpubblecloneWeb.Api.CategoryView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{categorys: categorys}) do
    %{data: render_many(categorys, PawpubblecloneWeb.Api.CategoryView, "category.json")}
  end
  def render("show.json", %{category: category}) do
    %{data: render_one(category, PawpubblecloneWeb.Api.CategoryView, "category.json")}
  end


  def render("category.json", %{category: category}) do
    %{
      target: category.target,
      category: category.category,
      name: category.name,
      description: category.description,
      img: category.img
    }
  end
end
