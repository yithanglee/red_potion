defmodule WebAccWeb.LandingPageController do
  use WebAccWeb, :controller
  import Ecto.Query
  alias WebAcc.{Settings, Repo}
  
  def index(conn, params) do
     render(conn, "index.html", layout: {WebAccWeb.LayoutView, "frontend.html"})
  end


end
