defmodule FawkesWeb.ProfileController do
  use FawkesWeb, :controller

  alias Fawkes.Membership

  def edit(conn, _params) do
    render(conn, "edit.html", changeset: Membership.profile_changeset(conn.assigns.current_user))
  end

  def update(conn, %{"profile" => params}) do
    case Membership.update_profile(conn.assigns.current_user, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: slot_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
