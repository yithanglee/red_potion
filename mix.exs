defmodule RedPotion.MixProject do
  use Mix.Project

  def project do
    [
      app: :red_potion,
      version: "0.4.3",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :sshex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sshex, "2.2.1"},
      {:porcelain, "~> 2.0"}
    ]
  end
end
