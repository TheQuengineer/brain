defmodule Brain.Error do
  @moduledoc """
  This module is responsible for calculating the error for the Neural network.
  There are two types of errors.

  1. The Local Error
  2. The Global Error

  The local error is responsible for measuring whether or not one specific
  neuron has reached the level of the target. The Global Error is the second way
  that this can be caculated. The difference is that the global error calculates
  the error rate of the entire network. Functions that will allow you to work with
  errors within the network can be found here.
  """

  @doc """
  Calculate the Linear Error for a single neuron.
  # Parameters
  - actual - Float.() | Number.t() the actual output of the Neuron
  - target - Number.t() the target you'd like the neuron to acheive
  """
  def calculate_local(actual, target), do: target - actual

  @doc """
  The Global Error Function used for calculating the error of the entire
  Neural network.
 `MSE` aka Mean Square Error which is the most commonly used in Neural Networks
  # Parameters
  - `Error Type` - Atom.t() will take :mse or :ess
  - `errors_in_network` - List.t() List of all the local errors in the network.

  This Error is known for returning a percentage.
  """
  def calculate_global(:mse, errors_in_network) when is_list(errors_in_network) do
    actual =
      Enum.map(errors_in_network, &:math.pow(&1, 2))
      |> Enum.sum
    error = actual / length(errors_in_network)
  end

  @doc """
   The Global Error Function used for calculating the error of the entire
   Neural Network. This is usually used in the LMA Neural Network Architecture.
   `ESS` is the shortname for Sum of Squares Error.
  """
  def calculate_global(:ess, errors_in_network) when is_list(errors_in_network) do
    errors =
      Enum.map(errors_in_network, &:math.pow(&1, 2))
      |> Enum.sum
    total_errors = errors / 2
  end
end
