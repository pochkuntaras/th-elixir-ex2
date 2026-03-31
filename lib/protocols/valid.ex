defprotocol Valid do
  @doc "Returns true when a data is considered acceptable."
  def valid?(data)
end
