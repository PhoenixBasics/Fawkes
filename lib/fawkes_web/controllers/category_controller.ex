defmodule FawkesWeb.CategoryController do
  use FawkesWeb, :controller
  alias Fawkes.Schedule

  def index(conn, _params) do
    categories = Schedule.all_category()
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: Schedule.category_changeset())
  end
end
