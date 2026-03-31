defimpl Valid, for: Tram  do
  @states [:stopped, :prepared, :moving]
  @engine_states [:on, :off]

  @doc "Returns true when a train is considered acceptable."
  @spec valid?(%Tram{}) :: boolean()
  def valid?(%Tram{number: number, state: state, engine: engine}) do
    is_integer(number) && state in @states && engine in @engine_states
  end
end
