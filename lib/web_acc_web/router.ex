defmodule WebAccWeb.Router do
  use WebAccWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    # plug(WebAcc.Authorization)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :blank_layout do
    plug(:put_layout, {WebAccWeb.LayoutView, :blank})
  end

  scope "/", WebAccWeb do
    pipe_through(:browser)

    get("/", LandingPageController, :index)
  end

  scope "/full", WebAccWeb do
    pipe_through([:browser, :blank_layout])

    get("/", PageController, :index)
  end

  scope "/mobile", WebAccWeb do
    pipe_through(:browser)
    get("/login", MobileLoginController, :index)
    post("/authenticate", MobileLoginController, :authenticate)
    get("/logout", MobileLoginController, :logout)
  end

  scope "/mobile", WebAccWeb do
    pipe_through(:browser)
    get("/", MobilePageController, :index)
  end

  scope "/admin", WebAccWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/login", LoginController, :index)
    post("/authenticate", LoginController, :authenticate)
    get("/logout", LoginController, :logout)
    resources("/users", UserController)
    resources("/roles", RoleController)
    resources("/menus", MenuController)
    resources("/kids", KidController)
    resources("/feeds", FeedController)
    resources("/reminders", ReminderController)
  end

  scope "/api", WebAccWeb do
    pipe_through(:api)
    get("/webhook", ApiController, :webhook)
    post("/webhook", ApiController, :webhook_post)
    delete("/webhook", ApiController, :webhook_delete)
    resources("/users", UserController)
    resources("/roles", RoleController)
    resources("/menus", MenuController)
    resources("/role_menus", RoleMenuController)
    resources("/kids", KidController)
    resources("/feeds", FeedController)
    resources("/reminders", ReminderController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebAccWeb do
  #   pipe_through :api
  # end
end
