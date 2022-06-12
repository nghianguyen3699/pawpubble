defmodule Pawpubbleclone.Voucher do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Voucher.Vouchers

  def get_voucher(id) do
    Repo.get(Vouchers, id)
  end

  def get_voucher!(name) do
    Repo.get_by!(Vouchers, %{name: name})
  end

  def get_voucher_by(params) do
    Repo.get_by(Vouchers, params)
  end

  def list_vouchers() do
    Repo.all(Vouchers)
  end

  def create_voucher(atts \\ %{}) do
    %Vouchers{}
    |> Vouchers.changeset(atts)
    |> Repo.insert()
  end

  def delete(%Vouchers{} = voucher) do
    Repo.delete(voucher)
  end
end
