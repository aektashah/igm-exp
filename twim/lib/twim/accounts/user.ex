defmodule Twim.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twim.Accounts.User


  schema "users" do
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
  end
end
