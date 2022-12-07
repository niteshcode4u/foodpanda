import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :foodpanda, FoodpandaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2446CWItAG/2LXmbj/yODqz5C4NDJ1OPD0U6z7n9cAfhum2uAGEowxW3pLX1ihwT",
  server: false

# In test we don't send emails.
config :foodpanda, Foodpanda.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
