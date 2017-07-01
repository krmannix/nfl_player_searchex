defmodule NFLPlayerSearchex.PlayerRow do

  def build_player_from_row({_, _, player_cells}) do
    build_player_from_cells(player_cells)
  end

  defp build_player_from_cells(cells) do
    get_player_function_map()
    |> Enum.map(fn {k, {index, func}} -> {k, func.(Enum.fetch!(cells, index))} end)
    |> Enum.into(%{})
  end

  defp get_player_function_map do
    %{
      position: {0, &get_pos_from_cell(&1)},
      jersey_number: {1, &get_integer_from_cell(&1)},
      name: {2, &get_name_from_cell(&1)},
      status: {3, &get_status_from_cell(&1)},
      # status_description: {3, &get_status_description_from_cell(&1)},
      attempts: {5, &get_integer_from_cell(&1)},
      yards: {7, &get_float_from_cell(&1)},
      average_yards_per_attempt: {9, &get_float_from_cell(&1)},
      touchdowns: {11, &get_integer_from_cell(&1)},
      team_short: {12, &get_team_short_from_cell(&1)},
      # team_long: {12, &get_team_long_from_cell(&1)},
    }
  end

  ## Cell Getters

  def get_integer_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_integer_from_cell({_, _, val}), do: String.to_integer(first_el(val))

  def get_float_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_float_from_cell({_, _, val}), do: String.to_float(first_el(val))

  def get_pos_from_cell({_, _, val}), do: first_el(val)

  def get_name_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_name_from_cell({_, _, [{_, _, val}]}), do: first_el(val)

  def get_status_from_cell({_, _, val}), do: first_el(val)

  def get_team_short_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_team_short_from_cell({_, _, [{_, _, val}]}), do: first_el(val)

  def first_el(list) when length(list) == 0, do: nil
  def first_el(list), do: List.first(list)

end
