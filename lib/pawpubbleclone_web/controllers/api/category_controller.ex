defmodule PawpubblecloneWeb.Api.CategoryController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Categorys

  def index(conn, _params) do
    categorys = Categorys.list_categorys()
    render(conn, "index.json", categorys: categorys)
  end

  def show(conn, %{"id" => id}) do
    category = Categorys.get_category(id)
    render(conn, "show.json", category: category)
  end
end
