defmodule PawpubblecloneWeb.SizeClotherController do
  use PawpubblecloneWeb, :controller

  import Pawpubbleclone.Plants
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Size_clothers
  alias Pawpubbleclone.SizeClother.SizeClotherCore

  plug :load_sizes_category when action in [:new, :create]
  plug :load_categorys_category when action in [:new, :create]

  def index(conn, _params) do
    size_clothers = Size_clothers.list_size_clothers() |> Repo.preload([:category, :size])
    render(conn, "index.html", size_clothers: size_clothers)
  end

  def new(conn, _params) do
    changeset = SizeClotherCore.changeset(%SizeClotherCore{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "size_clother_core" => size_clother_core}) do
    case Size_clothers.create_size_clother(size_clother_core) do
       {:ok, size_clother_core}->
        conn
        |> put_flash(:info, "Create succsessfuly")
        |> redirect(to: Routes.size_clother_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "name" => name}) do
    size_clother = Size_clothers.get_size_clother!(name)
    case Size_clothers.delete(size_clother) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.size_clother_path(conn, :index))
    end
  end

end
