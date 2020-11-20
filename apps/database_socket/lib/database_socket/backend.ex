defmodule DatabaseSocket.Backend do
  @callback name() :: String.t()
  @callback compute(query :: String.t(), opts :: Keyword.t()) :: []
end
