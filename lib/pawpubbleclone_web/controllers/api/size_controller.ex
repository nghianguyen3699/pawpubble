defmodule PawpubblecloneWeb.Api.SizeController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Sizes

  def index(conn, _params) do
    sizes = Sizes.list_sizes()
    render(conn, "index.json", sizes: sizes)
  end

  def show(conn, %{"id" => id}) do
    size = Sizes.get_size(id)
    render(conn, "show.json", size: size)
  end
end
