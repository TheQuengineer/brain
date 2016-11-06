defmodule Brain.Activations do
  @moduledoc """
  In order for Neurons to fire at the appropriate time, the neurons need
  something called an actication function. Activation functions are designed
  to trigger a neuron when an appropriate threshold is reached. This threshold is
  usually defined by a given target. This module makes avaialble different types
  of actications that can be used on any neuron.
  """

  #############
  #    API    #
  #############

  def calculate_output(:linear, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> linear
  end

  def calculate_output(:saturating_linear, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> saturating_linear
  end

  def calculate_output(:symmetric_saturating_linear, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> symmetric_saturating_linear
  end

  def calculate_output(:hard_limit, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> hard_limit
  end

  def calculate_output(:positive_linear, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> positive_linear
  end

  def calculate_output(:sigmoid, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> sigmoid
  end

  def calculate_output(:symmetrical_hard_limit, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> symmetrical_hard_limit
  end

  def calculate_output(:hyperbolic_tangent, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> :math.tanh
  end

  ###################
  #  IMPLEMENTATION #
  ###################

  defp summation([], []), do: 0

  defp summation(inputs, weights) do
    ExMatrix.multiply([inputs], [weights])
    |> List.flatten
    |> Enum.sum
  end

  defp add_bias(calc, neuron), do: calc + neuron.bias

  defp sigmoid(calculation), do: 1 / (1 + :math.exp(-calculation))

  defp positive_linear(calc) when calc < 0 , do: 0

  defp positive_linear(calc) when 0 <= calc, do: calc

  defp hard_limit(calc) when calc < 0, do: 0

  defp hard_limit(calc) when calc >= 0, do: 1

  defp symmetrical_hard_limit(calc) when calc < 0, do: -1

  defp symmetrical_hard_limit(calc) when calc >= 0, do: 1

  defp symmetric_saturating_linear(calc) when calc < -1, do: -1

  defp symmetric_saturating_linear(calc) when -1 <= calc and calc <= 1, do: calc

  defp symmetric_saturating_linear(calc) when calc > 1, do: 1

  defp saturating_linear(calc) when calc < 0, do: 0

  defp saturating_linear(calc) when calc <= 0 and calc <= 1, do: calc

  defp saturating_linear(calc) when calc > 1, do: 1

  defp linear(calc) when is_float(calc), do: calc
end
