defmodule CacheServiceTest do
  use ExUnit.Case
  doctest CacheService

  test "greets the world" do
    assert CacheService.hello() == :world
  end
end
