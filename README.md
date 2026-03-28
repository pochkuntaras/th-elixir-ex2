# The FSM for a tram

## Example
```elixir
iex|💧|54 ▶  {:ok, pid} = TramFSM.start_link(%Tram{number: 1})
{:ok, #PID<0.440.0>}
iex|💧|55 ▶  TramFSM.state(pid)
:stopped
iex|💧|56 ▶  TramFSM.prepare(pid)
:ok
iex|💧|57 ▶  TramFSM.state(pid)
:prepared
iex|💧|58 ▶  TramFSM.drive(pid)
:ok
iex|💧|59 ▶  TramFSM.state(pid)
:moving
iex|💧|60 ▶  TramFSM.stop(pid)
:ok
iex|💧|61 ▶  TramFSM.state(pid)
:stopped
```
