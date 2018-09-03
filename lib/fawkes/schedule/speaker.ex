defmodule Fawkes.Schedule.Speaker do
  use Ecto.Schema
  import Ecto.Changeset


  schema "profiles" do
    field :company, :string
    field :description, :string
    field :first, :string
    field :github, :string
    field :image, :string
    field :image_url, :string
    field :last, :string
    field :slug, :string
    field :twitter, :string
    field :talk_id, :id

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:slug, :image, :image_url, :first, :last, :company, :github, :twitter, :description])
    |> validate_required([:slug, :image, :image_url, :first, :last, :company, :github, :twitter, :description])
    |> unique_constraint(:slug)
  end
end
