defmodule NflWeb.PageController do
  use NflWeb, :controller

  def index(conn, params) do
    render(conn, "index.html")
  end
end
