defmodule PawpubblecloneWeb.Api.VoucherView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{vouchers: vouchers}) do
    %{data: render_many(vouchers, PawpubblecloneWeb.Api.VoucherView, "voucher.json")}
  end
  def render("show.json", %{voucher: voucher}) do
    %{data: render_one(voucher, PawpubblecloneWeb.Api.VoucherView, "voucher.json")}
  end


  def render("voucher.json", %{voucher: voucher}) do
    %{
      id: voucher.id,
      name: voucher.name,
      value: voucher.value,
      time_start: voucher.time_start,
      time_end: voucher.time_end
    }
  end
end
