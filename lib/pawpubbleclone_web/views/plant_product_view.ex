defmodule PawpubblecloneWeb.Plant_productView do
  use PawpubblecloneWeb, :view

  def category_select_options(options) do
    for option <- options, do: {option.name, option.id}
  end

  # def jwt(conn) do
  #   Guardian.Plug.current_token(conn)
  # end
end
