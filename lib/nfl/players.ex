defmodule Nfl.Players do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :att,
             :attg,
             :avg,
             :first,
             :firstp,
             :forty,
             :fum,
             :lng,
             :player,
             :pos,
             :td,
             :team,
             :twenty,
             :yds,
             :ydsg
           ]}
  schema "players" do
    field(:att, :integer)
    field(:attg, :decimal)
    field(:avg, :decimal)
    field(:first, :integer)
    field(:firstp, :decimal)
    field(:forty, :integer)
    field(:fum, :integer)
    field(:lng, :string)
    field(:player, :string)
    field(:pos, :string)
    field(:td, :integer)
    field(:team, :string)
    field(:twenty, :integer)
    field(:yds, :integer)
    field(:ydsg, :decimal)
    field(:lngdec, :decimal)

    timestamps()
  end

  @doc false
  def changeset(players, attrs) do
    players
    |> cast(attrs, [
      :player,
      :team,
      :pos,
      :att,
      :attg,
      :yds,
      :avg,
      :ydsg,
      :td,
      :lng,
      :firstp,
      :first,
      :twenty,
      :forty,
      :fum
    ])
    |> validate_required([
      :player,
      :team,
      :pos,
      :att,
      :attg,
      :yds,
      :avg,
      :ydsg,
      :td,
      :lng,
      :first,
      :firstp,
      :twenty,
      :forty,
      :fum
    ])
  end
end
