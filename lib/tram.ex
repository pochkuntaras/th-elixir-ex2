defmodule Tram do
  @enforce_keys [:number]

  defstruct number: nil, state: :stopped, engine: :off
end
