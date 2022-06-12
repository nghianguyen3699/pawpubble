defmodule PawpubblecloneWeb.Api.VoucherController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Voucher

  def index(conn, _params) do
    vouchers = Voucher.list_vouchers()
    render(conn, "index.json", vouchers: vouchers)
  end

  def show(conn, %{"id" => id}) do
    voucher = Voucher.get_voucher(id)
    render(conn, "show.json", voucher: voucher)
  end
end
