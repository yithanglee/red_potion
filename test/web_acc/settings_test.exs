defmodule WebAcc.SettingsTest do
  use WebAcc.DataCase

  alias WebAcc.Settings

  describe "users" do
    alias WebAcc.Settings.User

    @valid_attrs %{crypted_password: "some crypted_password", name: "some name", password: "some password", role: "some role", role_id: 42, username: "some username"}
    @update_attrs %{crypted_password: "some updated crypted_password", name: "some updated name", password: "some updated password", role: "some updated role", role_id: 43, username: "some updated username"}
    @invalid_attrs %{crypted_password: nil, name: nil, password: nil, role: nil, role_id: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Settings.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Settings.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Settings.create_user(@valid_attrs)
      assert user.crypted_password == "some crypted_password"
      assert user.name == "some name"
      assert user.password == "some password"
      assert user.role == "some role"
      assert user.role_id == 42
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Settings.update_user(user, @update_attrs)
      assert user.crypted_password == "some updated crypted_password"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
      assert user.role == "some updated role"
      assert user.role_id == 43
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_user(user, @invalid_attrs)
      assert user == Settings.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Settings.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Settings.change_user(user)
    end
  end

  describe "roles" do
    alias WebAcc.Settings.Role

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Settings.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Settings.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Settings.create_role(@valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Settings.update_role(role, @update_attrs)
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_role(role, @invalid_attrs)
      assert role == Settings.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Settings.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Settings.change_role(role)
    end
  end

  describe "menus" do
    alias WebAcc.Settings.Menu

    @valid_attrs %{category: "some category", icon: "some icon", link: "some link", name: "some name"}
    @update_attrs %{category: "some updated category", icon: "some updated icon", link: "some updated link", name: "some updated name"}
    @invalid_attrs %{category: nil, icon: nil, link: nil, name: nil}

    def menu_fixture(attrs \\ %{}) do
      {:ok, menu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_menu()

      menu
    end

    test "list_menus/0 returns all menus" do
      menu = menu_fixture()
      assert Settings.list_menus() == [menu]
    end

    test "get_menu!/1 returns the menu with given id" do
      menu = menu_fixture()
      assert Settings.get_menu!(menu.id) == menu
    end

    test "create_menu/1 with valid data creates a menu" do
      assert {:ok, %Menu{} = menu} = Settings.create_menu(@valid_attrs)
      assert menu.category == "some category"
      assert menu.icon == "some icon"
      assert menu.link == "some link"
      assert menu.name == "some name"
    end

    test "create_menu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_menu(@invalid_attrs)
    end

    test "update_menu/2 with valid data updates the menu" do
      menu = menu_fixture()
      assert {:ok, %Menu{} = menu} = Settings.update_menu(menu, @update_attrs)
      assert menu.category == "some updated category"
      assert menu.icon == "some updated icon"
      assert menu.link == "some updated link"
      assert menu.name == "some updated name"
    end

    test "update_menu/2 with invalid data returns error changeset" do
      menu = menu_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_menu(menu, @invalid_attrs)
      assert menu == Settings.get_menu!(menu.id)
    end

    test "delete_menu/1 deletes the menu" do
      menu = menu_fixture()
      assert {:ok, %Menu{}} = Settings.delete_menu(menu)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_menu!(menu.id) end
    end

    test "change_menu/1 returns a menu changeset" do
      menu = menu_fixture()
      assert %Ecto.Changeset{} = Settings.change_menu(menu)
    end
  end

  describe "role_menus" do
    alias WebAcc.Settings.RoleMenu

    @valid_attrs %{menu_id: 42, role_id: 42}
    @update_attrs %{menu_id: 43, role_id: 43}
    @invalid_attrs %{menu_id: nil, role_id: nil}

    def role_menu_fixture(attrs \\ %{}) do
      {:ok, role_menu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_role_menu()

      role_menu
    end

    test "list_role_menus/0 returns all role_menus" do
      role_menu = role_menu_fixture()
      assert Settings.list_role_menus() == [role_menu]
    end

    test "get_role_menu!/1 returns the role_menu with given id" do
      role_menu = role_menu_fixture()
      assert Settings.get_role_menu!(role_menu.id) == role_menu
    end

    test "create_role_menu/1 with valid data creates a role_menu" do
      assert {:ok, %RoleMenu{} = role_menu} = Settings.create_role_menu(@valid_attrs)
      assert role_menu.menu_id == 42
      assert role_menu.role_id == 42
    end

    test "create_role_menu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_role_menu(@invalid_attrs)
    end

    test "update_role_menu/2 with valid data updates the role_menu" do
      role_menu = role_menu_fixture()
      assert {:ok, %RoleMenu{} = role_menu} = Settings.update_role_menu(role_menu, @update_attrs)
      assert role_menu.menu_id == 43
      assert role_menu.role_id == 43
    end

    test "update_role_menu/2 with invalid data returns error changeset" do
      role_menu = role_menu_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_role_menu(role_menu, @invalid_attrs)
      assert role_menu == Settings.get_role_menu!(role_menu.id)
    end

    test "delete_role_menu/1 deletes the role_menu" do
      role_menu = role_menu_fixture()
      assert {:ok, %RoleMenu{}} = Settings.delete_role_menu(role_menu)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_role_menu!(role_menu.id) end
    end

    test "change_role_menu/1 returns a role_menu changeset" do
      role_menu = role_menu_fixture()
      assert %Ecto.Changeset{} = Settings.change_role_menu(role_menu)
    end
  end

  describe "kids" do
    alias WebAcc.Settings.Kid

    @valid_attrs %{chinese_name: "some chinese_name", father: "some father", mother: "some mother", name: "some name"}
    @update_attrs %{chinese_name: "some updated chinese_name", father: "some updated father", mother: "some updated mother", name: "some updated name"}
    @invalid_attrs %{chinese_name: nil, father: nil, mother: nil, name: nil}

    def kid_fixture(attrs \\ %{}) do
      {:ok, kid} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_kid()

      kid
    end

    test "list_kids/0 returns all kids" do
      kid = kid_fixture()
      assert Settings.list_kids() == [kid]
    end

    test "get_kid!/1 returns the kid with given id" do
      kid = kid_fixture()
      assert Settings.get_kid!(kid.id) == kid
    end

    test "create_kid/1 with valid data creates a kid" do
      assert {:ok, %Kid{} = kid} = Settings.create_kid(@valid_attrs)
      assert kid.chinese_name == "some chinese_name"
      assert kid.father == "some father"
      assert kid.mother == "some mother"
      assert kid.name == "some name"
    end

    test "create_kid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_kid(@invalid_attrs)
    end

    test "update_kid/2 with valid data updates the kid" do
      kid = kid_fixture()
      assert {:ok, %Kid{} = kid} = Settings.update_kid(kid, @update_attrs)
      assert kid.chinese_name == "some updated chinese_name"
      assert kid.father == "some updated father"
      assert kid.mother == "some updated mother"
      assert kid.name == "some updated name"
    end

    test "update_kid/2 with invalid data returns error changeset" do
      kid = kid_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_kid(kid, @invalid_attrs)
      assert kid == Settings.get_kid!(kid.id)
    end

    test "delete_kid/1 deletes the kid" do
      kid = kid_fixture()
      assert {:ok, %Kid{}} = Settings.delete_kid(kid)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_kid!(kid.id) end
    end

    test "change_kid/1 returns a kid changeset" do
      kid = kid_fixture()
      assert %Ecto.Changeset{} = Settings.change_kid(kid)
    end
  end

  describe "feeds" do
    alias WebAcc.Settings.Feed

    @valid_attrs %{kid_id: 42, time_end: ~N[2010-04-17 14:00:00], time_start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{kid_id: 43, time_end: ~N[2011-05-18 15:01:01], time_start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{kid_id: nil, time_end: nil, time_start: nil}

    def feed_fixture(attrs \\ %{}) do
      {:ok, feed} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_feed()

      feed
    end

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Settings.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Settings.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      assert {:ok, %Feed{} = feed} = Settings.create_feed(@valid_attrs)
      assert feed.kid_id == 42
      assert feed.time_end == ~N[2010-04-17 14:00:00]
      assert feed.time_start == ~N[2010-04-17 14:00:00]
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{} = feed} = Settings.update_feed(feed, @update_attrs)
      assert feed.kid_id == 43
      assert feed.time_end == ~N[2011-05-18 15:01:01]
      assert feed.time_start == ~N[2011-05-18 15:01:01]
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_feed(feed, @invalid_attrs)
      assert feed == Settings.get_feed!(feed.id)
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Settings.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Settings.change_feed(feed)
    end
  end

  describe "reminders" do
    alias WebAcc.Settings.Reminder

    @valid_attrs %{kid_id: 42, name: "some name", timer_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{kid_id: 43, name: "some updated name", timer_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{kid_id: nil, name: nil, timer_at: nil}

    def reminder_fixture(attrs \\ %{}) do
      {:ok, reminder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_reminder()

      reminder
    end

    test "list_reminders/0 returns all reminders" do
      reminder = reminder_fixture()
      assert Settings.list_reminders() == [reminder]
    end

    test "get_reminder!/1 returns the reminder with given id" do
      reminder = reminder_fixture()
      assert Settings.get_reminder!(reminder.id) == reminder
    end

    test "create_reminder/1 with valid data creates a reminder" do
      assert {:ok, %Reminder{} = reminder} = Settings.create_reminder(@valid_attrs)
      assert reminder.kid_id == 42
      assert reminder.name == "some name"
      assert reminder.timer_at == ~N[2010-04-17 14:00:00]
    end

    test "create_reminder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_reminder(@invalid_attrs)
    end

    test "update_reminder/2 with valid data updates the reminder" do
      reminder = reminder_fixture()
      assert {:ok, %Reminder{} = reminder} = Settings.update_reminder(reminder, @update_attrs)
      assert reminder.kid_id == 43
      assert reminder.name == "some updated name"
      assert reminder.timer_at == ~N[2011-05-18 15:01:01]
    end

    test "update_reminder/2 with invalid data returns error changeset" do
      reminder = reminder_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_reminder(reminder, @invalid_attrs)
      assert reminder == Settings.get_reminder!(reminder.id)
    end

    test "delete_reminder/1 deletes the reminder" do
      reminder = reminder_fixture()
      assert {:ok, %Reminder{}} = Settings.delete_reminder(reminder)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_reminder!(reminder.id) end
    end

    test "change_reminder/1 returns a reminder changeset" do
      reminder = reminder_fixture()
      assert %Ecto.Changeset{} = Settings.change_reminder(reminder)
    end
  end

  describe "locations" do
    alias WebAcc.Settings.Location

    @valid_attrs %{address: "some address", contact: "some contact", lat: 120.5, long: 120.5, name: "some name"}
    @update_attrs %{address: "some updated address", contact: "some updated contact", lat: 456.7, long: 456.7, name: "some updated name"}
    @invalid_attrs %{address: nil, contact: nil, lat: nil, long: nil, name: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Settings.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Settings.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Settings.create_location(@valid_attrs)
      assert location.address == "some address"
      assert location.contact == "some contact"
      assert location.lat == 120.5
      assert location.long == 120.5
      assert location.name == "some name"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Settings.update_location(location, @update_attrs)
      assert location.address == "some updated address"
      assert location.contact == "some updated contact"
      assert location.lat == 456.7
      assert location.long == 456.7
      assert location.name == "some updated name"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_location(location, @invalid_attrs)
      assert location == Settings.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Settings.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Settings.change_location(location)
    end
  end

  describe "products" do
    alias WebAcc.Settings.Product

    @valid_attrs %{image_url: "some image_url", long_desc: "some long_desc", name: "some name", retail_price: 120.5, short_desc: "some short_desc", sku: "some sku"}
    @update_attrs %{image_url: "some updated image_url", long_desc: "some updated long_desc", name: "some updated name", retail_price: 456.7, short_desc: "some updated short_desc", sku: "some updated sku"}
    @invalid_attrs %{image_url: nil, long_desc: nil, name: nil, retail_price: nil, short_desc: nil, sku: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Settings.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Settings.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Settings.create_product(@valid_attrs)
      assert product.image_url == "some image_url"
      assert product.long_desc == "some long_desc"
      assert product.name == "some name"
      assert product.retail_price == 120.5
      assert product.short_desc == "some short_desc"
      assert product.sku == "some sku"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Settings.update_product(product, @update_attrs)
      assert product.image_url == "some updated image_url"
      assert product.long_desc == "some updated long_desc"
      assert product.name == "some updated name"
      assert product.retail_price == 456.7
      assert product.short_desc == "some updated short_desc"
      assert product.sku == "some updated sku"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_product(product, @invalid_attrs)
      assert product == Settings.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Settings.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Settings.change_product(product)
    end
  end

  describe "stock_levels" do
    alias WebAcc.Settings.StockLevel

    @valid_attrs %{available: 120.5, location_id: 42, min_alert: 120.5, min_order: 120.5, onhand: 120.5, ordered: 120.5, product_id: 42}
    @update_attrs %{available: 456.7, location_id: 43, min_alert: 456.7, min_order: 456.7, onhand: 456.7, ordered: 456.7, product_id: 43}
    @invalid_attrs %{available: nil, location_id: nil, min_alert: nil, min_order: nil, onhand: nil, ordered: nil, product_id: nil}

    def stock_level_fixture(attrs \\ %{}) do
      {:ok, stock_level} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stock_level()

      stock_level
    end

    test "list_stock_levels/0 returns all stock_levels" do
      stock_level = stock_level_fixture()
      assert Settings.list_stock_levels() == [stock_level]
    end

    test "get_stock_level!/1 returns the stock_level with given id" do
      stock_level = stock_level_fixture()
      assert Settings.get_stock_level!(stock_level.id) == stock_level
    end

    test "create_stock_level/1 with valid data creates a stock_level" do
      assert {:ok, %StockLevel{} = stock_level} = Settings.create_stock_level(@valid_attrs)
      assert stock_level.available == 120.5
      assert stock_level.location_id == 42
      assert stock_level.min_alert == 120.5
      assert stock_level.min_order == 120.5
      assert stock_level.onhand == 120.5
      assert stock_level.ordered == 120.5
      assert stock_level.product_id == 42
    end

    test "create_stock_level/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stock_level(@invalid_attrs)
    end

    test "update_stock_level/2 with valid data updates the stock_level" do
      stock_level = stock_level_fixture()
      assert {:ok, %StockLevel{} = stock_level} = Settings.update_stock_level(stock_level, @update_attrs)
      assert stock_level.available == 456.7
      assert stock_level.location_id == 43
      assert stock_level.min_alert == 456.7
      assert stock_level.min_order == 456.7
      assert stock_level.onhand == 456.7
      assert stock_level.ordered == 456.7
      assert stock_level.product_id == 43
    end

    test "update_stock_level/2 with invalid data returns error changeset" do
      stock_level = stock_level_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_stock_level(stock_level, @invalid_attrs)
      assert stock_level == Settings.get_stock_level!(stock_level.id)
    end

    test "delete_stock_level/1 deletes the stock_level" do
      stock_level = stock_level_fixture()
      assert {:ok, %StockLevel{}} = Settings.delete_stock_level(stock_level)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stock_level!(stock_level.id) end
    end

    test "change_stock_level/1 returns a stock_level changeset" do
      stock_level = stock_level_fixture()
      assert %Ecto.Changeset{} = Settings.change_stock_level(stock_level)
    end
  end

  describe "stock_movements" do
    alias WebAcc.Settings.StockMovement

    @valid_attrs %{action: "some action", location_id: 42, product_id: 42, quantity: 120.5, reference: "some reference"}
    @update_attrs %{action: "some updated action", location_id: 43, product_id: 43, quantity: 456.7, reference: "some updated reference"}
    @invalid_attrs %{action: nil, location_id: nil, product_id: nil, quantity: nil, reference: nil}

    def stock_movement_fixture(attrs \\ %{}) do
      {:ok, stock_movement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stock_movement()

      stock_movement
    end

    test "list_stock_movements/0 returns all stock_movements" do
      stock_movement = stock_movement_fixture()
      assert Settings.list_stock_movements() == [stock_movement]
    end

    test "get_stock_movement!/1 returns the stock_movement with given id" do
      stock_movement = stock_movement_fixture()
      assert Settings.get_stock_movement!(stock_movement.id) == stock_movement
    end

    test "create_stock_movement/1 with valid data creates a stock_movement" do
      assert {:ok, %StockMovement{} = stock_movement} = Settings.create_stock_movement(@valid_attrs)
      assert stock_movement.action == "some action"
      assert stock_movement.location_id == 42
      assert stock_movement.product_id == 42
      assert stock_movement.quantity == 120.5
      assert stock_movement.reference == "some reference"
    end

    test "create_stock_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stock_movement(@invalid_attrs)
    end

    test "update_stock_movement/2 with valid data updates the stock_movement" do
      stock_movement = stock_movement_fixture()
      assert {:ok, %StockMovement{} = stock_movement} = Settings.update_stock_movement(stock_movement, @update_attrs)
      assert stock_movement.action == "some updated action"
      assert stock_movement.location_id == 43
      assert stock_movement.product_id == 43
      assert stock_movement.quantity == 456.7
      assert stock_movement.reference == "some updated reference"
    end

    test "update_stock_movement/2 with invalid data returns error changeset" do
      stock_movement = stock_movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_stock_movement(stock_movement, @invalid_attrs)
      assert stock_movement == Settings.get_stock_movement!(stock_movement.id)
    end

    test "delete_stock_movement/1 deletes the stock_movement" do
      stock_movement = stock_movement_fixture()
      assert {:ok, %StockMovement{}} = Settings.delete_stock_movement(stock_movement)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stock_movement!(stock_movement.id) end
    end

    test "change_stock_movement/1 returns a stock_movement changeset" do
      stock_movement = stock_movement_fixture()
      assert %Ecto.Changeset{} = Settings.change_stock_movement(stock_movement)
    end
  end

  describe "suppliers" do
    alias WebAcc.Settings.Supplier

    @valid_attrs %{address: "some address", contact: "some contact", name: "some name"}
    @update_attrs %{address: "some updated address", contact: "some updated contact", name: "some updated name"}
    @invalid_attrs %{address: nil, contact: nil, name: nil}

    def supplier_fixture(attrs \\ %{}) do
      {:ok, supplier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_supplier()

      supplier
    end

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Settings.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Settings.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      assert {:ok, %Supplier{} = supplier} = Settings.create_supplier(@valid_attrs)
      assert supplier.address == "some address"
      assert supplier.contact == "some contact"
      assert supplier.name == "some name"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{} = supplier} = Settings.update_supplier(supplier, @update_attrs)
      assert supplier.address == "some updated address"
      assert supplier.contact == "some updated contact"
      assert supplier.name == "some updated name"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_supplier(supplier, @invalid_attrs)
      assert supplier == Settings.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Settings.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Settings.change_supplier(supplier)
    end
  end

  describe "supplier_products" do
    alias WebAcc.Settings.SupplierProduct

    @valid_attrs %{product_id: 42, supplier_id: 42}
    @update_attrs %{product_id: 43, supplier_id: 43}
    @invalid_attrs %{product_id: nil, supplier_id: nil}

    def supplier_product_fixture(attrs \\ %{}) do
      {:ok, supplier_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_supplier_product()

      supplier_product
    end

    test "list_supplier_products/0 returns all supplier_products" do
      supplier_product = supplier_product_fixture()
      assert Settings.list_supplier_products() == [supplier_product]
    end

    test "get_supplier_product!/1 returns the supplier_product with given id" do
      supplier_product = supplier_product_fixture()
      assert Settings.get_supplier_product!(supplier_product.id) == supplier_product
    end

    test "create_supplier_product/1 with valid data creates a supplier_product" do
      assert {:ok, %SupplierProduct{} = supplier_product} = Settings.create_supplier_product(@valid_attrs)
      assert supplier_product.product_id == 42
      assert supplier_product.supplier_id == 42
    end

    test "create_supplier_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_supplier_product(@invalid_attrs)
    end

    test "update_supplier_product/2 with valid data updates the supplier_product" do
      supplier_product = supplier_product_fixture()
      assert {:ok, %SupplierProduct{} = supplier_product} = Settings.update_supplier_product(supplier_product, @update_attrs)
      assert supplier_product.product_id == 43
      assert supplier_product.supplier_id == 43
    end

    test "update_supplier_product/2 with invalid data returns error changeset" do
      supplier_product = supplier_product_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_supplier_product(supplier_product, @invalid_attrs)
      assert supplier_product == Settings.get_supplier_product!(supplier_product.id)
    end

    test "delete_supplier_product/1 deletes the supplier_product" do
      supplier_product = supplier_product_fixture()
      assert {:ok, %SupplierProduct{}} = Settings.delete_supplier_product(supplier_product)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_supplier_product!(supplier_product.id) end
    end

    test "change_supplier_product/1 returns a supplier_product changeset" do
      supplier_product = supplier_product_fixture()
      assert %Ecto.Changeset{} = Settings.change_supplier_product(supplier_product)
    end
  end

  describe "purchase_orders" do
    alias WebAcc.Settings.PurchaseOrder

    @valid_attrs %{quantity: 120.5, supplier_product_id: 42}
    @update_attrs %{quantity: 456.7, supplier_product_id: 43}
    @invalid_attrs %{quantity: nil, supplier_product_id: nil}

    def purchase_order_fixture(attrs \\ %{}) do
      {:ok, purchase_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_purchase_order()

      purchase_order
    end

    test "list_purchase_orders/0 returns all purchase_orders" do
      purchase_order = purchase_order_fixture()
      assert Settings.list_purchase_orders() == [purchase_order]
    end

    test "get_purchase_order!/1 returns the purchase_order with given id" do
      purchase_order = purchase_order_fixture()
      assert Settings.get_purchase_order!(purchase_order.id) == purchase_order
    end

    test "create_purchase_order/1 with valid data creates a purchase_order" do
      assert {:ok, %PurchaseOrder{} = purchase_order} = Settings.create_purchase_order(@valid_attrs)
      assert purchase_order.quantity == 120.5
      assert purchase_order.supplier_product_id == 42
    end

    test "create_purchase_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_purchase_order(@invalid_attrs)
    end

    test "update_purchase_order/2 with valid data updates the purchase_order" do
      purchase_order = purchase_order_fixture()
      assert {:ok, %PurchaseOrder{} = purchase_order} = Settings.update_purchase_order(purchase_order, @update_attrs)
      assert purchase_order.quantity == 456.7
      assert purchase_order.supplier_product_id == 43
    end

    test "update_purchase_order/2 with invalid data returns error changeset" do
      purchase_order = purchase_order_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_purchase_order(purchase_order, @invalid_attrs)
      assert purchase_order == Settings.get_purchase_order!(purchase_order.id)
    end

    test "delete_purchase_order/1 deletes the purchase_order" do
      purchase_order = purchase_order_fixture()
      assert {:ok, %PurchaseOrder{}} = Settings.delete_purchase_order(purchase_order)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_purchase_order!(purchase_order.id) end
    end

    test "change_purchase_order/1 returns a purchase_order changeset" do
      purchase_order = purchase_order_fixture()
      assert %Ecto.Changeset{} = Settings.change_purchase_order(purchase_order)
    end
  end

  describe "purchase_order_masters" do
    alias WebAcc.Settings.PurchaseOrderMaster

    @valid_attrs %{location_id: 42, order_date: ~D[2010-04-17], request_by: "some request_by", status: "some status"}
    @update_attrs %{location_id: 43, order_date: ~D[2011-05-18], request_by: "some updated request_by", status: "some updated status"}
    @invalid_attrs %{location_id: nil, order_date: nil, request_by: nil, status: nil}

    def purchase_order_master_fixture(attrs \\ %{}) do
      {:ok, purchase_order_master} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_purchase_order_master()

      purchase_order_master
    end

    test "list_purchase_order_masters/0 returns all purchase_order_masters" do
      purchase_order_master = purchase_order_master_fixture()
      assert Settings.list_purchase_order_masters() == [purchase_order_master]
    end

    test "get_purchase_order_master!/1 returns the purchase_order_master with given id" do
      purchase_order_master = purchase_order_master_fixture()
      assert Settings.get_purchase_order_master!(purchase_order_master.id) == purchase_order_master
    end

    test "create_purchase_order_master/1 with valid data creates a purchase_order_master" do
      assert {:ok, %PurchaseOrderMaster{} = purchase_order_master} = Settings.create_purchase_order_master(@valid_attrs)
      assert purchase_order_master.location_id == 42
      assert purchase_order_master.order_date == ~D[2010-04-17]
      assert purchase_order_master.request_by == "some request_by"
      assert purchase_order_master.status == "some status"
    end

    test "create_purchase_order_master/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_purchase_order_master(@invalid_attrs)
    end

    test "update_purchase_order_master/2 with valid data updates the purchase_order_master" do
      purchase_order_master = purchase_order_master_fixture()
      assert {:ok, %PurchaseOrderMaster{} = purchase_order_master} = Settings.update_purchase_order_master(purchase_order_master, @update_attrs)
      assert purchase_order_master.location_id == 43
      assert purchase_order_master.order_date == ~D[2011-05-18]
      assert purchase_order_master.request_by == "some updated request_by"
      assert purchase_order_master.status == "some updated status"
    end

    test "update_purchase_order_master/2 with invalid data returns error changeset" do
      purchase_order_master = purchase_order_master_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_purchase_order_master(purchase_order_master, @invalid_attrs)
      assert purchase_order_master == Settings.get_purchase_order_master!(purchase_order_master.id)
    end

    test "delete_purchase_order_master/1 deletes the purchase_order_master" do
      purchase_order_master = purchase_order_master_fixture()
      assert {:ok, %PurchaseOrderMaster{}} = Settings.delete_purchase_order_master(purchase_order_master)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_purchase_order_master!(purchase_order_master.id) end
    end

    test "change_purchase_order_master/1 returns a purchase_order_master changeset" do
      purchase_order_master = purchase_order_master_fixture()
      assert %Ecto.Changeset{} = Settings.change_purchase_order_master(purchase_order_master)
    end
  end

  describe "stock_receives" do
    alias WebAcc.Settings.StockReceive

    @valid_attrs %{pom_id: 42, received_by: "some received_by", status: "some status"}
    @update_attrs %{pom_id: 43, received_by: "some updated received_by", status: "some updated status"}
    @invalid_attrs %{pom_id: nil, received_by: nil, status: nil}

    def stock_receive_fixture(attrs \\ %{}) do
      {:ok, stock_receive} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stock_receive()

      stock_receive
    end

    test "list_stock_receives/0 returns all stock_receives" do
      stock_receive = stock_receive_fixture()
      assert Settings.list_stock_receives() == [stock_receive]
    end

    test "get_stock_receive!/1 returns the stock_receive with given id" do
      stock_receive = stock_receive_fixture()
      assert Settings.get_stock_receive!(stock_receive.id) == stock_receive
    end

    test "create_stock_receive/1 with valid data creates a stock_receive" do
      assert {:ok, %StockReceive{} = stock_receive} = Settings.create_stock_receive(@valid_attrs)
      assert stock_receive.pom_id == 42
      assert stock_receive.received_by == "some received_by"
      assert stock_receive.status == "some status"
    end

    test "create_stock_receive/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stock_receive(@invalid_attrs)
    end

    test "update_stock_receive/2 with valid data updates the stock_receive" do
      stock_receive = stock_receive_fixture()
      assert {:ok, %StockReceive{} = stock_receive} = Settings.update_stock_receive(stock_receive, @update_attrs)
      assert stock_receive.pom_id == 43
      assert stock_receive.received_by == "some updated received_by"
      assert stock_receive.status == "some updated status"
    end

    test "update_stock_receive/2 with invalid data returns error changeset" do
      stock_receive = stock_receive_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_stock_receive(stock_receive, @invalid_attrs)
      assert stock_receive == Settings.get_stock_receive!(stock_receive.id)
    end

    test "delete_stock_receive/1 deletes the stock_receive" do
      stock_receive = stock_receive_fixture()
      assert {:ok, %StockReceive{}} = Settings.delete_stock_receive(stock_receive)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stock_receive!(stock_receive.id) end
    end

    test "change_stock_receive/1 returns a stock_receive changeset" do
      stock_receive = stock_receive_fixture()
      assert %Ecto.Changeset{} = Settings.change_stock_receive(stock_receive)
    end
  end

  describe "stock_receive_masters" do
    alias WebAcc.Settings.StockReceiveMaster

    @valid_attrs %{pom_id: 42, srn_no: "some srn_no", status: "some status"}
    @update_attrs %{pom_id: 43, srn_no: "some updated srn_no", status: "some updated status"}
    @invalid_attrs %{pom_id: nil, srn_no: nil, status: nil}

    def stock_receive_master_fixture(attrs \\ %{}) do
      {:ok, stock_receive_master} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stock_receive_master()

      stock_receive_master
    end

    test "list_stock_receive_masters/0 returns all stock_receive_masters" do
      stock_receive_master = stock_receive_master_fixture()
      assert Settings.list_stock_receive_masters() == [stock_receive_master]
    end

    test "get_stock_receive_master!/1 returns the stock_receive_master with given id" do
      stock_receive_master = stock_receive_master_fixture()
      assert Settings.get_stock_receive_master!(stock_receive_master.id) == stock_receive_master
    end

    test "create_stock_receive_master/1 with valid data creates a stock_receive_master" do
      assert {:ok, %StockReceiveMaster{} = stock_receive_master} = Settings.create_stock_receive_master(@valid_attrs)
      assert stock_receive_master.pom_id == 42
      assert stock_receive_master.srn_no == "some srn_no"
      assert stock_receive_master.status == "some status"
    end

    test "create_stock_receive_master/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stock_receive_master(@invalid_attrs)
    end

    test "update_stock_receive_master/2 with valid data updates the stock_receive_master" do
      stock_receive_master = stock_receive_master_fixture()
      assert {:ok, %StockReceiveMaster{} = stock_receive_master} = Settings.update_stock_receive_master(stock_receive_master, @update_attrs)
      assert stock_receive_master.pom_id == 43
      assert stock_receive_master.srn_no == "some updated srn_no"
      assert stock_receive_master.status == "some updated status"
    end

    test "update_stock_receive_master/2 with invalid data returns error changeset" do
      stock_receive_master = stock_receive_master_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_stock_receive_master(stock_receive_master, @invalid_attrs)
      assert stock_receive_master == Settings.get_stock_receive_master!(stock_receive_master.id)
    end

    test "delete_stock_receive_master/1 deletes the stock_receive_master" do
      stock_receive_master = stock_receive_master_fixture()
      assert {:ok, %StockReceiveMaster{}} = Settings.delete_stock_receive_master(stock_receive_master)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stock_receive_master!(stock_receive_master.id) end
    end

    test "change_stock_receive_master/1 returns a stock_receive_master changeset" do
      stock_receive_master = stock_receive_master_fixture()
      assert %Ecto.Changeset{} = Settings.change_stock_receive_master(stock_receive_master)
    end
  end

  describe "sales_order_masters" do
    alias WebAcc.Settings.SalesOrderMaster

    @valid_attrs %{created_by: "some created_by", customer_id: 42, delivery_date: ~D[2010-04-17], lat: 120.5, long: 120.5, status: "some status", to: "some to"}
    @update_attrs %{created_by: "some updated created_by", customer_id: 43, delivery_date: ~D[2011-05-18], lat: 456.7, long: 456.7, status: "some updated status", to: "some updated to"}
    @invalid_attrs %{created_by: nil, customer_id: nil, delivery_date: nil, lat: nil, long: nil, status: nil, to: nil}

    def sales_order_master_fixture(attrs \\ %{}) do
      {:ok, sales_order_master} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_sales_order_master()

      sales_order_master
    end

    test "list_sales_order_masters/0 returns all sales_order_masters" do
      sales_order_master = sales_order_master_fixture()
      assert Settings.list_sales_order_masters() == [sales_order_master]
    end

    test "get_sales_order_master!/1 returns the sales_order_master with given id" do
      sales_order_master = sales_order_master_fixture()
      assert Settings.get_sales_order_master!(sales_order_master.id) == sales_order_master
    end

    test "create_sales_order_master/1 with valid data creates a sales_order_master" do
      assert {:ok, %SalesOrderMaster{} = sales_order_master} = Settings.create_sales_order_master(@valid_attrs)
      assert sales_order_master.created_by == "some created_by"
      assert sales_order_master.customer_id == 42
      assert sales_order_master.delivery_date == ~D[2010-04-17]
      assert sales_order_master.lat == 120.5
      assert sales_order_master.long == 120.5
      assert sales_order_master.status == "some status"
      assert sales_order_master.to == "some to"
    end

    test "create_sales_order_master/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_sales_order_master(@invalid_attrs)
    end

    test "update_sales_order_master/2 with valid data updates the sales_order_master" do
      sales_order_master = sales_order_master_fixture()
      assert {:ok, %SalesOrderMaster{} = sales_order_master} = Settings.update_sales_order_master(sales_order_master, @update_attrs)
      assert sales_order_master.created_by == "some updated created_by"
      assert sales_order_master.customer_id == 43
      assert sales_order_master.delivery_date == ~D[2011-05-18]
      assert sales_order_master.lat == 456.7
      assert sales_order_master.long == 456.7
      assert sales_order_master.status == "some updated status"
      assert sales_order_master.to == "some updated to"
    end

    test "update_sales_order_master/2 with invalid data returns error changeset" do
      sales_order_master = sales_order_master_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_sales_order_master(sales_order_master, @invalid_attrs)
      assert sales_order_master == Settings.get_sales_order_master!(sales_order_master.id)
    end

    test "delete_sales_order_master/1 deletes the sales_order_master" do
      sales_order_master = sales_order_master_fixture()
      assert {:ok, %SalesOrderMaster{}} = Settings.delete_sales_order_master(sales_order_master)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_sales_order_master!(sales_order_master.id) end
    end

    test "change_sales_order_master/1 returns a sales_order_master changeset" do
      sales_order_master = sales_order_master_fixture()
      assert %Ecto.Changeset{} = Settings.change_sales_order_master(sales_order_master)
    end
  end

  describe "sales_orders" do
    alias WebAcc.Settings.SalesOrder

    @valid_attrs %{product_id: 42, product_name: "some product_name", quantity: 120.5, selling_price: 120.5, som_id: 42, unit_price: 120.5}
    @update_attrs %{product_id: 43, product_name: "some updated product_name", quantity: 456.7, selling_price: 456.7, som_id: 43, unit_price: 456.7}
    @invalid_attrs %{product_id: nil, product_name: nil, quantity: nil, selling_price: nil, som_id: nil, unit_price: nil}

    def sales_order_fixture(attrs \\ %{}) do
      {:ok, sales_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_sales_order()

      sales_order
    end

    test "list_sales_orders/0 returns all sales_orders" do
      sales_order = sales_order_fixture()
      assert Settings.list_sales_orders() == [sales_order]
    end

    test "get_sales_order!/1 returns the sales_order with given id" do
      sales_order = sales_order_fixture()
      assert Settings.get_sales_order!(sales_order.id) == sales_order
    end

    test "create_sales_order/1 with valid data creates a sales_order" do
      assert {:ok, %SalesOrder{} = sales_order} = Settings.create_sales_order(@valid_attrs)
      assert sales_order.product_id == 42
      assert sales_order.product_name == "some product_name"
      assert sales_order.quantity == 120.5
      assert sales_order.selling_price == 120.5
      assert sales_order.som_id == 42
      assert sales_order.unit_price == 120.5
    end

    test "create_sales_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_sales_order(@invalid_attrs)
    end

    test "update_sales_order/2 with valid data updates the sales_order" do
      sales_order = sales_order_fixture()
      assert {:ok, %SalesOrder{} = sales_order} = Settings.update_sales_order(sales_order, @update_attrs)
      assert sales_order.product_id == 43
      assert sales_order.product_name == "some updated product_name"
      assert sales_order.quantity == 456.7
      assert sales_order.selling_price == 456.7
      assert sales_order.som_id == 43
      assert sales_order.unit_price == 456.7
    end

    test "update_sales_order/2 with invalid data returns error changeset" do
      sales_order = sales_order_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_sales_order(sales_order, @invalid_attrs)
      assert sales_order == Settings.get_sales_order!(sales_order.id)
    end

    test "delete_sales_order/1 deletes the sales_order" do
      sales_order = sales_order_fixture()
      assert {:ok, %SalesOrder{}} = Settings.delete_sales_order(sales_order)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_sales_order!(sales_order.id) end
    end

    test "change_sales_order/1 returns a sales_order changeset" do
      sales_order = sales_order_fixture()
      assert %Ecto.Changeset{} = Settings.change_sales_order(sales_order)
    end
  end

  describe "customers" do
    alias WebAcc.Settings.Customer

    @valid_attrs %{address: "some address", email: "some email", name: "some name", organization: "some organization", phone: "some phone", terms: "some terms"}
    @update_attrs %{address: "some updated address", email: "some updated email", name: "some updated name", organization: "some updated organization", phone: "some updated phone", terms: "some updated terms"}
    @invalid_attrs %{address: nil, email: nil, name: nil, organization: nil, phone: nil, terms: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Settings.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Settings.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Settings.create_customer(@valid_attrs)
      assert customer.address == "some address"
      assert customer.email == "some email"
      assert customer.name == "some name"
      assert customer.organization == "some organization"
      assert customer.phone == "some phone"
      assert customer.terms == "some terms"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Settings.update_customer(customer, @update_attrs)
      assert customer.address == "some updated address"
      assert customer.email == "some updated email"
      assert customer.name == "some updated name"
      assert customer.organization == "some updated organization"
      assert customer.phone == "some updated phone"
      assert customer.terms == "some updated terms"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_customer(customer, @invalid_attrs)
      assert customer == Settings.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Settings.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Settings.change_customer(customer)
    end
  end

  describe "stock_transfer_master" do
    alias WebAcc.Settings.StockTransferMaster

    @valid_attrs %{delivery_date: ~D[2010-04-17], from_id: 42, status: "some status", to_id: 42}
    @update_attrs %{delivery_date: ~D[2011-05-18], from_id: 43, status: "some updated status", to_id: 43}
    @invalid_attrs %{delivery_date: nil, from_id: nil, status: nil, to_id: nil}

    def stock_transfer_master_fixture(attrs \\ %{}) do
      {:ok, stock_transfer_master} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stock_transfer_master()

      stock_transfer_master
    end

    test "list_stock_transfer_master/0 returns all stock_transfer_master" do
      stock_transfer_master = stock_transfer_master_fixture()
      assert Settings.list_stock_transfer_master() == [stock_transfer_master]
    end

    test "get_stock_transfer_master!/1 returns the stock_transfer_master with given id" do
      stock_transfer_master = stock_transfer_master_fixture()
      assert Settings.get_stock_transfer_master!(stock_transfer_master.id) == stock_transfer_master
    end

    test "create_stock_transfer_master/1 with valid data creates a stock_transfer_master" do
      assert {:ok, %StockTransferMaster{} = stock_transfer_master} = Settings.create_stock_transfer_master(@valid_attrs)
      assert stock_transfer_master.delivery_date == ~D[2010-04-17]
      assert stock_transfer_master.from_id == 42
      assert stock_transfer_master.status == "some status"
      assert stock_transfer_master.to_id == 42
    end

    test "create_stock_transfer_master/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stock_transfer_master(@invalid_attrs)
    end

    test "update_stock_transfer_master/2 with valid data updates the stock_transfer_master" do
      stock_transfer_master = stock_transfer_master_fixture()
      assert {:ok, %StockTransferMaster{} = stock_transfer_master} = Settings.update_stock_transfer_master(stock_transfer_master, @update_attrs)
      assert stock_transfer_master.delivery_date == ~D[2011-05-18]
      assert stock_transfer_master.from_id == 43
      assert stock_transfer_master.status == "some updated status"
      assert stock_transfer_master.to_id == 43
    end

    test "update_stock_transfer_master/2 with invalid data returns error changeset" do
      stock_transfer_master = stock_transfer_master_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_stock_transfer_master(stock_transfer_master, @invalid_attrs)
      assert stock_transfer_master == Settings.get_stock_transfer_master!(stock_transfer_master.id)
    end

    test "delete_stock_transfer_master/1 deletes the stock_transfer_master" do
      stock_transfer_master = stock_transfer_master_fixture()
      assert {:ok, %StockTransferMaster{}} = Settings.delete_stock_transfer_master(stock_transfer_master)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stock_transfer_master!(stock_transfer_master.id) end
    end

    test "change_stock_transfer_master/1 returns a stock_transfer_master changeset" do
      stock_transfer_master = stock_transfer_master_fixture()
      assert %Ecto.Changeset{} = Settings.change_stock_transfer_master(stock_transfer_master)
    end
  end

  describe "stock_transfers" do
    alias WebAcc.Settings.StockTransfer

    @valid_attrs %{product_id: 42, product_name: "some product_name", quantity: 120.5, stm_id: 42}
    @update_attrs %{product_id: 43, product_name: "some updated product_name", quantity: 456.7, stm_id: 43}
    @invalid_attrs %{product_id: nil, product_name: nil, quantity: nil, stm_id: nil}

    def stock_transfer_fixture(attrs \\ %{}) do
      {:ok, stock_transfer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stock_transfer()

      stock_transfer
    end

    test "list_stock_transfers/0 returns all stock_transfers" do
      stock_transfer = stock_transfer_fixture()
      assert Settings.list_stock_transfers() == [stock_transfer]
    end

    test "get_stock_transfer!/1 returns the stock_transfer with given id" do
      stock_transfer = stock_transfer_fixture()
      assert Settings.get_stock_transfer!(stock_transfer.id) == stock_transfer
    end

    test "create_stock_transfer/1 with valid data creates a stock_transfer" do
      assert {:ok, %StockTransfer{} = stock_transfer} = Settings.create_stock_transfer(@valid_attrs)
      assert stock_transfer.product_id == 42
      assert stock_transfer.product_name == "some product_name"
      assert stock_transfer.quantity == 120.5
      assert stock_transfer.stm_id == 42
    end

    test "create_stock_transfer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stock_transfer(@invalid_attrs)
    end

    test "update_stock_transfer/2 with valid data updates the stock_transfer" do
      stock_transfer = stock_transfer_fixture()
      assert {:ok, %StockTransfer{} = stock_transfer} = Settings.update_stock_transfer(stock_transfer, @update_attrs)
      assert stock_transfer.product_id == 43
      assert stock_transfer.product_name == "some updated product_name"
      assert stock_transfer.quantity == 456.7
      assert stock_transfer.stm_id == 43
    end

    test "update_stock_transfer/2 with invalid data returns error changeset" do
      stock_transfer = stock_transfer_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_stock_transfer(stock_transfer, @invalid_attrs)
      assert stock_transfer == Settings.get_stock_transfer!(stock_transfer.id)
    end

    test "delete_stock_transfer/1 deletes the stock_transfer" do
      stock_transfer = stock_transfer_fixture()
      assert {:ok, %StockTransfer{}} = Settings.delete_stock_transfer(stock_transfer)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stock_transfer!(stock_transfer.id) end
    end

    test "change_stock_transfer/1 returns a stock_transfer changeset" do
      stock_transfer = stock_transfer_fixture()
      assert %Ecto.Changeset{} = Settings.change_stock_transfer(stock_transfer)
    end
  end

  describe "serial_nos" do
    alias WebAcc.Settings.SerialNo

    @valid_attrs %{product_id: 42, serial_no: "some serial_no"}
    @update_attrs %{product_id: 43, serial_no: "some updated serial_no"}
    @invalid_attrs %{product_id: nil, serial_no: nil}

    def serial_no_fixture(attrs \\ %{}) do
      {:ok, serial_no} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_serial_no()

      serial_no
    end

    test "list_serial_nos/0 returns all serial_nos" do
      serial_no = serial_no_fixture()
      assert Settings.list_serial_nos() == [serial_no]
    end

    test "get_serial_no!/1 returns the serial_no with given id" do
      serial_no = serial_no_fixture()
      assert Settings.get_serial_no!(serial_no.id) == serial_no
    end

    test "create_serial_no/1 with valid data creates a serial_no" do
      assert {:ok, %SerialNo{} = serial_no} = Settings.create_serial_no(@valid_attrs)
      assert serial_no.product_id == 42
      assert serial_no.serial_no == "some serial_no"
    end

    test "create_serial_no/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_serial_no(@invalid_attrs)
    end

    test "update_serial_no/2 with valid data updates the serial_no" do
      serial_no = serial_no_fixture()
      assert {:ok, %SerialNo{} = serial_no} = Settings.update_serial_no(serial_no, @update_attrs)
      assert serial_no.product_id == 43
      assert serial_no.serial_no == "some updated serial_no"
    end

    test "update_serial_no/2 with invalid data returns error changeset" do
      serial_no = serial_no_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_serial_no(serial_no, @invalid_attrs)
      assert serial_no == Settings.get_serial_no!(serial_no.id)
    end

    test "delete_serial_no/1 deletes the serial_no" do
      serial_no = serial_no_fixture()
      assert {:ok, %SerialNo{}} = Settings.delete_serial_no(serial_no)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_serial_no!(serial_no.id) end
    end

    test "change_serial_no/1 returns a serial_no changeset" do
      serial_no = serial_no_fixture()
      assert %Ecto.Changeset{} = Settings.change_serial_no(serial_no)
    end
  end
end
