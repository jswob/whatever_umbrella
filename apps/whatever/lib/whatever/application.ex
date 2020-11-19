defmodule Whatever.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Whatever.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Whatever.PubSub}
      # Start a worker by calling: Whatever.Worker.start_link(arg)
      # {Whatever.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Whatever.Supervisor)
  end
end
