defmodule Queens.MixProject do
  use Mix.Project

  def project do
    [
      app: :Queens,
      version: "0.1.0",
      elixir: "~> 1.7",
      escript: escript_config(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp escript_config do
    cond do
      System.get_env("QUEENS_NAME") == "QueensParallel" ->
        [ main_module: QueensParallel ]
      System.get_env("QUEENS_NAME") == "QueensHalf" ->
        [ main_module: QueensHalf ]
      true ->
        [ main_module: Queens ]
    end
  end
end
