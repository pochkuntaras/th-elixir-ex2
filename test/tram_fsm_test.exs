defmodule TramFSMTest do
  use ExUnit.Case
  doctest TramFSM

  setup do
    {:ok, pid} = TramFSM.start_link(%Tram{number: 1})

    %{pid: pid}
  end

  test "full flow", %{pid: pid} do
    assert GenServer.call(pid, :state) == :stopped

    TramFSM.prepare(pid)

    assert GenServer.call(pid, :state) == :prepared

    TramFSM.drive(pid)

    assert GenServer.call(pid, :state) == :moving

    TramFSM.stop(pid)

    assert GenServer.call(pid, :state) == :stopped
  end
end
