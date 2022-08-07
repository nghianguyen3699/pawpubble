defmodule PawpubblecloneWeb.Api.SizeClotherController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Size_clothers

  def index(conn, _params) do
    size_clothers = Size_clothers.list_size_clothers() |> Repo.preload([:category, :size])
    render(conn, "index.json", size_clothers: size_clothers)
  end

  def show(conn, %{"id" => id}) do
    size_clother = Size_clothers.get_size_clother(id) |> Repo.preload([:category, :size])
    render(conn, "show.json", size_clother: size_clother)
  end
end
