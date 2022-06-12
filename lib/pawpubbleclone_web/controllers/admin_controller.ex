defmodule PawpubblecloneWeb.AdminController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Plants
  alias Pawpubbleclone.Plant.Plant_product
  alias Pawpubbleclone.Repo
  alias PawpubblecloneWeb.AuthAdmin
  alias Pawpubbleclone.Accounts

  plug :put_layout, "admin.html"

  def index(conn, _params) do
    users = Accounts.list_users()
    products = Repo.preload(Plants.list_plants, [:concept, :color, :size, :category])
    render(conn, "index.html", users: users, products: products)
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end


  def usersManage(conn, _params) do
    render(conn, "user.html")
  end

  @spec productsManage(Plug.Conn.t(), any) :: Plug.Conn.t()
  def productsManage(conn, _params) do
    plants = Repo.preload(Plants.list_plants, [:concept, :color, :size, :category])
    render(conn, "product.html", plants: plants )
  end

  def create_session(conn, %{ "session" => %{ "email" => email, "password" => password}} ) do
    case Accounts.authenticate_by_email_and_pass(email, password) do
      {:ok, admin} ->
        conn
        |> AuthAdmin.login(admin)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.admin_path(conn, :index))
        # IO.inspect(conn)
      {:error, _reason} ->
        conn
        |> put_flash(:info, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete_session(conn, _) do
    conn
    |> AuthAdmin.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end

end
