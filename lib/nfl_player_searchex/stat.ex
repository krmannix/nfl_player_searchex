defmodule NFLPlayerSearchex.Stat do
  @moduledoc false

  @stat_type_string_to_atom_map %{
    "TCKL" => :tackles,
    "SCK"  => :sacks,
    "FF"   => :forced_fumbles,
    "INT"  => :interceptions,
    "TDS"  => :touchdowns,
    "CAR"  => :carries,
    "G"    => :games,
    "GS"   => :games_started,
    "REC"  => :receptions,
    "YDS"  => :yards,
    "RTG"  => :rating,
    "AVG"  => :average,
  }

  def stat_type_to_atom(stat_type), do: Map.get(@stat_type_string_to_atom_map, stat_type)
end
