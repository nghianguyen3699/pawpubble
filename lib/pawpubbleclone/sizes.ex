defmodule Pawpubbleclone.Sizes do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Sizes.SizeCore

  def get_size(id) do
    Repo.get(SizeCore, id)
  end

  def get_size!(name) do
    Repo.get_by!(SizeCore, %{name: name})
  end

  def get_size_by(params) do
    Repo.get_by(SizeCore, params)
  end

  def list_sizes() do
    Repo.all(SizeCore)
  end

  def create_size(atts \\ %{}) do
    %SizeCore{}
    |> SizeCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%SizeCore{} = size) do
    Repo.delete(size)
  end
end
