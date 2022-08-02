defmodule PawpubblecloneWeb.PageController do
  use PawpubblecloneWeb, :controller
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Plants

  def index(conn, _params) do

    plants =
    for i <- [30, 157, 306, 307] do
      Repo.preload(Plants.get_plant_product!(i), [:category])

    end
    render(conn, "index.html", plants: plants)
  end
end
