defmodule NFLPlayerSearchex.Status do

  @status_map %{
    "ACT" => "Active",
    "RES" => "Injured reserve",
    "NON" => "Non football related injured reserve",
    "SUS" => "Suspended",
    "PUP" => "Physically unable to perform",
    "UDF" => "Unsigned draft pick",
    "UFA" => "Unrestricted Free Agent",
    "EXE" => "Exempt",
  }

  def get_status_description_from_status(status), do: Map.get(@status_map, status)

end
