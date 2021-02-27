defmodule Scraper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc """
  could also use the equivalent syntx of

  children = [
    {PageProducer, []},
    {PageConsumer, []}
  ]

  We use the syntax below when we don't need to pass any options to the process
  """
  @impl true
  def start(_type, _args) do
    children = [
      PageProducer,
      PageConsumerSupervisor
    ]

    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
