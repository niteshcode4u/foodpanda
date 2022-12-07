defmodule Foodpanda.Behaviours.Content do
  @moduledoc """
  Content API interface
  """

  @callback fetch_content :: {:ok, map()} | {:error, String.t()}

  def fetch_content, do: impl().fetch_content()

  defp impl, do: Application.get_env(:foodpanda, :content_adapter, Foodpanda.ContentClient)
end
