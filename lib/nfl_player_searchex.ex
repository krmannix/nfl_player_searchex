defmodule NFLPlayerSearchex do

  @root "http://www.nfl.com"
  @search_root @root <> "/players/search"

  @moduledoc """
  NFLPlayerSearchex allows look up of NFL Players via the official NFL player search. This module is not an official NFL module.
  Replicates the functionality found at http://www.nfl.com/players/search
  """

  @doc """
  Find current players by name. Matches on partial name, i.e. "smith" will match "Smith" & "smithwell".

  ## Parameters

    - `name`: String that represents the name of the player to search for. Can be first, last, or combination. Partial matches are also accepted.

  ## Examples

      iex> NFLPlayerSearchex.by_name("blount")
      [%{average: 3.9, carries: 299, jersey_number: nil, name: "LeGarrette Blount",
         position: "RB", position_description: "Running Back", status: "ACT",
         status_description: "Active", team_long: "Philadelphia Eagles",
         team_short: "PHI", touchdowns: 18, yards: 1161}]
  """
  @spec by_name(String.t) :: [map]
  def by_name(name) do
    url_options = build_by_name_options(name)
    fetch_data_by_url(url_options)
  end

  @doc """
  Find current players by position.

  ## Parameters

    - `position`: String that represents a position. Accepeted String values:
      * `"quarterback"`
      * `"runningback"`
      * `"widereceiver"`
      * `"tightend"`
      * `"offensiveline"`
      * `"defensivelineman"`
      * `"linebacker"`
      * `"defensiveback"`
      * `"kicker"`
      * `"punter"`

  ## Examples

      iex> NFLPlayerSearchex.by_position("kicker")
      [%{jersey_number: 19, name: "Roberto Aguayo", nil: 43, position: "K",
        position_description: "Kicker", status: "ACT", status_description: "Active",
        team_long: "Tampa Bay Buccaneers", team_short: "TB"},
       %{jersey_number: 5, name: "Dan Bailey", nil: 56, position: "K",
        position_description: "Kicker", status: "ACT", status_description: "Active",
        team_long: "Dallas Cowboys", team_short: "DAL"},
       ...]
  """
  @spec by_position(String.t) :: [map]
  def by_position(position) do
    url_options = build_by_position_options(position)
    fetch_data_by_url(url_options)
  end

  defp fetch_data_by_url(url), do: fetch_data_by_url(url, [])
  defp fetch_data_by_url(url, data) do
    unless is_nil(url) do
      body = url
        |> get_request
        |> get_response_body

      next_url = get_next_page_link_from_response_body(body)
      results = get_results_from_response_body(body)

      fetch_data_by_url(next_url, data ++ results)
    else
      data
    end
  end


  ## Build initial options
  defp build_by_name_options(name) do
    [category: "name", filter: name]
  end

  defp build_by_position_options(position) do
    [category: "position", conference: "ALL", filter: position]
  end

  ## Parsing response body
  defp get_results_from_response_body(body) do
    body
    |> Floki.find("#result tbody")
    |> get_results
  end

  defp get_next_page_link_from_response_body(body) do
    body
    |> Floki.find(".linkNavigation a")
    |> Enum.find(fn el -> elem(el, 2) === ["next"] end)
    |> get_url_from_floki_anchor
  end

  defp get_url_from_floki_anchor(nil), do: nil
  defp get_url_from_floki_anchor({_, [{"href", url}], _}), do: url

  defp get_results(children_nodes) when length(children_nodes) == 0, do: []
  defp get_results([{_, _, players}]) do
    players
    |> Enum.map(&NFLPlayerSearchex.Player.build_player_from_row(&1))
  end

  # Requests

  defp get_request(options) do
    cond do
      Keyword.keyword?(options) -> HTTPoison.get!(@search_root, [], params: build_request_query_params(options))
      true -> HTTPoison.get!(@root <> options)
    end
  end

  defp build_request_query_params(options), do: Enum.into(options, %{playerType: "current"})

  defp get_response_body(response), do: response.body

end
