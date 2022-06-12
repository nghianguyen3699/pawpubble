defmodule PawpubblecloneWeb.SizeController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Sizes
  alias Pawpubbleclone.Sizes.SizeCore


  def index(conn, _params) do
    sizes = Sizes.list_sizes()
    render(conn, "index.html", sizes: sizes)
  end

  def new(conn, _params) do
    changeset = SizeCore.changeset(%SizeCore{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "size_core" => size}) do
    case Sizes.create_size(size) do
       {:ok, size}->
        conn
        |> put_flash(:info, "Create #{size.name} succsessfuly")
        |> redirect(to: Routes.size_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "name" => name}) do
    size = Sizes.get_size!(name)
    case Sizes.delete(size) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.size_path(conn, :index))
    end
  end

end
