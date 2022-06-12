defmodule Pawpubbleclone.Email do
  use Bamboo.Phoenix, view: PawpubblecloneWeb.EmailView
  import Bamboo.Email
  # import Bamboo.Phoenix

  def confirm_email(email) do
    base_email(email)
    |> subject("Confirm Registration")
    |> render("registration.html")
  end

  defp base_email(email) do
    # IO.inspect(email)
    new_email()
    |> to(email)
    |> from("luffy.1999tm@gmail.com")
    |> put_html_layout({PawpubblecloneWeb.LayoutView, "email.html"})
  end

  # def welcome_text_email do
  #   new_email(
  #     from: "luffy.1999tm@gmail.com",
  #     to: "tranhuuthanhtm1@gmail.com",
  #     subject: "Welcome!",
  #     text_body: "Welcome to MyApp!"
  #   )
  # end
end
