defmodule Nfl.Repo do
  @moduledoc false
  require Logger

  use Ecto.Repo,
    otp_app: :nfl,
    adapter: Ecto.Adapters.Postgres

  def map_transaction_error(
        {:error, failed_operation, %Ecto.Changeset{} = failed_value, _changes_so_far}
      ) do
    Logger.error("failed to #{failed_operation}")

    %{
      error:
        failed_value.errors
        |> reduce_changeset_errors()
    }
  end

  def map_transaction_error({:error, failed_operation, failed_value, _changes_so_far}) do
    Logger.error("failed to #{failed_operation}")
    %{error: "#{failed_value}"}
  end

  def map_transaction_error({:error, err}) do
    Logger.error(err)
    %{error: "transaction failed"}
  end

  def map_transaction_error({:ok, _} = result), do: result

  def map_transaction_error(result) do
    Logger.error(inspect(result))
    %{error: "transaction failed"}
  end

  def reduce_changeset_errors(errors) do
    errors
    |> Enum.reduce(Map.new(), fn {k, {v, _}}, acc -> Map.put(acc, k, v) end)
  end
end
