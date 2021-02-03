defmodule Mix.Tasks.Rel do
  use Mix.Task

  @shortdoc "Release the production binary"

  @moduledoc """

  """

  @doc false
  def run(args) do
    # Application.put_env(:phoenix, :serve_endpoints, true, persistent: true)
    Mix.Tasks.Run.run(run_args() ++ args)
  end

  defp run_args do
    IO.inspect("initiating...")
    server_url = Application.get_env(:red_potion, :server_url)
    # if iex_running?(), do: [], else: ["--no-halt"]
    IO.inspect("releasing to...#{server_url}")
    ["--no-halt"]
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?()
  end
end
