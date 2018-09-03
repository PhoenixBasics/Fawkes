defmodule Fawkes.Schedule.Speaker do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "profiles" do
    field :company, :string
    field :description, :string
    field :first, :string
    field :github, :string
    field(:image, Fawkes.Uploader.Image.Type)
    field :image_url, :string
    field :last, :string
    field :slug, :string
    field :twitter, :string
    belongs_to :talk, Fawkes.Schedule.Talk

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:slug, :image, :image_url, :first, :last, :company, :github, :twitter, :description, :talk_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:slug, :image_url, :first, :last])
    |> unique_constraint(:slug)
  end
end
