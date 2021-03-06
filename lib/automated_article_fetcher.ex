defmodule Newsfun.ArticleFetcher do
  use GenServer
  alias Newsfun.ArticleFetcherService, as: AFS

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    AFS.push_new_articles()
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, how_many_minutes(5))
  end

  defp how_many_minutes(minutes) do
    minutes * 1000 * 60
  end

  defp fetch_new_articles do
  end

  # Check DB if they exist, return list of original articles

end
