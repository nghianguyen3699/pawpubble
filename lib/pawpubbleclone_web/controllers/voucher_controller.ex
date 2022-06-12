defmodule PawpubblecloneWeb.VoucherController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Voucher
  alias Pawpubbleclone.Voucher.Vouchers


  def index(conn, _params) do
    vouchers = Voucher.list_vouchers()
    render(conn, "index.html", vouchers: vouchers)
  end

  # def show(conn, %{ "name" => name}) do
  #   voucher = Voucher.get_voucher!(name)
  #   render(conn, "show.html", voucher: voucher)
  # end

  def new(conn, _params) do
    changeset = Vouchers.changeset(%Vouchers{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "vouchers" => voucher}) do
    case Voucher.create_voucher(voucher) do
       {:ok, voucher}->
        conn
        |> put_flash(:info, "Create #{voucher.name} succsessfuly")
        |> redirect(to: Routes.voucher_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "name" => name}) do
    # require IEx;
    # IEx.pry
    voucher = Voucher.get_voucher!(name)
    case Voucher.delete(voucher) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.voucher_path(conn,:index))
    end
  end

end
