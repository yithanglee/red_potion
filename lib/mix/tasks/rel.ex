defmodule Mix.Tasks.Rel do
  use Mix.Task

  @start_apps [
    :porcelain
  ]

  @shortdoc "Release the production binary"

  @moduledoc """

  """

  @doc false
  def run(args) do
    # Application.put_env(:phoenix, :serve_endpoints, true, persistent: true)
    # Mix.Tasks.Run.run(run_args() ++ args)
    run_args()
  end

  defp run_args do
    Enum.each(@start_apps, &Application.ensure_all_started/1)
    IO.puts("initiating..2.")
    server_url = Application.get_env(:red_potion, :server_url)
    project = Application.get_env(:red_potion, :project)
    # if iex_running?(), do: [], else: ["--no-halt"]
    IO.puts("releasing to...#{server_url}")

    prod_secret = File.cwd!() <> "/config/prod.secret.exs"

    res = File.exists?(prod_secret)
    IO.puts("prod secret there? #{res}")

    if project != nil do
      rel_task_ex = File.cwd!() <> "/lib/#{project.alias_name}" <> "/release_task.ex"
      res = File.exists?(prod_secret)
      IO.puts("rel_task_ex there? #{res}")
      app_dir = Application.app_dir(:red_potion)

      file =
        Mix.Generator.create_file(
          rel_task_ex,
          EEx.eval_file("#{app_dir}/priv/templates/release_task.ex", project: project)
        )
    end

    # result = Porcelain.shell("mix distillery.init ")
    # IO.inspect(result)

    # rel_folder = File.cwd!() <> "/rel/commands"
    # res = File.exists?(rel_folder)

    # if res == false do
    #   File.mkdir(rel_folder)
    # end

    # migrate_sh = File.cwd!() <> "/rel/commands/migrate.sh"
    # res = File.exists?(migrate_sh)

    # if res == false do
    #   File.touch(migrate_sh)
    # end

    # if res do
    #   IO.puts("releasing for production...")
    #   result = Porcelain.shell("MIX_ENV=prod mix distillery.release ")
    # else
    #   IO.puts("please check your production release, esp prod secret")
    # end

    []
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?()
  end

  defp write_migrate_sh() do
  end
end
