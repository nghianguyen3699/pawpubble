defmodule PawpubblecloneWeb.UserSocket do
  use Phoenix.Socket

  channel "chat:*", PawpubblecloneWeb.ChatChannel
end
