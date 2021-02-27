defmodule PageProducer do
  use GenStage
  require Logger

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @doc """
  valid first elements for the retun value  are producer, consumer, or
  producer_consumer- determines type of process.
  """
  def init(initial_state) do
    Logger.info("PageProducer init")
    {:producer, initial_state}
  end

  @doc """
  handle_demand/2 callback is required for producer and producer_consumer
  processes
  This func is invoked when a consumer asks for events, demand = number of
  events requestd by consumers and state = internal state of the producer.
  """
  def handle_demand(demand, state) do
    Logger.info("Received demand for #{demand} pages")
    events = []
    {:noreply, events, state}
  end

  def scrape_pages(pages) when is_list(pages) do
    GenStage.cast(__MODULE__, {:pages, pages})
  end

  @doc """
  very similar to GenServer's handle_cast/2 callback but for GenStage there's an
  events element (pages)
  """
  def handle_cast({:pages, pages}, state) do
    Logger.info("Handling cast")
    {:noreply, pages, state}
  end
end
