defmodule PageConsumer do
  use GenStage
  require Logger

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state)
  end

  @doc """
  will take at least 1 event when it's available, up to 3 at a time
  """
  def init(initial_state) do
    Logger.info("PageConsumer init")
    sub_opts = [{PageProducer, min_demand: 0, max_demand: 1}]
    {:consumer, initial_state, subscribe_to: sub_opts}
  end

  @doc """
  required callback for consumers and producer_consumers
  """
  def handle_events(events, _from, state) do
    Logger.info("PageConsumer received #{inspect(events)}")

    # Pretending that we're scraping web pages.
    Enum.each(events, fn _page ->
      Scraper.work()
    end)

    {:noreply, [], state}
  end
end
