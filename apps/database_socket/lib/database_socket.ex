defmodule DatabaseSocket do
  alias Whatever.Types.Type
  alias Whatever.Types
  alias DatabaseSocket.Cache

  defmodule Result do
    defstruct text: nil, backend: nil, score: nil
  end

  def compute(query, opts \\ []) do
    timeout = opts[:timeout] || 10_000
    opts = Keyword.put(opts, :limit, opts[:limit] || 10)
    data_types = opts[:data_types] || Types.list_types()

    backends =
      Enum.map(data_types, fn
        %Type{name: "wolfram"} ->
          DatabaseSocket.Wolfram

        _ ->
          raise ArgumentError, message: "Selected backend doesn't exsist!"
      end)

    {uncached_backends, cached_results} = fetch_cached_results(backends, query, opts)

    uncached_backends
    |> Enum.map(&async_query(&1, query, opts))
    |> Task.yield_many(timeout)
    |> Enum.map(fn {task, res} ->
      res ||
        Task.shutdown(
          task,
          :brutal_kill
        )
    end)
    |> Enum.flat_map(fn
      {:ok, results} -> results
      _ -> []
    end)
    |> write_results_to_cache(query, opts)
    |> Kernel.++(cached_results)
    |> Enum.sort(&(&1.score >= &2.score))
    |> Enum.take(opts[:limit])
  end

  defp fetch_cached_results(backends, query, opts) do
    {uncached_backends, results} =
      Enum.reduce(
        backends,
        {[], []},
        fn backend, {uncached_backends, acc_results} ->
          case Cache.fetch({backend.name(), query, opts[:limit]}) do
            {:ok, results} -> {uncached_backends, [results | acc_results]}
            :error -> {[backend | uncached_backends], acc_results}
          end
        end
      )

    {uncached_backends, List.flatten(results)}
  end

  defp write_results_to_cache(results, query, opts) do
    Enum.map(results, fn %Result{backend: backend} = result ->
      :ok = Cache.put({backend.name(), query, opts[:limit]}, result)
    end)

    results
  end

  def async_query(backend, query, opts) do
    Task.Supervisor.async_nolink(
      DatabaseSocket.TaskSupervisor,
      backend,
      :compute,
      [query, opts],
      shutdown: :brutal_kill
    )
  end
end
