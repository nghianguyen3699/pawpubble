defmodule PawpubblecloneWeb.OrderSessionController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Orders
  alias Pawpubbleclone.Product_Orders
  # alias Pawpubbleclone.Orders.Order_session


  def create(conn, %{"order_session" => order_session}) do
    user_id =
      conn
      |> fetch_session()
      |> get_session(:user_id)
      order_session = Map.put(order_session, "user_id", user_id)
    case Orders.create_order(order_session) do
       {:ok, _}->
        conn
        |> redirect(to: Routes.order_session_path(conn, :successfuly))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
  def create_product(conn, %{"products" => products, "order_code" => order_code}) do
    Enum.map(products, fn product ->
      product = Map.put(product, "order_code", order_code)
      case Product_Orders.create_product_order(product) do
         {:ok, _}->
          conn
          |> put_flash(:info, "Create succsessfuly")
         {:error, _} ->
          conn
          |> put_flash(:info, "Faith")
      end
    end)
  end

  # def delete(conn, %{ "id" => id}) do
  #   order = Colors.get_order(id)
  #   case Colors.delete(order) do
  #      {:ok, _}->
  #       conn
  #       |> put_flash(:info, "Delete successfuly")
  #       |> redirect(to: Routes.order_path(conn, :index))
  #   end
  # end

  def successfuly(conn, _) do
    render(conn, "thankyou.html")
  end
end
