defmodule PawpubblecloneWeb.ShippingController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Shipping
  alias Pawpubbleclone.Shipping.Shippings


  def index(conn, _params) do
    shippings = Shipping.list_shippings()
    render(conn, "index.html", shippings: shippings)
  end

  # def show(conn, %{ "name" => name}) do
  #   shipping = Shipping.get_shipping!(name)
  #   render(conn, "show.html", shipping: shipping)
  # end

  def new(conn, _params) do
    changeset = Shippings.changeset(%Shippings{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "shippings" => shipping}) do
    case Shipping.create_shipping(shipping) do
       {:ok, shipping}->
        conn
        |> put_flash(:info, "Create #{shipping.name} succsessfuly")
        |> redirect(to: Routes.shipping_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "name" => name}) do
    # require IEx;
    # IEx.pry
    shipping = Shipping.get_shipping!(name)
    case Shipping.delete(shipping) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.shipping_path(conn, :index))
    end
  end

end
