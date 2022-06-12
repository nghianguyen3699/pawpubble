defmodule PawpubblecloneWeb.Api.Plant_productController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Plants
  alias Pawpubbleclone.Repo
  def index(conn, _params) do
    plants = Repo.preload(Plants.list_plants, [:concept, :size, :color, :category])
    # require IEx;
    # IEx.pry
    render(conn, "index.json", plants: plants)
  end

  def show(conn, %{"id" => id}) do
    plant = Plants.get_plant_product!(id)
    render(conn, "show.json", plant: plant)
  end
end
