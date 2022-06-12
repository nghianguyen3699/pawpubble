defmodule PawpubblecloneWeb.Api.ConceptController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Concepts

  def index(conn, _params) do
    concepts = Concepts.list_concepts()
    render(conn, "index.json", concepts: concepts)
  end

  def show(conn, %{"id" => id}) do
    concept = Concepts.get_concept(id)
    render(conn, "show.json", concept: concept)
  end
end
