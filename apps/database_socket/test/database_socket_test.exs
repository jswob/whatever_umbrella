defmodule DatabaseSocketTest do
  use ExUnit.Case
  doctest DatabaseSocket

  test "greets the world" do
    assert DatabaseSocket.hello() == :world
  end
end
