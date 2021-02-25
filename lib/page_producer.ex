defmodule PageProducer do
  use GenStage
  require Logger

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @doc """
  valid first elements for the retun value  are producer, consumer, or
  producer_consumer
  """
  def init(initial_state) do
    Logger.info("PageProducer init")
    {:producer, initial_state}
  end

  @doc """
  handle_demand/2 callback is required for producer and producer_consumer
  processes
  This func is invoked when a consumer asks for events, demand = number of
  events requestd by consumers and state = internal state of the producer
  """
  def handle_demand(demand, state) do
    Logger.info("Received demand for #{demand} pages")
    events = []
    {:noreply, events, state}
  end
end
