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
    resources("/purchase_orders", PurchaseOrderController)
    resources("/locations", LocationController)
    resources("/products", ProductController)
    resources("/stock_levels", StockLevelController)
    resources("/stock_movements", StockMovementController)
    resources("/suppliers", SupplierController)
    resources("/supplier_products", SupplierProductController)
    resources("/purchase_order_masters", PurchaseOrderMasterController)
    resources("/stock_receive_masters", StockReceiveMasterController)
    resources("/stock_receives", StockReceiveController)
    resources("/sales_order_masters", SalesOrderMasterController)
    resources("/sales_orders", SalesOrderController)
    resources("/customers", CustomerController)
    resources("/stock_transfer_master", StockTransferMasterController)
    resources("/stock_transfers", StockTransferController)
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
    resources("/locations", LocationController)
    resources("/products", ProductController)
    resources("/stock_levels", StockLevelController)
    resources("/stock_movements", StockMovementController)
    resources("/suppliers", SupplierController)
    resources("/supplier_products", SupplierProductController)
    resources("/purchase_orders", PurchaseOrderController)
    resources("/purchase_order_masters", PurchaseOrderMasterController)
    resources("/stock_receive_masters", StockReceiveMasterController)
    resources("/stock_receives", StockReceiveController)
    resources("/sales_order_masters", SalesOrderMasterController)
    resources("/sales_orders", SalesOrderController)
    resources("/customers", CustomerController)
    resources("/stock_transfer_master", StockTransferMasterController)
    resources("/stock_transfers", StockTransferController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebAccWeb do
  #   pipe_through :api
  # end
end
