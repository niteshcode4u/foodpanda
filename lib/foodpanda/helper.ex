defmodule Foodpanda.Helper do
  @moduledoc """
  A helper module to provide common services
  """

  @contentapi_cred Application.compile_env!(:foodpanda, Foodpanda.ContentAPI)

  @spec prepare_full_url :: <<_::64, _::_*8>>
  def prepare_full_url do
    [
      base_url: base_url,
      spaces: spaces,
      environments: environments,
      access_token: access_token,
      content_type: content_type
    ] = @contentapi_cred

    "#{base_url}/spaces/#{spaces}/environments/#{environments}/entries?access_token=#{access_token}&content_type=#{content_type}"
  end

  @spec get_list_view({:error, any} | {:ok, map}) :: list
  def get_list_view({:error, _reason}) do
    []
  end

  def get_list_view(
        {:ok,
         %{"items" => items, "includes" => %{"Asset" => assets, "Entry" => entries}} = _recipies}
      ) do
    images = fetch_images(assets)
    {tags_data, chefs} = fetch_tags_and_chefs_entry(entries)

    Enum.map(items, fn %{"fields" => fields} = item ->
      entry_id = item["sys"]["id"]
      image_id = fields["photo"]["sys"]["id"]
      chef_id = fields["chef"]["sys"]["id"]

      tags =
        case fields["tags"] do
          nil -> "Not Available"
          tags -> get_tags(tags, tags_data)
        end

      %{
        entry_id: entry_id,
        title: fields["title"],
        image: images[image_id],
        list_of_tags: tags,
        description: fields["description"],
        chef_name: chefs[chef_id] || "Not Available"
      }
    end)
  end

  defp fetch_images(assets) do
    Enum.reduce(assets, %{}, fn asset, acc ->
      case asset["fields"]["file"]["contentType"] == "image/jpeg" do
        true ->
          Map.put(acc, asset["sys"]["id"], Path.join("https:", asset["fields"]["file"]["url"]))

        false ->
          acc
      end
    end)
  end

  defp fetch_tags_and_chefs_entry(entries) do
    Enum.reduce(entries, {%{}, %{}}, fn entry, {tags, chefs} ->
      case entry["sys"]["contentType"]["sys"]["id"] do
        "tag" -> {Map.put(tags, entry["sys"]["id"], entry["fields"]["name"]), chefs}
        "chef" -> {tags, Map.put(chefs, entry["sys"]["id"], entry["fields"]["name"])}
        _unknown -> {tags, chefs}
      end
    end)
  end

  defp get_tags(tags, tags_data) do
    Enum.map_join(tags, ",", fn tag -> tags_data[tag["sys"]["id"]] end)
  end
end
