defmodule MyList do
  def caesar(list, n) do
    Enum.map list, &(perform_addition(&1, n))
    |> to_charlist
    |> List.to_string
  end

  defp perform_addition(char_val, n) when char_val < 122 do
    char_val + n
  end

  defp perform_addition(_, n) do
    97 + n
  end
end