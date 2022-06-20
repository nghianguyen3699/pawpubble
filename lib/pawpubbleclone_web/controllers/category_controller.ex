defmodule PawpubblecloneWeb.CategoryController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Categorys
  alias Pawpubbleclone.Categorys.CategoryCore


  def index(conn, _params) do
    categorys = Categorys.list_categorys()
    IO.inspect(categorys)
    render(conn, "index.html", categorys: categorys)
  end

  def new(conn, _params) do
    changeset = CategoryCore.changeset(%CategoryCore{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "category_core" => category}) do
    IO.inspect(category)
    case Categorys.create_category(category) do
       {:ok, category}->
        IO.inspect(category)
        conn
        |> put_flash(:info, "Create #{category.name} succsessfuly")
        |> redirect(to: Routes.category_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "id" => id}) do
    category = Categorys.get_category(id)
    case Categorys.delete(category) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.category_path(conn, :index))
    end
  end

end
