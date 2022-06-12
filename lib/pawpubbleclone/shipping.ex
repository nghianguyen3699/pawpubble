defmodule Pawpubbleclone.Shipping do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Shipping.Shippings

  def get_shipping(id) do
    Repo.get(Shippings, id)
  end

  def get_shipping!(name) do
    Repo.get_by!(Shippings, %{name: name})
  end

  def get_shipping_by(params) do
    Repo.get_by(Shippings, params)
  end

  def list_shippings() do
    Repo.all(Shippings)
  end

  def create_shipping(atts \\ %{}) do
    %Shippings{}
    |> Shippings.changeset(atts)
    |> Repo.insert()
  end

  def delete(%Shippings{} = shipping) do
    Repo.delete(shipping)
  end
end
