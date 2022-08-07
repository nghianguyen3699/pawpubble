defmodule Pawpubbleclone.Size_clothers do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.SizeClother.SizeClotherCore

  def get_size_clother(id) do
    Repo.get(SizeClotherCore, id)
  end

  def get_size_clother!(name) do
    Repo.get_by!(SizeClotherCore, %{name: name})
  end

  def get_size_clother_by(params) do
    Repo.get_by(SizeClotherCore, params)
  end

  def list_size_clothers() do
    Repo.all(SizeClotherCore)
  end

  def create_size_clother(atts \\ %{}) do
    %SizeClotherCore{}
    |> SizeClotherCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%SizeClotherCore{} = size_clother) do
    Repo.delete(size_clother)
  end
end
