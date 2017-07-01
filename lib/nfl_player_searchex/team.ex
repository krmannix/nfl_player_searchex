defmodule NFLPlayerSearchex.Team do

  @team_long_to_team_short %{
    "PHI": "Philadelphia Eagles",
  }

  def get_team_long_from_team_short(team_short) do
    Map.get(@team_long_to_team_short, team_short)
  end

end
