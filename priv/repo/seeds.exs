defmodule Nfl.Seeder do
  alias Nfl.Repo
  alias Nfl.Players
  alias String

  def handle_yards(yards) when is_integer(yards), do: yards

  def handle_yards(yards) do
    {yds, _} = yards
    |> String.replace(",", "")
    |> Integer.parse()
    yds
  end

  def handle_lng(long) when is_integer(long), do: Integer.to_string(long)

  def handle_lng(long), do: long

  def replace_keys(%{
  "1st"=> first,
  "1st%"=> firstp,
  "20+"=> twenty,
  "40+"=> forty,
  "Att" => att,
  "Att/G" => attg,
  "Avg" => avg,
  "FUM" => fum,
  "Lng"=> lng,
  "Player"=> player,
  "Pos"=> pos,
  "TD"=> td,
  "Team"=> team,
  "Yds"=> yds,
  "Yds/G"=> ydsg}) do
    {lngdec, ""} = lng |> handle_lng() |> String.replace("T", ".1") |> Float.parse()

    %{
      player: player,
      team: team,
      pos: pos,
      att: att,
      attg: attg,
      yds: handle_yards(yds),
      avg: avg,
      ydsg: ydsg,
      td: td,
      lng: handle_lng(lng),
      first: first,
      firstp: firstp,
      twenty: twenty,
      forty: forty,
      fum: fum,
      lngdec: lngdec,
      inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    }
  end

  def transform_json(json) do
    json
    |> Enum.map(&replace_keys/1)
  end

  def seed_db() do
    json_file = "#{__DIR__}/rushing.json"
    with {:ok, body} <- File.read(json_file),
      {:ok, json} <- Jason.decode(body) do
       payload = json
       |> transform_json
       Repo.insert_all(Players, payload)
    else
      err -> IO.inspect(err)
    end
  end

end

Nfl.Seeder.seed_db()
