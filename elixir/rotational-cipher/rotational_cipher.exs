defmodule RotationalCipher do
  @lower_chars 'abcdefghijklmnopqrstuvwxyz'
  @upper_chars 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text 
      |> to_charlist
      |> Enum.map(fn (char) -> cipher(char, shift) end)
      |> to_string
  end

  defp cipher(char, shift) do
    cond do
      is_upcase?(char) -> cipher_upper(char, shift)
      is_downcase?(char) -> cipher_lower(char, shift)
      true -> char
    end
  end

  defp cipher_lower(char, shift) do
    cipher_character(@lower_chars, char, shift)
  end

  defp cipher_upper(char, shift) do
    cipher_character(@upper_chars, char, shift)
  end

  defp cipher_character(map, char, shift) do
    index = find_index(map, char)
    map_length = length(map)
    offset = rem(shift, map_length)

    if ((index + offset) > (map_length - 1)),
      do: shift_char(map, offset - (map_length - index)),
      else: shift_char(map, index + offset)
  end

  defp shift_char(map, offset) do
    map |> Enum.at(offset)
  end

  @spec is_upcase?(char :: char) :: boolean
  defp is_upcase?(char) do
    char in @upper_chars
  end

  @spec is_downcase?(char :: char) :: boolean
  defp is_downcase?(char) do
    char in @lower_chars
  end

  defp find_index(map, char) do
    Enum.find_index(map, fn (c) -> c == char end)
  end
end
