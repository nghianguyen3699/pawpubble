defmodule PawpubblecloneWeb.SizeClotherView do
  use PawpubblecloneWeb, :view

  def category_select_options(options) do
    for option <- options, do: {option.name, option.id}
  end
end
