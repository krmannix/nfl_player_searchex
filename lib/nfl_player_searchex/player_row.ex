defmodule NFLPlayerSearchex.PlayerRow do

  def build_player_from_row({_, _, player_cells}) do
    build_player_from_cells(player_cells)
  end

  # clean this up. look at filter_map
  defp build_player_from_cells(cells) do
    Enum.map_every(4..11, 2, &build_player_stat_from_cell(cells, &1))
    |> Enum.filter(&is_tuple(&1))
    |> Enum.into(build_basic_player_map(cells))
  end

  defp build_basic_player_map(cells) do
    %{
      position: get_pos_from_cell(Enum.fetch!(cells, 0)),
      jersey_number: get_integer_from_cell(Enum.fetch!(cells, 1)),
      name: get_name_from_cell(Enum.fetch!(cells, 2)),
      status: get_status_from_cell(Enum.fetch!(cells, 3)),
      status_description: get_status_description_from_cell(Enum.fetch!(cells, 3)),
      team_short: get_team_short_from_cell(Enum.fetch!(cells, 12)),
      team_long: get_team_long_from_cell(Enum.fetch!(cells, 12)),
    }
  end

  defp build_player_stat_from_cell(cells, index) do
    player_stat_type = clean_alpha_string(first_el(elem(Enum.fetch!(cells, index), 2)))
    player_stat_number = Enum.fetch!(cells, index + 1)

    case player_stat_type do
      # ints
      "TCKL" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "SCK" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "FF" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "INT" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "TDS" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "CAR" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "G" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "GS" -> {player_stat_type, get_integer_from_cell(player_stat_number)}
      "REC" -> {player_stat_type, get_integer_from_cell(player_stat_number)}

      # floats
      "YDS" -> {player_stat_type, get_float_from_cell(player_stat_number)}
      "RTG" -> {player_stat_type, get_float_from_cell(player_stat_number)}
      "AVG" -> {player_stat_type, get_float_from_cell(player_stat_number)}
      nil -> nil
    end
  end

  defp clean_alpha_string(str) when is_nil(str), do: nil
  defp clean_alpha_string(str), do: String.replace(str, ~r/[^a-zA-Z]/, "")

  defp clean_num_string(str) when is_nil(str), do: nil
  defp clean_num_string(str), do: String.replace(str, ~r/[^0-9]/, "")

  ## Cell Getters
  def get_integer_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_integer_from_cell({_, _, [val]}) do
    case val do
      "--" -> 0
      _ -> String.to_integer(clean_num_string(val))
    end
  end

  def get_float_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_float_from_cell({_, _, [val]}) do
    case val do
      "--" -> 0
      _ -> String.to_integer(clean_num_string(val))
    end
  end

  def get_pos_from_cell({_, _, val}), do: first_el(val)

  def get_name_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_name_from_cell({_, _, [{_, _, val}]}), do: first_el(val)

  def get_status_from_cell({_, _, val}), do: first_el(val)
  def get_status_description_from_cell({_, _, val}), do: NFLPlayerSearchex.Status.get_status_description_from_status(first_el(val))

  def get_team_short_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_team_short_from_cell({_, _, [{_, _, val}]}), do: first_el(val)

  def get_team_long_from_cell({_, _, val}) when length(val) == 0, do: nil
  def get_team_long_from_cell(val), do: NFLPlayerSearchex.Team.get_team_long_from_team_short(get_team_short_from_cell(val))

  def first_el(list) when length(list) == 0, do: nil
  def first_el(list), do: List.first(list)

end
