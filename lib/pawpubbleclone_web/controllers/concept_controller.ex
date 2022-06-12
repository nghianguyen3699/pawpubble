defmodule PawpubblecloneWeb.ConceptController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Concepts
  alias Pawpubbleclone.Concepts.ConceptCore


  def index(conn, _params) do
    concepts = Concepts.list_concepts()
    IO.inspect(concepts)
    render(conn, "index.html", concepts: concepts)
  end

  def show(conn, %{ "name" => name}) do
    concept = Concepts.get_concept!(name)
    render(conn, "show.html", concept: concept)
  end

  def new(conn, _params) do
    changeset = ConceptCore.changeset(%ConceptCore{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "concept_core" => concept}) do
    case Concepts.create_concept(concept) do
       {:ok, concept}->
        conn
        |> put_flash(:info, "Create #{concept.name} succsessfuly")
        |> redirect(to: Routes.concept_path(conn, :index))
       {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{ "name" => name}) do
    # require IEx;
    # IEx.pry
    concept = Concepts.get_concept!(name)
    case Concepts.delete(concept) do
       {:ok, _}->
        conn
        |> put_flash(:info, "Delete successfuly")
        |> redirect(to: Routes.concept_path(conn, :index))
    end
  end

end
