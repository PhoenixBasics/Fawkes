defmodule Fawkes.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :slug, :string
      add :image, :string
      add :image_url, :string
      add :first, :string
      add :last, :string
      add :company, :string
      add :github, :string
      add :twitter, :string
      add :description, :text
      add :talk_id, references(:talks, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:profiles, [:slug])
    create index(:profiles, [:talk_id])
  end
end
