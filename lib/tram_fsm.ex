defmodule TramFSM do
  @moduledoc """
  The finite state machine for the tram.
  """
  use GenServer

  @doc """
  Returns the current tram state.

  ## Examples

      iex> {:ok, pid} = TramFSM.start_link(%Tram{number: 1})
      iex> TramFSM.state(pid)
      :stopped
  """
  @spec state(GenServer.server()) :: atom()
  def state(pid), do: GenServer.call(pid, :state)

  @doc """
  Requests transition from stopped to prepared.
  """
  @spec prepare(GenServer.server()) :: atom()
  def prepare(pid), do: GenServer.cast(pid, {:transition, :prepare})

  @doc """
  Requests transition from prepared to moving.
  """
  @spec drive(GenServer.server()) :: atom()
  def drive(pid), do: GenServer.cast(pid, {:transition, :drive})

  @doc """
  Requests transition from moving to stopped.
  """
  @spec stop(GenServer.server()) :: atom()
  def stop(pid), do: GenServer.cast(pid, {:transition, :stop})

  @doc """
  Starts the FSM process.
  """
  @spec start_link(%Tram{}) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(%Tram{} = tram) do
    GenServer.start_link(__MODULE__, tram)
  end

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_cast({:transition, :prepare}, %Tram{state: :stopped, engine: :off} = tram) do
    {:noreply, %Tram{tram | state: :prepared}}
  end

  @impl true
  def handle_cast({:transition, :drive}, %Tram{state: :prepared, engine: :off} = tram) do
    {:noreply, %Tram{tram | state: :moving, engine: :on}}
  end

  @impl true
  def handle_cast({:transition, :stop}, %Tram{state: :moving, engine: :on} = tram) do
    {:noreply, %Tram{tram | state: :stopped, engine: :off}}
  end

  @impl true
  def handle_cast({:transition, transition}, %Tram{state: state} = tram) do
    IO.inspect({:error, {:not_allowed, transition, state}})
    {:noreply, tram}
  end

  @impl true
  def handle_call(:state, _from, %Tram{state: state} = tram) do
    {:reply, state, tram}
  end
end
