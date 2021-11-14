defmodule Nfl.Repo.Migrations.AlterPlayers do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :lngdec, :decimal
    end
  end
end
