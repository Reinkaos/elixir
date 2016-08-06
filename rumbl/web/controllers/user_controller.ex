defmodule Rumbl.UserController do
  use Rumbl.Web, :controller

  def index(conn, _params) do
    # retrieve all of the users from the User struct
    users = Repo.all(Rumbl.User)
    render conn, "index.html", users: users
  end

end
