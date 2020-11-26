defmodule DatabaseSocket.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      DatabaseSocket.Cache,
      {Task.Supervisor, name: DatabaseSocket.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: DatabaseSocket.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
