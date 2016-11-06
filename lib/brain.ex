defmodule Brain do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Brain.Workers.Layers, [], [function: :start])
    ]

    opts = [strategy: :one_for_one, name: Brain.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
