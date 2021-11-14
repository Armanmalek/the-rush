defmodule Nfl.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :player, :string
      add :team, :string
      add :pos, :string
      add :att, :integer
      add :attg, :decimal
      add :yds, :integer
      add :avg, :decimal
      add :ydsg, :decimal
      add :td, :integer
      add :lng, :string
      add :first, :integer
      add :firstp, :decimal
      add :twenty, :integer
      add :forty, :integer
      add :fum, :integer

      timestamps()
    end
  end
end
