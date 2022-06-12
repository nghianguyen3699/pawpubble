# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pawpubbleclone.Repo.insert!(%Pawpubbleclone.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Faker.{Color, Commerce}
alias Pawpubbleclone.Colors

# colors = Faker.Commerce

Enum.each(1..10, fn x ->
  Colors.create_color(%{
    name: Faker.Commerce.color()
  })
end)
