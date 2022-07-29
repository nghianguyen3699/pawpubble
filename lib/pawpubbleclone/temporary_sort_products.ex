defmodule Pawpubbleclone.TemporarySortProducts do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Temporary.TemporarySortProduct

  def get_product(id) do
    Repo.get(TemporarySortProduct, id)
  end

  def list_products() do
    Repo.all(TemporarySortProduct)
  end

  def create_product(atts \\ %{}) do
    %TemporarySortProduct{}
    |> TemporarySortProduct.changeset(atts)
    |> Repo.insert()
  end

  def delete(%TemporarySortProduct{} = product) do
    Repo.delete(product)
  end

  def delete_all() do
    Repo.delete_all(TemporarySortProduct)
  end
end
