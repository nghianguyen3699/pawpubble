defmodule PawpubblecloneWeb.ColorController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Colors
  alias Pawpubbleclone.Colors.ColorCore


  def index(conn, _params) do
    colors = Colors.list_colors()
    render(conn, "index.html", colors: colors)
  end

  def new(conn, _params) do
    changeset = ColorCore.changeset(%ColorCore{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "color_core" => color}) do
    case Colors.create_color(color) do
       {:ok, color}->
        conn
        |> put_flash(:info, "Create #{color.name} succsessfuly")
        |> redirect(to: Routes.color_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "id" => id}) do
    color = Colors.get_color(id)
    case Colors.delete(color) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.color_path(conn, :index))
    end
  end

end
