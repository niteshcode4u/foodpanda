defmodule Foodpanda.ContentClient do
  @moduledoc """
  This module is responsible to fetch recipes from contentful API and parse it.
  """
  @behaviour Foodpanda.Behaviours.Content

  alias Foodpanda.Helper

  def fetch_content do
    Helper.prepare_full_url()
    |> HTTPoison.get()
    |> case do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        Jason.decode(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
