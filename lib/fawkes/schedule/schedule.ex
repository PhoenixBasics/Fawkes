defmodule Fawkes.Schedule do
  alias Fawkes.Repo
  alias Fawkes.Schedule.Category

  def all_category do
    Repo.all(Category)
  end

  def category_changeset(changeset \\ %Category{}) do
    Category.changeset(changeset, %{})
  end
end
