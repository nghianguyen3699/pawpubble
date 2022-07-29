defmodule PawpubblecloneWeb.AdminController do
  use PawpubblecloneWeb, :controller

  # import PawpubblecloneWeb.Plant_productController

  import Ecto.Query
  import Pawpubbleclone.Plants
  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Accounts.User
  alias Pawpubbleclone.Plant.Plant_product
  alias PawpubblecloneWeb.AuthAdmin
  alias Pawpubbleclone.Accounts
  alias Pawpubbleclone.TemporarySorts
  alias Pawpubbleclone.Orders


  plug :put_layout, "admin.html"
  plug :load_concepts_category when action in [:index, :sortProducts]
  plug :load_colors_category when action in [:index, :sortProducts]
  plug :load_sizes_category when action in [:index, :sortProducts]
  plug :load_categorys_category when action in [:index, :sortProducts]
  # plug :load_sort when action in [:index]
  # plug :sortProducts when action in [:index]

  def index(conn, params) do
    # users = Accounts.list_users()
    # products = Repo.preload(Plants.list_plants, [:concept, :color, :size, :category])
    # products = from p in Plant_product, select: p
    # %{"concept_id" => concept_id, "category_id" => category_id, "color_id" => color_id, "size_id" => size_id}
    # IO.inspect(params)
    # IO.inspect(Map.has_key?(conn.query_params, "concept_id"))
    orders = Orders.list_orders() |> Repo.preload([:shipping, :voucher])
    IO.inspect(orders)
    if Map.has_key?(conn.query_params, "concept_id") do

      concept_id = conn.query_params["concept_id"]
      category_id = conn.query_params["category_id"]
      color_id = conn.query_params["color_id"]
      size_id = conn.query_params["size_id"]

      users =
        User
        |> Repo.paginate(params)

      products =
          handleSortProduct(concept_id, category_id, color_id, size_id, params)

      render(conn, "index.html", users: users, products: products, orders: orders)
    else

      users =
        User
        |> Repo.paginate(params)

      products =
        Plant_product
        |> select([p], p)
        |> preload([:concept, :color, :size, :category])
        |> Repo.paginate(params)

      render(conn, "index.html", users: users, products: products, orders: orders)
    end

  end

  def load_sort(conn, _) do
    # %{"concept_id" => concept_id, "category_id" => category_id, "color_id" => color_id, "size_id" => size_id} \\ %{}
    [item] = TemporarySorts.list_items()
    sort = %{"concept_id" => if item.concept_id == nil do "" else Integer.to_string(item.concept_id) end,
              "category_id" => if item.category_id == nil do "" else Integer.to_string(item.category_id) end,
              "color_id" => if item.color_id == nil do "" else Integer.to_string(item.color_id) end,
              "size_id" => if item.size_id == nil do "" else Integer.to_string(item.size_id) end}
    assign(conn, :sort, sort)
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def sortProducts(conn, %{"concept_id" => concept_id, "category_id" => category_id, "color_id" => color_id, "size_id" => size_id}) do
    sort = %{"concept_id" => concept_id, "category_id" => category_id, "color_id" => color_id, "size_id" => size_id}
    conn
    |> redirect(to: Routes.admin_path(conn, :index, sort))


  end


  def handleSortProduct(concept_id, category_id, color_id, size_id, params) do
      case concept_id != "" do
         true -> case category_id != "" do
                   true -> case color_id != "" do
                             true -> case size_id != "" do
                                       true -> Plant_product
                                                |> where([p], p.concept_id == ^concept_id and p.category_id == ^category_id and p.color_id == ^color_id and p.size_id == ^size_id)
                                                |> select([p], p)
                                                |> preload([:concept, :color, :size, :category])
                                                |> Repo.paginate(params)
                                        # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.category_id == ^category_id and p.color_id == ^color_id and p.size_id == ^size_id, select: p)
                                       false -> Plant_product
                                                |> where([p], p.concept_id == ^concept_id and p.category_id == ^category_id and p.color_id == ^color_id)
                                                |> select([p], p)
                                                |> preload([:concept, :color, :size, :category])
                                                |> Repo.paginate(params)
                                        # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.category_id == ^category_id and p.color_id == ^color_id, select: p)
                                     end
                             false -> case size_id != "" do
                                        true -> Plant_product
                                                  |> where([p], p.concept_id == ^concept_id and p.category_id == ^category_id and p.size_id == ^size_id)
                                                  |> select([p], p)
                                                  |> preload([:concept, :color, :size, :category])
                                                  |> Repo.paginate(params)
                                          # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.category_id == ^category_id and p.size_id == ^size_id, select: p)
                                        false ->  Plant_product
                                                    |> where([p], p.concept_id == ^concept_id and p.category_id == ^category_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                          # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.category_id == ^category_id, select: p)
                                      end
                          end
                   false -> case color_id != "" do
                              true -> case size_id != "" do
                                        true -> Plant_product
                                                  |> where([p], p.concept_id == ^concept_id and p.color_id == ^color_id and p.size_id == ^size_id)
                                                  |> select([p], p)
                                                  |> preload([:concept, :color, :size, :category])
                                                  |> Repo.paginate(params)
                                          # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.color_id == ^color_id and p.size_id == ^size_id, select: p)
                                        false -> Plant_product
                                                  |> where([p], p.concept_id == ^concept_id and p.color_id == ^color_id)
                                                  |> select([p], p)
                                                  |> preload([:concept, :color, :size, :category])
                                                  |> Repo.paginate(params)
                                          # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.color_id == ^color_id, select: p)
                                      end
                              false -> case size_id != "" do
                                        true -> Plant_product
                                                  |> where([p], p.concept_id == ^concept_id and p.size_id == ^size_id)
                                                  |> select([p], p)
                                                  |> preload([:concept, :color, :size, :category])
                                                  |> Repo.paginate(params)
                                          # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id and p.size_id == ^size_id, select: p)
                                        false -> Plant_product
                                                  |> where([p],p.concept_id == ^concept_id)
                                                  |> select([p], p)
                                                  |> preload([:concept, :color, :size, :category])
                                                  |> Repo.paginate(params)
                                          # Repo.all(from p in Plant_product, where: p.concept_id == ^concept_id, select: p)
                                       end
                 end

                 end
         false -> case category_id != "" do
                    true -> case color_id != "" do
                                true -> case size_id != "" do
                                          true -> Plant_product
                                                    |> where([p], p.category_id == ^category_id and p.color_id == ^color_id and p.size_id == ^size_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                            # Repo.all(from p in Plant_product, where: p.category_id == ^category_id and p.color_id == ^color_id and p.size_id == ^size_id, select: p)
                                          false -> Plant_product
                                                    |> where([p], p.category_id == ^category_id and p.color_id == ^color_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                            # Repo.all(from p in Plant_product, where: p.category_id == ^category_id and p.color_id == ^color_id , select: p)
                                        end
                                false -> case size_id != "" do
                                          true -> Plant_product
                                                    |> where([p], p.category_id == ^category_id and p.size_id == ^size_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                            # Repo.all(from p in Plant_product, where: p.category_id == ^category_id and p.size_id == ^size_id, select: p)
                                          false -> Plant_product
                                                    |> where([p], p.category_id == ^category_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                            # Repo.all(from p in Plant_product, where: p.category_id == ^category_id, select: p)
                                         end
                            end
                    false -> case color_id != "" do
                                true -> case size_id != "" do
                                          true -> Plant_product
                                                    |> where([p], p.color_id == ^color_id and p.size_id == ^size_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                            # Repo.all(from p in Plant_product, where: p.color_id == ^color_id and p.size_id == ^size_id, select: p)
                                          false -> Plant_product
                                                    |> where([p], p.color_id == ^color_id)
                                                    |> select([p], p)
                                                    |> preload([:concept, :color, :size, :category])
                                                    |> Repo.paginate(params)
                                            # Repo.all(from p in Plant_product, where: p.color_id == ^color_id, select: p)
                                        end
                                false -> case size_id != "" do
                                            true -> Plant_product
                                                      |> where([p], p.size_id == ^size_id)
                                                      |> select([p], p)
                                                      |> preload([:concept, :color, :size, :category])
                                                      |> Repo.paginate(params)
                                              # Repo.all(from p in Plant_product, where: p.size_id == ^size_id, select: p)
                                            false -> Plant_product
                                                      |> select([p], p)
                                                      |> preload([:concept, :color, :size, :category])
                                                      |> Repo.paginate(params)
                                         end
                            end
                  end
      end
  end

  def usersManage(conn, _params) do
    render(conn, "user.html")
  end

  @spec productsManage(Plug.Conn.t(), any) :: Plug.Conn.t()
  def productsManage(conn, _params) do
    plants = Repo.preload(list_plants(), [:concept, :color, :size, :category])
    render(conn, "product.html", plants: plants )
  end

  def create_session(conn, %{ "session" => %{ "email" => email, "password" => password}} ) do
    case Accounts.authenticate_by_email_and_pass(email, password) do
      {:ok, admin} ->
        conn
        |> AuthAdmin.login(admin)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.admin_path(conn, :index))
        # IO.inspect(conn)
      {:error, _reason} ->
        conn
        |> put_flash(:info, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete_session(conn, _) do
    conn
    |> AuthAdmin.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end


end
