defmodule PawpubblecloneWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Pawpubbleclone.Accounts
  alias Pawpubbleclone.Admin
  alias PawpubblecloneWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end
  @spec call_admin(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call_admin(conn, _opts) do
    admin_id = get_session(conn, :admin_id)
    admin = admin_id && Admin.get_admin(admin_id)
    assign(conn, :current_admin, admin)
  end

  def login(conn, user) do
    # IO.inspect(user)
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
    # IO.inspect(conn)
  end

  def login_admin(conn, admin) do
    conn
    |> assign(:current_admin, admin)
    |> put_session(:admin_id, admin.id)
    |> configure_session(renew: true)
  end
  def logout(conn) do
    configure_session(conn, drop: true)
  end

  @spec authenticate_user(
          atom
          | %{
              :assigns => atom | %{:current_user => any, optional(any) => any},
              optional(any) => any
            },
          any
        ) :: atom | %{:assigns => atom | map, optional(any) => any}
  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> redirect(to: Routes.session_path(conn, :new))
      |> put_flash(:error, "You must be logged in to access that page")
      |> halt()
    end
  end

end
