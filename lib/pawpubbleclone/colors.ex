defmodule Pawpubbleclone.Colors do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Colors.ColorCore

  def get_color(id) do
    Repo.get(ColorCore, id)
  end

  def get_color!(name) do
    Repo.get_by!(ColorCore, %{name: name})
  end

  def get_color_by(params) do
    Repo.get_by(ColorCore, params)
  end

  def list_colors() do
    Repo.all(ColorCore)
  end

  def create_color(atts \\ %{}) do
    %ColorCore{}
    |> ColorCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%ColorCore{} = color) do
    Repo.delete(color)
  end
end
