defmodule ContainerClusterNoWebpackWeb.PageControllerTest do
  use ContainerClusterNoWebpackWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
