defmodule PageConsumerSupervisor do
  use ConsumerSupervisor
  require Logger

  def start_link(_args) do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    Logger.info("PageConsumerSupervisor init")

    children = [
      %{
        id: PageConsumer,
        # acts like a template for starting multiple processes
        start: {PageConsumer, :start_link, []},
        restart: :transient
      }
    ]

    opts = [
      strategy: :one_for_one,
      subscribe_to: [
        # 2 consumers at most could run concurrently b/c max_demand
        {PageProducer, max_demand: 2}
      ]
    ]

    ConsumerSupervisor.init(children, opts)
  end
end
