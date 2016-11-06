defmodule Brain.Workers.Layers do
  @moduledoc """
  This GenServer is responsible for managing all the Layers within the
  Neural Network. Each Layer will have a list of Neurons that it manages. All
  the functions are available for the user to be able to manipulate the layer
  as needed.
  """

  use GenServer

  #############
  #   API     #
  #############


  @doc """
  Starts the Layers GenServer
  """
  def start do
    GenServer.start_link(__MODULE__, Keyword.new(), [name: __MODULE__])
  end

  @doc """
  Add a specific neuron to a specific layer.
  # Parameters
  - `neuron` : Map.t()
  - `layer_name` : Atom.t()
  """
  def add_neuron(neuron, layer_name) when is_map(neuron) and is_atom(layer_name) do
    GenServer.cast(__MODULE__, {:add_neuron, neuron, layer_name})
  end

  @doc """
  Create a new Layer in the Network by the name given.
  # Parameter
  - `layer_name` : Atom.t()
  """
  def new(layer_name) when is_atom(layer_name) do
    GenServer.cast(__MODULE__, {:add_layer, layer_name})
  end

  @doc """
  Shows All the layers in the networks.
  """
  def show do
    GenServer.call(__MODULE__, :show)
  end

  ##################
  # IMPLEMENTATION #
  ##################

  def init(list) do
    {:ok,  list}
  end

  def handle_cast({:add_layer, layer_name}, state) do
    new_state = Keyword.put_new(state, layer_name, [])
    {:noreply,  new_state}
  end

  def handle_cast({:add_neuron, neuron, layer}, state) do
     new_list = Keyword.get_and_update!(state, layer, fn(current) ->
          {current, [neuron | current]}
     end)
     {_, new_state} = new_list

     {:noreply, new_state}
  end

  def handle_call(:show, _from, state) do
    {:reply, state, state}
  end
end
