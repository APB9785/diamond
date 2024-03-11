defmodule Diamond.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [Diamond.Manager]
    opts = [strategy: :one_for_one, name: Diamond.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
