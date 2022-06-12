defmodule PawpubblecloneWeb.Api.ConceptView do
  use PawpubblecloneWeb, :view

  def render("index.json", %{concepts: concepts}) do
    %{data: render_many(concepts, PawpubblecloneWeb.Api.ConceptView, "concept.json")}
  end
  def render("show.json", %{concept: concept}) do
    %{data: render_one(concept, PawpubblecloneWeb.Api.ConceptView, "concept.json")}
  end


  def render("concept.json", %{concept: concept}) do
    %{
      id: concept.id,
      name: concept.name,
    }
  end
end
