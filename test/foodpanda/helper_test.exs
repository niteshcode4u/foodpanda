defmodule Foodpanda.HelperTest do
  use ExUnit.Case

  alias Foodpanda.Helper

  # NOTE: For time being i have defined cred into config file but we can
  # save test config to test.exs and move forward
  @contentapi_cred Application.get_env(:foodpanda, Foodpanda.ContentAPI)

  describe "prepare_full_url/0" do
    test "Return full URL to request Content API" do
      assert Helper.prepare_full_url() == "#{@contentapi_cred[:base_url]}/spaces/#{@contentapi_cred[:spaces]}/environments/#{@contentapi_cred[:environments]}/entries?access_token=#{@contentapi_cred[:access_token]}&content_type=#{@contentapi_cred[:content_type]}"
    end
  end
end
