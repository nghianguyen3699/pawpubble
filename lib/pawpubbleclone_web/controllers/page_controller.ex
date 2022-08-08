defmodule PawpubblecloneWeb.PageController do
  use PawpubblecloneWeb, :controller
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Plants

  def index(conn, _params) do

    plants_recomment =
      Plants.get_products_recomment()
        |> Repo.preload([:category, :concept])

    render(conn, "index.html", plants_recomment: plants_recomment)
  end
end
