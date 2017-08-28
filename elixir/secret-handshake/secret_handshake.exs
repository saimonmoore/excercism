defmodule SecretHandshake do
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
  def commands(code) do
    <<_b8::size(1), _b7::size(1), _b6::size(1), b5::size(1), b4::size(1), b3::size(1), b2::size(1), b1::size(1)>> = <<code>>
    codes = [
      wink: b1 == 1,
      double_blink: b2 == 1,
      close_eyes: b3 == 1,
      jump: b4 == 1,
      reverse: b5 == 1
    ]
    
    to_actions(codes, [])
  end


  defp to_actions([], commands) do
    commands
  end

  defp to_actions([h | t], commands) when h == {:wink, true} do
    to_actions(t, commands ++ ["wink"])
  end

  defp to_actions([h | t], commands) when h == {:double_blink, true} do
    to_actions(t, commands ++ ["double blink"])
  end

  defp to_actions([h | t], commands) when h == {:close_eyes, true} do
    to_actions(t, commands ++ ["close your eyes"])
  end

  defp to_actions([h | t], commands) when h == {:jump, true} do
    to_actions(t, commands ++ ["jump"])
  end

  defp to_actions([h | t], commands) when h == {:reverse, true} do
    to_actions(t, Enum.reverse(commands))
  end

  defp to_actions([h | t], commands) do
    to_actions(t, commands)
  end
end

