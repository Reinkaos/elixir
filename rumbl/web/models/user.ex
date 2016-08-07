defmodule Rumbl.User do
  # defstruct [:id, :name, :username, :password]
  use Rumbl.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true # This creates a field that does not persist to the DB
    field :password_hash, :string

    timestamps
  end

  # Cast validates that the listed params are present
  # if there are no params it will default to the atom :empty
  # This is to distinguish a blank changeset from an empty form
  # This is the basic changeset for a name and username update
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name username), [])
    |> validate_length(:username, min: 1, max: 20)
  end

  # We are using this changset for passwords
  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      # if the change is valid
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      # if its not valid, exit
      _ ->
        changeset
    end
  end

end
