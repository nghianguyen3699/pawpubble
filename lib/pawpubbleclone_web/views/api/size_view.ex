defmodule PawpubblecloneWeb.Api.SizeView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{sizes: sizes}) do
    %{data: render_many(sizes, PawpubblecloneWeb.Api.SizeView, "size.json")}
  end
  def render("show.json", %{size: size}) do
    %{data: render_one(size, PawpubblecloneWeb.Api.SizeView, "size.json")}
  end


  def render("size.json", %{size: size}) do
    %{
      id: size.id,
      name: size.name
    }
  end
end
