defmodule FoodpandaWeb.FoodpandaTest do
  use ExUnit.Case

  import Mox

  alias Foodpanda.MockContent

  setup :verify_on_exit!

  describe "get_list_of_recipe/0" do
    test "Return list of recipe when success response from content API" do
      result = get_content_result()
      expect(MockContent, :fetch_content, fn -> {:ok, result} end)

      assert Foodpanda.get_list_of_recipe() == [
               %{
                 chef_name: "Mark Zucchiniberg ",
                 description: "Use delicious cheese and good quality bread!",
                 entry_id: "4dT8tcb6ukGSIg2YyuGEOm",
                 image: "https://images.ddeac3316b7.jpg",
                 list_of_tags: "vegan",
                 title: "White Cheddar Grilled Cheese"
               }
             ]
    end

    test "Return empty list when error response from content API" do
      expect(MockContent, :fetch_content, fn -> {:error, :timeout} end)

      assert Foodpanda.get_list_of_recipe() == []
    end
  end

  defp get_content_result do
    %{
      "includes" => %{
        "Asset" => [
          %{
            "fields" => %{
              "file" => %{
                "contentType" => "image/jpeg",
                "url" => "//images.ddeac3316b7.jpg"
              }
            },
            "sys" => %{"id" => "3TJp6aDAcMw6yMiE82Oy0K"}
          },
          %{
            "fields" => %{
              "file" => %{
                "contentType" => "unknown",
                "url" => "_Dummy.ddeac3316b7.jpg"
              }
            },
            "sys" => %{"id" => "X3TJp6a2222DAcMwiE82Oy0K"}
          }
        ],
        "Entry" => [
          %{
            "fields" => %{"name" => "Mark Zucchiniberg "},
            "sys" => %{
              "contentType" => %{"sys" => %{"id" => "chef"}},
              "id" => "1Z8SwWMmS8E84Iogk4E6ik"
            }
          },
          %{
            "fields" => %{"name" => "vegan"},
            "sys" => %{
              "contentType" => %{"sys" => %{"id" => "tag"}},
              "id" => "3RvdyqS8408uQQkkeyi26k"
            }
          },
          %{
            "fields" => %{"name" => "vegan"},
            "sys" => %{
              "contentType" => %{"sys" => %{"id" => "something_unknown"}},
              "id" => "3RvdyqS8408uQQkkeyi26k"
            }
          }
        ]
      },
      "items" => [
        %{
          "fields" => %{
            "description" => "Use delicious cheese and good quality bread!",
            "photo" => %{"sys" => %{"id" => "3TJp6aDAcMw6yMiE82Oy0K"}},
            "chef" => %{"sys" => %{"id" => "1Z8SwWMmS8E84Iogk4E6ik"}},
            "tags" => [%{"sys" => %{"id" => "3RvdyqS8408uQQkkeyi26k"}}],
            "title" => "White Cheddar Grilled Cheese"
          },
          "sys" => %{"id" => "4dT8tcb6ukGSIg2YyuGEOm"}
        }
      ]
    }
  end
end
