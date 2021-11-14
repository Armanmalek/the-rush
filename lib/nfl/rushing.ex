defmodule NFl.Rushing do
  import Ecto.Query
  alias Nfl.Repo
  alias Nfl.Players

  @map %{
    "lng" => :lng,
    "yds" => :yds,
    "td" => :td,
    "asc" => :asc,
    "desc" => :desc
  }

  def get_rushing_list do
    Repo.all(Players)
  end

  def string_to_atom(string), do: @map[string]

  def create_order_by([order, "lng"]) do
    Keyword.new([{string_to_atom(order), :lngdec}])
  end

  def create_order_by([order, column]) do
    Keyword.new([{string_to_atom(order), string_to_atom(column)}])
  end

  def create_search_query(search), do: "%" <> search <> "%"

  def sort_players(%{"sort" => sort, "search" => search}) do
    order = sort |> create_order_by()
    search_query = search |> create_search_query()

    from(p in Players, order_by: ^order, where: ilike(p.player, ^search_query))
    |> Repo.all()
  end

  def sort_players(%{"sort" => sort}) do
    order = sort |> create_order_by()

    from(p in Players, order_by: ^order)
    |> Repo.all()
  end

  def sort_players(%{"search" => search}) do
    search_query = search |> create_search_query()

    from(p in Players, where: ilike(p.player, ^search_query))
    |> Repo.all()
  end

  def sort_players(_) do
    get_rushing_list()
  end
end
