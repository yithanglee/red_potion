defmodule WebAccWeb.MobilePageController do
  use WebAccWeb, :controller
  import Ecto.Query
  alias WebAcc.{Settings, Repo}
  
  def index(conn, params) do
     render(conn, "index.html", layout: {WebAccWeb.LayoutView, "mobile.html"})
  end


end
