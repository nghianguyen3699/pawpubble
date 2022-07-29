defmodule PawpubblecloneWeb.CartController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Carts
  alias Pawpubbleclone.Orders.Order_session
  # alias Pawpubbleclone.Plants
  # alias Pawpubbleclone.Carts.Cart


  def index(conn, _params) do
    changeset = Order_session.changeset(%Order_session{}, %{})
    user = conn.assigns.current_user
    render(conn, "index.html", user: user, changeset: changeset)
  end

  # def show(conn, %{ "name" => name}) do
  #   concept = Concepts.get_concept!(name)
  #   render(conn, "show.html", concept: concept)
  # end

  # def new(conn, _params) do
  #   changeset = ConceptCore.changeset(%ConceptCore{}, %{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{ "id" => product_id, "quantityATC" => quantity}) do
    user_id =
      conn
      |> fetch_session()
      |> get_session(:user_id)
    check = Carts.check_cart(user_id, product_id)
    if check != [] do
        id = List.first(check).id
        cart = Carts.get_cart(id)
        IO.inspect(quantity)
        quantity_old = List.first(check).quantity
        quantity_new = quantity_old + quantity
        case Carts.update(cart, %{"quantity" => quantity_new}) do
          {:ok, _cart}->
            conn
            |> put_flash(:info, "Create successfuly")
        end
    else
      cart = %{ "product_id" => product_id,
                "user_id" => user_id,
                "quantity" => quantity
            }

      case Carts.create_cart(cart) do
          {:ok, _cart}->
          conn
          |> put_flash(:info, "Create successfuly")
          {:error, _cart}->
          conn
          |> current_path()
      end
    end

  end

  def update(conn, %{ "id" => id, "quantity" => quantity_new}) do
    cart_item = Carts.get_cart(id)
    # require IEx;
    # IEx.pry
    case Carts.update(cart_item, %{"quantity" => quantity_new}) do
      {:ok, _cart}->
        conn
        |> put_flash(:info, "Update successfuly")
      {:error, _cart}->
        conn
        |> current_path()
    end
  end

  # def update_quantity(conn, %{"id" => id, "quantity" => quantity}) do
  #   IO.inspect(params)
  # end

  def delete(conn, %{ "id" => id}) do
    cart_item = Carts.get_cart(id)
    case Carts.delete(cart_item) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
    end

  end

end
