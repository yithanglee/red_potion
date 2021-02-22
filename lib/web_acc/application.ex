defmodule WebAcc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      WebAcc.Repo,
      # Start the endpoint when the application starts
      WebAccWeb.Endpoint
      # Starts a worker by calling: WebAcc.Worker.start_link(arg)
      # {WebAcc.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebAcc.Supervisor]
    a = Supervisor.start_link(children, opts)
    path = File.cwd!() <> "/media"

    if File.exists?(path) == false do
      File.mkdir(File.cwd!() <> "/media")
    end

    File.rm_rf("./priv/static/images/uploads")
    File.ln_s("#{File.cwd!()}/media/", "./priv/static/images/uploads")
    a
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WebAccWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
