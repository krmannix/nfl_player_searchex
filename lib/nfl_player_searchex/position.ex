defmodule NFLPlayerSearchex.Position do
  @position_type_string_to_description %{

    # Offense
    "C"   => "Center",
    "FB"  => "Fullback",
    "G"   => "Guard",
    "OG"  => "Offensive Guard",
    "OT"  => "Offensive Tackle",
    "QB"  => "Quarterback",
    "RB"  => "Running Back",
    "T"   => "Tackle",
    "TE"  => "Tight End",
    "WR"  => "Wide Receiver",

    # Defense
    "OLB" => "Outside Linebacker",
    "MLB" => "Middle Linebacker",
    "ILB" => "Inside Linebacker",
    "CB"  => "Cornerback",
    "DB"  => "Defensive Back",
    "DE"  => "Defensive End",
    "DL"  => "Defensive Lineman",
    "DT"  => "Defensive Tackle",
    "FS"  => "Free Safety",
    "LB"  => "Linebacker",
    "NT"  => "Nose Tackle",
    "SAF" => "Safety",
    "SS"  => "Strong Safety",

    # Special Teams
    "K"   => "Kicker",
    "P"   => "Punter",
  }

  def get_position_description_from_position(position_type), do: Map.get(@position_type_string_to_description, position_type)
end
