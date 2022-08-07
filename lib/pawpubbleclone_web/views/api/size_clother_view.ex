defmodule PawpubblecloneWeb.Api.SizeClotherView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{size_clothers: size_clothers}) do
    %{data: render_many(size_clothers, PawpubblecloneWeb.Api.SizeClotherView, "size_clother.json")}
  end
  def render("show.json", %{size_clother: size_clother}) do
    %{data: render_one(size_clother, PawpubblecloneWeb.Api.SizeClotherView, "size_clother.json")}
  end


  def render("size_clother.json", %{size_clother: size_clother}) do
    %{
      id: size_clother.id,
      category: size_clother.category.name,
      size: size_clother.size.name,
      shirt_length_in: size_clother.shirt_length_in,
      chest_width_in: size_clother.chest_width_in,
      shirt_length_cm: size_clother.shirt_length_cm,
      chest_width_cm: size_clother.chest_width_cm
    }
  end
end
