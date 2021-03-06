defmodule BadgerData.Schema.User do
  @moduledoc """
  User DataModel.
  """
  use Ecto.Schema
  alias BadgerData.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:pwd, :string, virtual: true)
    field(:pwd_hash, :string)
    timestamps(type: :utc_datetime)

    has_many(:sites, Schema.Site)
    has_many(:downstreams, Schema.Downstream)
  end

  def changeset(user, attrs) do
    required_fields = [:name, :email]
    optional_fields = [:id, :pwd, :pwd_hash]

    user
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> validate_length(:name, min: 2, max: 12)
    |> unique_constraint(:email)
  end

  def signup_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:pwd])
    |> validate_required([:pwd])
    |> validate_length(:pwd, min: 2, max: 100)
    |> set_pwd_hash()
  end

  def pwd_hash(pass) do
    Pbkdf2.hash_pwd_salt(pass)
  end

  defp set_pwd_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{pwd: pass}} ->
        put_change(changeset, :pwd_hash, pwd_hash(pass))

      _ ->
        changeset
    end
  end
end
