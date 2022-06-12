defmodule PawpubblecloneWeb.Api.ColorController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Colors

  def index(conn, _params) do
    colors = Colors.list_colors()
    render(conn, "index.json", colors: colors)
  end

  def show(conn, %{"id" => id}) do
    color = Colors.get_color(id)
    render(conn, "show.json", color: color)
  end
end
