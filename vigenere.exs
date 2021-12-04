defmodule Vigenere do

  def vigenereenc(str, key), do: cipher(str, key, 1)
  def vigeneredec(str, key), do: cipher(str, key, -1)

  defp cipher(str, key, dir) do
    str = String.upcase(str)
      |> String.replace(~r/[^A-Z]/, "")
      |> to_char_list

    key_iterator = String.upcase(key)
      |> String.replace(~r/[^A-Z]/, "")
      |> to_char_list
      |> Enum.map(fn c -> (c - 65) * dir end)
      |> Stream.cycle

    Enum.zip(str, key_iterator)
      |> Enum.reduce('', fn {char, moved}, ciphertext ->
         [rem(char - 65 + moved + 24, 24) + 65 | ciphertext]
       end)
      |> Enum.reverse
      |> List.to_string
  end
end
