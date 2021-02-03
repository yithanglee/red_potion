defmodule RedPotionTest do
  use ExUnit.Case
  doctest RedPotion

  test "greets the world" do
    assert RedPotion.hello() == :world
  end
end
