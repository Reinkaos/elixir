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
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name username), [])
    |> validate_length(:username, min: 1, max: 20)
  end

end
