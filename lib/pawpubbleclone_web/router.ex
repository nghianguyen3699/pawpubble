defmodule PawpubblecloneWeb.Router do
  use PawpubblecloneWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PawpubblecloneWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PawpubblecloneWeb.Auth
    plug PawpubblecloneWeb.AuthAdmin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_layout do
    plug :put_layout, {PawpubblecloneWeb.LayoutView, :admin}
  end

  scope "/", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_admin, :admin_layout]

    resources "/sizes", SizeController, only: [:index, :new, :create, :delete]
    resources "/colors", ColorController, only: [:index, :new, :create, :delete]
    resources "/categorys", CategoryController, only: [:index, :new, :create, :delete]
    resources "/shippings", ShippingController, only: [:index, :new, :create, :delete]
    resources "/vouchers", VoucherController, only: [:index, :new, :create, :delete]
    resources "/users", UserController
  end

  scope "/", PawpubblecloneWeb do
    pipe_through [:browser]

    get "/", PageController, :index
  end

  scope "/", PawpubblecloneWeb do
    pipe_through [:browser, :admin_layout]

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/profile", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_user]

    get "/:id", ProfileController, :index
    put "/:id/update", ProfileController, :update
  end


  scope "/concepts", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_user]
    get "/", ConceptController, :index
    get "/new", ConceptController, :new
    post "/", ConceptController, :create
    get "/:name", ConceptController, :show
    delete "/:name", ConceptController, :delete
    get "/:name/edit", ConceptController, :edit
    put "/:name", ConceptController, :update
  end

  scope "/plants", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_admin]
    get "/new", Plant_productController, :new
    post "/", Plant_productController, :create
    delete "/:id", Plant_productController, :delete
    get "/:name/:id/edit", Plant_productController, :edit
    put "/:id", Plant_productController, :update
    post "/product/:id", Plant_productController, :create_cart
  end
  scope "/plants", PawpubblecloneWeb do
    pipe_through [:browser]
    get "/", Plant_productController, :index
    get "/:name", Plant_productController, :show
  end

  scope "/carts", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_user]
    get "/", CartController, :index
    post "/", CartController, :create
    put "/:id", CartController, :update
    # put "/", CartController, :update_quantity
    delete "/:id", CartController, :delete

  end

  scope "/checkout", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_user]
    get "/", CheckoutController, :index
    post "/order", CheckoutController, :checkout
    # post "/", CartController, :create
    # put "/:id", CartController, :update
    # delete "/:id", CartController, :delete
  end

  scope "/order", PawpubblecloneWeb do
    pipe_through [:browser, :authenticate_user]
    post "/", OrderSessionController, :create
    post "/product", OrderSessionController, :create_product
    get "/thankyou", OrderSessionController, :successfuly
  end

  scope "/admin", PawpubblecloneWeb do
    pipe_through [:browser, :admin_layout, :authenticate_admin]
    get "/", AdminController, :index
    get "/users", AdminController, :usersManage
    get "/products", AdminController, :productsManage
    post "/concept_id", AdminController, :sortProducts
    get "/sort", AdminController, :load_sort
    delete "/:id", AdminController, :delete_session
  end

  scope "/admin", PawpubblecloneWeb do
    pipe_through [:browser, :admin_layout]
    get "/login", AdminController, :login
    post "/login", AdminController, :create_session
  end



  # Other scopes may use custom stacks.
  scope "/api", PawpubblecloneWeb.Api, as: :api do
    pipe_through [:api]

    resources "/colors", ColorController, only: [:index, :show]
    resources "/categorys", CategoryController, only: [:index, :show]
    resources "/sizes", SizeController, only: [:index, :show]
    resources "/concepts", ConceptController, only: [:index, :show]
    resources "/products/plants", Plant_productController, only: [:index, :show]
    resources "/carts", CartController, only: [:index, :show]
    resources "/shippings", ShippingController, only: [:index, :show]
    resources "/vouchers", VoucherController, only: [:index, :show]
  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PawpubblecloneWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

end
