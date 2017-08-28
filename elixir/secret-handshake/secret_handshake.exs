defmodule SecretHandshake do
  use Bitwise
  @commands_map %{ 1 => "wink", 2 => "double blink", 4 => "close your eyes", 8 => "jump" }

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(num) do
    @commands_map
    |> Map.keys
    |> Enum.reduce([], &add_command(&2, get_command(num &&& &1)))
    |> reorder(num &&& 16)
  end

  defp get_command(num), do: Map.get @commands_map, num

  defp add_command(list, nil), do: list
  defp add_command(list, cmd), do: list ++ [cmd]

  defp reorder(commands, 16), do: Enum.reverse commands
  defp reorder(commands, _), do: commands
end
