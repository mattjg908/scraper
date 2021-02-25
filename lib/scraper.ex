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
end
