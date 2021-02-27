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
      {Registry, keys: :unique, name: ProducerConsumerRegistry},
      PageProducer,
      # ProducerConsumer must be started before consumers so
      # OnlinePageProducerConsumer is listed befor PageConsumerSupervisor
      producer_consumer_spec(id: 1),
      producer_consumer_spec(id: 2),
      PageConsumerSupervisor
    ]

    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  b/c we're going to add more processes of the same type, line 21 uses Registry
  to keep track of them and we add this function for easy id and name assignment
  """
  def producer_consumer_spec(id: id) do
    id = "online_page_producer_consumer_#{id}"
    Supervisor.child_spec({OnlinePageProducerConsumer, id}, id: id)
  end
end
