defmodule PawpubblecloneWeb.Api.ColorView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{colors: colors}) do
    %{data: render_many(colors, PawpubblecloneWeb.Api.ColorView, "color.json")}
  end
  def render("show.json", %{color: color}) do
    %{data: render_one(color, PawpubblecloneWeb.Api.ColorView, "color.json")}
  end


  def render("color.json", %{color: color}) do
    %{
      id: color.id,
      name: color.name,
      code: color.code,
      rgb: color.rgb
    }
  end
end
