ExUnit.start()

Application.ensure_all_started(:mox)

Mox.defmock(Foodpanda.MockContent,
  for: Foodpanda.Behaviours.Content
)

Application.put_env(:foodpanda, :content_adapter, Foodpanda.MockContent)
