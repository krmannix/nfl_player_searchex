defmodule NFLPlayerSearchex do

  @root "http://www.nfl.com/players/search"

  @moduledoc """
  NFLPlayerSearchex allows look up of NFL Players via the official NFL player search. This module is not an official module.
  """

  @doc """
  Find by name. Assumes currently player

  ## Examples

      iex> NFLPlayerSearchex.by_name("blount")
      :[{

      }]

  """
  def by_name(name) do
    get_request(name)
    |> get_response_body
    |> Floki.find("#result tbody")
    |> get_results
  end

  defp get_request(name), do: HTTPoison.get!(@root, [], params: build_request_query_params(name))

  defp get_results(children_nodes) when length(children_nodes) == 0, do: []

  defp get_results([{_, _, players}]) do
    players
    |> Enum.map(&NFLPlayerSearchex.Player.build_player_from_row(&1))
  end

  defp build_request_query_params(name), do: %{category: "name", filter: name, playerType: "current"}

  defp get_response_body(response), do: response.body

end
