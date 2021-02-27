defmodule Scraper do
  @moduledoc """
  Documentation for `Scraper`.
  """

  @doc """
  work/0

  For simplicity, this function is just a placeholder and does not contain real
  scraping logic.

  ## Examples

      iex> Scraper.work()
      :ok
  """
  def work do
    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()
  end

  @doc """
  simulates checking to see if a site is online, 33% chance of being false
  """
  def online?(_url) do
    # Pretend we are checking if the
    # service is online or not.
    work()
    # Select result randomly.
    Enum.random([false, true, true])
  end
end
