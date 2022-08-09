defmodule PawpubblecloneWeb.OrderSessionController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Orders
  alias Pawpubbleclone.Product_Orders
  alias Pawpubbleclone.Plants
  alias Pawpubbleclone.Accounts


  def create(conn, %{"order_session" => order_session}) do
    user_id =
      conn
      |> fetch_session()
      |> get_session(:user_id)
      order_session = Map.put(order_session, "user_id", user_id)
    case Orders.create_order(order_session) do
       {:ok, order_session}->
        user = Accounts.get_user!(order_session.user_id)
        revenue_current =
          if user.revenue == nil do
            0 + Decimal.to_float(order_session.total_price)
          else
            user.revenue + Decimal.to_float(order_session.total_price)
          end
        IO.inspect(revenue_current)
        case Accounts.update_revenue(user, %{"revenue" => revenue_current}) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "Update succsessfuly")
          {:error, _} ->
            conn
            |> put_flash(:info, "Faith")
        end
        conn
        |> redirect(to: Routes.order_session_path(conn, :successfuly))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def create_product(conn, %{"products" => products, "order_code" => order_code}) do
    Enum.map(products, fn product -> product = Map.put(product, "order_code", order_code)
      case Product_Orders.create_product_order(product) do
         {:ok, product} ->
          product_update = Plants.get_plant_product!(product.product_id)
          quantity_current = product_update.quantity - product.quantity
          revenue_current =
            if product_update.revenue == nil do
              0 + Decimal.to_float(product_update.price) * product.quantity
            else
              product_update.revenue + Decimal.to_float(product_update.price) * product.quantity
            end
          IO.inspect(revenue_current)
          case Plants.update_plant_product(product_update, %{"quantity" => quantity_current, "revenue" => revenue_current}) do
            {:ok, _} ->
              conn
              |> put_flash(:info, "Create succsessfuly")
            {:error, _} ->
              conn
              |> put_flash(:info, "Faith")
          end
         {:error, _} ->
          conn
          |> put_flash(:info, "Faith")
      end
    end)
  end

  # def update(conn, params = %{"id" => id, "bill_of_lading_no" => bill_of_lading_no}) do
  #   order = Orders.get_order(id)
  #   IO.inspect(params)
  #   IO.inspect(order)
  #   case Orders.update_orders(order, %{"bill_of_lading_no" => bill_of_lading_no}) do
  #     {:ok, order} ->
  #       conn
  #       |> put_flash(:info, "Update successfuly.")
  #       |> redirect(to: Routes.admin_path(conn, :index, order: order))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, AdminView, "index.html")
  #   end
  # end

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
