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
end
