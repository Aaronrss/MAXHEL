# Final Project
#
# Marce Fuentes
# Aaron Rosas
# Maximiliano Sapién
# 2021-11-18 v1

defmodule Maxhel do
    @moduledoc """
    Allows to ecnrypt .txt and .csv files through the "Caesar Cipher" algorithm using functional
    programming and recursion. For now we are focusing to acomplish this program to run with this
    algorithm for we would like to modify the algorithm to be less predictable.

    The Elixir program reads the text file and assigns a line to a list as a string to be converted,
    all this lists will be stored on another list. The lists will be assigned to an individual
    thread in order to concurrently convert the whole text file.
    """

    @doc """
    Returns a list with the contents of the file in a way we can handle with our other methods.
    """
    def read_data(filename) do
        filename
        |> File.stream!()
        |> Enum.map(&String.trim/1)
        #|> encryptC()
    end

    @doc """
    This method converts a received string into a charlist, this is done so we can convert each of the
    chars into another symbol thorugh its decimal value.
    """
    def convert(str, shift_key) when is_binary(str) do
        char_list = String.codepoints(str)
        convert(char_list, shift_key, "")
    end
    def convert([head | tail], shift_key, acc) do
      <<value::utf8>> = head
      accumulator = acc <> List.to_string([shift(value, shift_key)])
      convert(tail, shift_key, accumulator)
    end
    def convert([], _shift_key, acc) do
        acc
    end

    @doc """
    All patterns that would possibly match the conversion for: numbers, symbols, lower case and upper case letters.
    """
    def shift(ch, n) when ch in ?a..?z do
        rem(ch - ?a + n, 26) + ?a
    end
    def shift(ch, n) when ch in ?A..?Z do
        rem(ch - ?A + n, 26) + ?A
    end
    def shift(ch, n) when ch == 32 do
        rem(ch - 32 + n, 26) + 32
    end
    def shift(ch, n) when ch in 38..59  do
        rem(ch - 38 + n, 21) + 38
    end
    def shift(ch, _), do: ch

    @doc """
    Iterates the received list to encrypt it.
    """
    def encryptC(list), do: do_encryptC(list, [])
    defp do_encryptC([], result),
        do: result
    defp do_encryptC([head|tail], result),
        do: do_encryptC(tail, result ++ [convert(head, 10)])

    @doc """
    This method makes the encryptC() call parallel.
    """
    def encrypt_parallel(list) do
        n = length(list)
        temp = []

        1..n
        |> Enum.map(&Task.async(fn -> encryptC([Enum.at(list, &1 - 1)] ++ temp) end))
        |> Enum.map(&Task.await(&1, 50000))
    end

    @doc """
    Write the encrypted content into a file.
    """
    def write_data(data, filename) do
        {:ok, out_file} = File.open(filename, [:write])
        for row <- data do
          IO.puts(out_file, Enum.join(row, " "))
        end
        File.close(out_file)
    end

    @doc """
    We receive the name of the file to read and we send it to be read thorough a pipeline
    to "read_data()", then we save the results of "read_data()" in a variable which we send to the next method "encrypt_parallel()" and
    we save the result to another variable which we then use to write the encrypted data (write_data()) to a .txt file.
    """
    def main(filename) do
        data = filename
            |> read_data()
        res = encrypt_parallel(data)
        write_data(res, "encriptado.txt")
    end
end
