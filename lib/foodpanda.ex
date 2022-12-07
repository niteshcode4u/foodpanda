defmodule Foodpanda do
  @moduledoc """
  Foodpanda keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Foodpanda.Behaviours.Content
  alias Foodpanda.Helper

  def get_list_of_recipe do
    Helper.get_list_view(Content.fetch_content())
  end
end
