defmodule Pawpubbleclone.Categorys do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Categorys.CategoryCore

  def get_category(id) do
    Repo.get(CategoryCore, id)
  end

  def get_category!(name) do
    Repo.get_by!(CategoryCore, %{name: name})
  end

  def get_category_by(params) do
    Repo.get_by(CategoryCore, params)
  end

  def list_categorys() do
    Repo.all(CategoryCore)
  end

  def create_category(atts \\ %{}) do
    %CategoryCore{}
    |> CategoryCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%CategoryCore{} = category) do
    Repo.delete(category)
  end
end
