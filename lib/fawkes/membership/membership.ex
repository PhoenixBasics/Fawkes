defmodule Fawkes.Membership do
  @moduledoc """
  Context responsible for managing profile information
  """

  import Ecto.Query
  alias Fawkes.Membership.User
  alias Fawkes.Membership.Profile
  alias Fawkes.Repo

  def get_user(id) do
    User
    |> preload([:profile])
    |> where([user], user.id == ^id)
    |> Repo.one()
  end

  def profile_changeset(%User{profile: profile}) when not is_nil(profile) do
    Profile.changeset(profile, %{})
  end

  def profile_changeset(user) do
    %Profile{}
    |> Profile.init_changeset(%{user_id: user.id, slug: "user_#{user.id}"})
    |> Repo.insert!()
    |> Profile.changeset(%{})
  end

  def update_profile(%User{profile: profile}, params) when not is_nil(profile) do
    profile
    |> Profile.changeset(params)
    |> Repo.update()
  end
end
