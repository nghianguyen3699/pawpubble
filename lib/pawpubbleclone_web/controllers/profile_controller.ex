defmodule PawpubblecloneWeb.ProfileController do
  use PawpubblecloneWeb, :controller

  # alias Pawpubbleclone.Accounts.User
  alias Pawpubbleclone.Accounts
  alias Pawpubbleclone.Orders
  alias Pawpubbleclone.Product_Orders


  def index(conn, params) do
    user = conn.assigns.current_user
    IO.inspect(user)
    email =
    if Map.has_key?(params, "oldemail") do
      email_old = params["oldemail"]
      if Accounts.get_user!(params["id"]).email == email_old do
        email_old
      else
        ""
      end
    else
      nil
    end

    phone =
    if Map.has_key?(params, "oldphone") do
      phone_old = params["oldphone"]
      if Accounts.get_user!(params["id"]).phone == phone_old do
        phone_old
      else
        ""
      end
    else
      nil
    end

    orders = Orders.get_all_order_by_user(user.id) |> Enum.with_index()
    orders =
    for {{o, t, i, v, b, q}, index} <- orders  do
      {o, t, i, v, b, q, index}
    end
    render(conn, "index.html", email_old: email, phone_old: phone, user: user, orders: orders)
  end

  def update(conn, params) do

    user = conn.assigns.current_user
    if Map.has_key?(params, "email") do
      email = params["email"]
      case Accounts.update_email(user, %{"email" => email}) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Update successfuly.")
          |> redirect(to: Routes.profile_path(conn, :index, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "index.html", user: user, phone_old: nil, email_old: nil, changeset: changeset)
      end
    end

    if Map.has_key?(params, "phone") do
      phone = String.replace(params["phone"], " ", "")
      case Accounts.update_phone(user, %{"phone" => phone}) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Update successfuly.")
          |> redirect(to: Routes.profile_path(conn, :index, user))

        {:error, %Ecto.Changeset{} = changeset} -> IO.inspect(changeset)
          render(conn, "index.html", user: user, email_old: nil, phone_old: nil, changeset: changeset)
      end
    end

    if Map.has_key?(params, "avatar") do
      avatar = params["avatar"]
      case avatar != "remove" do
        true -> case Accounts.update_avatar(user, %{"avatar" => avatar}) do
                {:ok, user} ->
                  conn
                  |> put_flash(:info, "Update successfuly.")
                  |> redirect(to: Routes.profile_path(conn, :index, user))

                {:error, %Ecto.Changeset{} = changeset} ->
                  render(conn, "index.html", user: user, email_old: nil, phone_old: nil, changeset: changeset)
              end
        false -> case Accounts.update_avatar(user, %{"avatar" => nil}) do
                  {:ok, user} ->
                    conn
                    |> put_flash(:info, "Update successfuly.")
                    |> redirect(to: Routes.profile_path(conn, :index, user))

                  {:error, %Ecto.Changeset{} = changeset} ->
                    render(conn, "index.html", user: user, email_old: nil, phone_old: nil, changeset: changeset)
                end

      end
      # IO.inspect(avatar)
    end

    if Map.has_key?(params, "avatar") == false and Map.has_key?(params, "phone") == false and Map.has_key?(params, "email") == false do

      description = params["description"]
      ward = params["ward"]
      district = params["district"]
      province = params["province"]

      address = description <> ", " <> ward <> ", " <> district <> ", " <> province
      |> String.replace(", , , ", ", ")
      |> String.replace(", , ", ", ")

      address =
      if String.first(address) == "," do
        String.replace_prefix(address, ", ", "")
      else if String.last(address) == " " do
          String.replace(address, ", ", "")
        else
          address
        end
      end
      params = Map.merge(params, %{"address" => address})
      case Accounts.update_user(user, params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Update successfuly.")
          |> redirect(to: Routes.profile_path(conn, :index, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "index.html", user: user, email_old: nil, phone_old: nil, changeset: changeset)
      end

    end
  end
end
