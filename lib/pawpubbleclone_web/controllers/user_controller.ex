defmodule PawpubblecloneWeb.UserController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Accounts
  alias Pawpubbleclone.Accounts.User
  alias Pawpubbleclone.Email
  alias Pawpubbleclone.Mailer

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  defp send_email_registration(email)  do
    Email.confirm_email(email)
    |> Mailer.deliver_later()
  end


  def index(conn, _params) do
      users = Accounts.list_users()
      render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{ "id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{ "id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    # require IEx;
    # IEx.pry
    case Accounts.update_user(user, user_params) do
       {:ok, user} ->
        conn
        |> put_flash(:info, "Update successfuly.")
        |> redirect(to: Routes.user_path(conn, :show, user))

       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{ "id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete(user)
    conn
    |> put_flash(:info, "Delete #{user.name} successfuly")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user}->
        email = user_params["email"]
        send_email_registration(email)
        conn
        |> PawpubblecloneWeb.Auth.login(user)
        |> redirect(to: Routes.user_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
