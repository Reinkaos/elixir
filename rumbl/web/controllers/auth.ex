defmodule Rumbl.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller # for put_flash and redirect used in authenticate_user
  # We alias this so that we do not cause a circular dependancy when we use the authenticate_user method in our router
  alias Rumbl.Router.Helpers

  def init(opts) do
    # Extract the repo
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    # call recieves the repo from init
    user_id = get_session(conn, :user_id)
    user    = user_id && repo.get(Rumbl.User, user_id)
    # this allows the current_user to be accessed further down the pipeline
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    # This protects us from session fixation attacks
    |> configure_session(renew: true)
  end

  def login_by_username_and_pass(conn, username, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Rumbl.User, username: username)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        # This is to protect us against timing attacks
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  # This drops the entire session
  # If you want to delete just the id, you can do:
  # delete_session(conn, :user_id)
  def logout(conn) do
    configure_session(conn, drop: true)
  end

  # if there is a current user, return the unchanged connection
  # otherwise redirect the user and halt the connection
  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
