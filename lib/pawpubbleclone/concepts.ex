defmodule Pawpubbleclone.Concepts do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Concepts.ConceptCore

  def get_concept(id) do
    Repo.get(ConceptCore, id)
  end

  def get_concept!(name) do
    Repo.get_by!(ConceptCore, %{name: name})
  end

  def get_concept_by(params) do
    Repo.get_by(ConceptCore, params)
  end

  def list_concepts() do
    Repo.all(ConceptCore)
  end

  def create_concept(atts \\ %{}) do
    %ConceptCore{}
    |> ConceptCore.changeset(atts)
    |> Repo.insert()
  end

  def delete(%ConceptCore{} = concept) do
    Repo.delete(concept)
  end
end
