defmodule HelloPhoenixWeb.HelloLaunchdarklyController do
  use HelloPhoenixWeb, :controller

  def hellouser(conn, %{"user" => user}) do
    render(conn, "user.html", user: user)
  end
end
