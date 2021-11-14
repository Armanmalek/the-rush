defmodule NflWeb.RushingChannel do
  use Phoenix.Channel
  alias NFl.Rushing
  @topic "rushing"

  def join(@topic, _params, socket) do
    Process.send(self(), :init, [])

    {:ok, socket}
  end

  def handle_info(:init, socket) do
    push(socket, "players", %{players: Rushing.get_rushing_list()})
    {:noreply, socket}
  end

  def handle_in("sort", params, socket) do
    push(socket, "players", %{players: Rushing.sort_players(params)})
    {:reply, {:ok, ""}, socket}
  end
end
