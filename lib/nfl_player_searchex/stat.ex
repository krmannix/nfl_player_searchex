defmodule NFLPlayerSearchex.Stat do
  @stat_type_string_to_atom_map %{
    "TCKL" => :tackles,
    "SCK" => :sacks,
    "FF" => :forced_fumbles,
    "INT" => :interceptions,
    "TDS" => :touchdowns,
    "CAR" => :carries,
    "G" => :games,
    "GS" => :games_started,
    "REC" => :receptions,
    "YDS" => :yards,
    "RTG" => :rating,
    "AVG" => :average,
  }

  @integer_stat [
    "TCKL",
    "FF",
    "INT",
    "TDS",
    "CAR",
    "G",
    "GS",
    "REC",
    "YDS",
  ]

  @float_stat [
    "RTG",
    "AVG",
    "SCK",
  ]

  def integer_stat_type?(stat_type), do: Enum.member?(@integer_stat, stat_type)
  def float_stat_type?(stat_type), do: Enum.member?(@float_stat, stat_type)
  def stat_type_to_atom(stat_type), do: Map.get(@stat_type_string_to_atom_map, stat_type)
end
