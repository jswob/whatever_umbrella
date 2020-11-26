defmodule DatabaseSocket.Wolfram do
  import SweetXml
  alias DatabaseSocket.Result

  @behaviour DatabaseSocket.Backend

  @base "https://api.wolframalpha.com/v2/query"

  @impl true
  def name, do: "wolfram"

  @impl true
  def compute(query_str, _opts) do
    query_str
    |> fetch_xml()
    |> xpath(
      ~x"/queryresult/pod[contains(@title, 'Result') or contains(@title, 'Definitions')]/subpod/plaintext/text()"
    )
    |> build_results()
  end

  defp build_results(nil), do: []

  defp build_results(answer) do
    [%Result{backend: __MODULE__, text: to_string(answer), score: 100}]
  end

  defp fetch_xml(query) do
    {:ok, {_, _, body}} = :httpc.request(String.to_char_list(url(query)))

    body
  end

  defp url(input) do
    "#{@base}?" <> URI.encode_query(appid: id(), input: input, format: "plaintext")
  end

  defp id, do: Application.fetch_env!(:database_socket, :wolfram)[:app_id]
end
