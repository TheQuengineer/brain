defmodule Brain.Neuron do
   @moduledoc """
   The neuron is the heart of all brain activity. This module is designed to
   illustrate how these neurons can be modeled in Elixir using Agents.
   """
   defstruct [bias: nil, inputs: nil, pid: nil, output: nil, weights: nil]

   @doc """
   Adds the given inputs to the appropriately labeled neuron. This can be called
   # Parameters
   - `lable` - Can be anything that names an Elixir Agent
   - `inputs`- a list of inputs the specific neuron takes.
   - `activation` - Atom.t() Activation Function that is listed in the Activations module
   """
   @spec add_inputs(String.t(), List.t(), Atom.t()) :: Agent.t()
   def add_inputs(lable, inputs, activation) when is_list(inputs) and is_atom(activation) do
     Agent.update(lable, fn(map) ->
       neuron =
        Map.put(map, :inputs, inputs)
        |> Map.put(:bias, :rand.uniform())
        |> Map.put(:weights, 1..length(inputs)
        |> Enum.map(fn(_) -> :rand.uniform() end))
      new_output = Brain.Activations.calculate_output(activation, neuron)
      Map.put(neuron, :output, new_output)
     end)
   end

   @doc """
   Fetches referenced neuron process.
   # Parameters
   - `neuron_label` - Reference name of the created Neuron
   """
   def get(neuron_label) do
      Agent.get(neuron_label, &(&1))
   end

   @doc """
   Creates a new Neuron that is connected to what Ever the Calling Process is.
   It takes a `neuron_label` as a parameter. This Label can be used as a way to reference
   that specific Neuron for later calculations.
   # Parameter
   `label` - Any non integer value that can name an Elixir Agent.
   """
   def new(neuron_label) do
      Agent.start_link(fn() ->
        %Brain.Neuron{
          pid: self()
        }
      end, [name: neuron_label])
   end
end
