defmodule FoodpandaWeb.Router do
  use FoodpandaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FoodpandaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodpandaWeb do
    pipe_through :browser

    live "/", ListViewLive
    live "/show/:entry_id", DetailsViewLive
  end
end
