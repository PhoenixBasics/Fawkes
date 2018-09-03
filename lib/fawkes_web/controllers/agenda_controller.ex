defmodule FawkesWeb.AgendaController do
  use FawkesWeb, :controller

  alias Fawkes.Agenda

  def index(conn, _params) do
    talks = Agenda.list_talk_for_user(conn.assigns.current_user.id)
    render(conn, "index.html", talks: talks)
  end

  alias Fawkes.Membership

  def show(conn, %{"user_slug" => user_slug}) do
    profile = Membership.fetch_user_profile(user_slug)
    talks = Agenda.list_talk_for_user(profile.user_id)
    render(conn, "index.html", talks: talks)
  end
end
