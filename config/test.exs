import Config

config :gateway, api_test: [
  plug: {Req.Test, Gateway.Application}
]
