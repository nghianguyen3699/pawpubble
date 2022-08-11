defmodule PawpubblecloneWeb.AuthAdmin do
  import Plug.Conn
  import Phoenix.Controller
  alias Pawpubbleclone.Admin
  alias PawpubblecloneWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    admin_id = get_session(conn, :admin_id)
    admin = admin_id && Admin.get_admin(admin_id)
    assign(conn, :current_admin, admin)
  end

  def login(conn, admin) do
    conn
    |> assign(:current_admin, admin)
    |> put_session(:admin_id, admin.id)
    |> configure_session(renew: true)
  end
  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_admin(conn, _opts) do
    if conn.assigns.current_admin do
      conn
    else
      conn
      |> redirect(to: Routes.admin_path(conn, :login))
      |> halt()
    end
  end

end
