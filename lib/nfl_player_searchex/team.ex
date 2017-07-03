defmodule NFLPlayerSearchex.Team do

  @team_long_to_team_short %{
    "ARI" => "Arizona Cardinals",
    "ATL" => "Atlanta Falcons",
    "BAL" => "Baltimore Ravens",
    "BUF" => "Buffalo Bills",
    "CAR" => "Carolina Panthers",
    "CHI" => "Chicago Bears",
    "CIN" => "Cincinnati Bengals",
    "CLE" => "Cleveland Browns",
    "DAL" => "Dallas Cowboys",
    "DEN" => "Denver Broncos",
    "DET" => "Detriot Lions",
    "GRE" => "Green Bay Packers",
    "HOU" => "Houston Texans",
    "IND" => "Indianapolis Colts",
    "JAX" => "Jacksonville Jaguars",
    "KC"  => "Kansas City Chiefs",
    "LA"  => "Los Angeles Chargers",
    "MIA" => "Miami Dolphins",
    "MIN" => "Minnesota Vikings",
    "NE"  => "New England Patriots",
    "NO"  => "New Orleans Saints",
    "NYG" => "New York Giants",
    "NYJ" => "New York Jets",
    "OAK" => "Oakland Raiders",
    "PHI" => "Philadelphia Eagles",
    "PIT" => "Pitsburgh Steelers",
    "SEA" => "Seattle Seahawks",
    "SF"  => "San Francisco 49ers",
    "TB"  => "Tampa Bay Buccaneers",
    "TEN" => "Tennesse Titans",
    "WAS" => "Washington Redskins",
  }

  def get_team_long_from_team_short(team_short), do: Map.get(@team_long_to_team_short, team_short)

end
