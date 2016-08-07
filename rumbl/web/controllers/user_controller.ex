defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  # this pipes the method before the listed actions
  plug :authenticate when action in [:index, :show]
  alias Rumbl.User

  # retrieve all of the users from the User struct
  # using a method that we defined on lib/rumbl/repo.ex
  def index(conn, _params) do
    users = Repo.all(Rumbl.User)
    render conn, "index.html", users: users
  end

  # retrieve one of the users from the User struct
  # using a method that we defined on lib/rumbl/repo.ex
  def show(conn, %{"id" => id}) do
    user = Repo.get(Rumbl.User, id)
    render conn, "show.html", user: user
  end

  # this function recieves a struct and the controller params
  # Changesets let Ecto manage record changes, cast params and perform validations.
  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Rumbl.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # if there is a current user, return the unchanged connection
  # otherwise redirect the user and halt the connection
  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

end
