defmodule TarlaxServer.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, [keys: :unique, name: Tarlax.StationRegistry]}
    ]

    opts = [strategy: :one_for_one, name: Tarlax.Supervisor]

    Supervisor.init(children, opts)
  end
end
