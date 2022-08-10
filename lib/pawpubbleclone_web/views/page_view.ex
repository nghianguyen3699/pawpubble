defmodule PawpubblecloneWeb.PageView do
  use PawpubblecloneWeb, :view
  alias Pawpubbleclone.Plants
  alias Pawpubbleclone.Concepts

  def render_product_concepts(concept_id) do
    Plants.get_plant_product_by_concept(concept_id)
  end

  def get_slug_concept(id) do
    Concepts.get_concept(id)
  end

end
