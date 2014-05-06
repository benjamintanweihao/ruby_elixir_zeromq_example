defmodule Sequence.Mixfile do
  use Mix.Project

  def project do
    [app: :sequence,
     version: "0.0.1",
     elixir: "~> 0.13.2-dev",
     deps: deps]
  end

  def application do
    [ applications: [:exzmq],
      mod: {Sequence, []} ]
  end

  defp deps do
    [
      {:exzmq, git: "https://github.com/benjamintanweihao/exzmq"},
      {:json, github: "cblage/elixir-json"}
    ]
  end
end
