defmodule HelloPhoenixWeb.HelloLaunchdarklyController do
  use HelloPhoenixWeb, :controller

  def hellouser(conn, %{"user" => user}) do
    alternate_page = :ldclient.variation("alternate.page", %{:key => user}, false)
    render(conn, hello_template(alternate_page), user: user)
  end

  def hello_template(:true) do
    "user-alternate.html"
  end

  def hello_template(_) do
    "user.html"
  end

end
