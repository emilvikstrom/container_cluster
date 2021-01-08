defmodule ContainerClusterNoWebpackWeb.PageController do
  use ContainerClusterNoWebpackWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> json([node() | Node.list()])
  end
end
