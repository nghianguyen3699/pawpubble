defmodule Pawpubbleclone.TemporarySorts do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Temporary.TemporarySort

  def get_item(id) do
    Repo.get(TemporarySort, id)
  end

  def list_items() do
    Repo.all(TemporarySort)
  end

  def create_item(atts \\ %{}) do
    %TemporarySort{}
    |> TemporarySort.changeset(atts)
    |> Repo.insert()
  end

  def delete(%TemporarySort{} = item) do
    Repo.delete(item)
  end

  def delete_all() do
    Repo.delete_all(TemporarySort)
  end
end
