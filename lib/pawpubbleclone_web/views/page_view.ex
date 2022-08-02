defmodule PawpubblecloneWeb.PageView do
  use PawpubblecloneWeb, :view
  alias Pawpubbleclone.Plants

  def render_product_concepts(concept_id) do
    Plants.get_plant_product_by_concept(concept_id)
  end
end
