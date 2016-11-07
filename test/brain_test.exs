defmodule BrainTest do
  use ExUnit.Case
  doctest Brain

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Local Errors return correct value" do
    assert 5 == Brain.Error.calculate_local(5, 10)
  end

  test "Global Error mse calculation should be correct" do
    errors = [0.33, 1, 3, 4.3]

    assert 7.149725 == Brain.Error.calculate_global(:mse, errors)
  end

  test "Global Errors ess calculation should be correct" do
    errors = [0.33, 1, 3, 4.3]

    assert 14.29945 == Brain.Error.calculate_global(:ess, errors)
  end
end
