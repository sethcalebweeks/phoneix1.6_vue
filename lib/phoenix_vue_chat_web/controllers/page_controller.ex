defmodule PhoenixVueChatWeb.PageController do
  use PhoenixVueChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
