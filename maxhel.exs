# Final Project
#
# Marce Fuentes
# Aaron Rosas
# Maximiliano Sapién
# 2021-11-18 v1

defmodule Maxhel do
    @moduledoc """
    Allows the encryption of .txt and .csv files through the "Caesar Cipher" algorithm by using functional
    programming and recursion. For now we are focusing to accomplish this program to run with this
    algorithm; for future references we would like to modify the algorithm to be less predictable.

    The Elixir program reads the text file and assigns a line to a list as a string to be converted,
    all this lists will be stored on another list. The lists will be assigned to an individual
    thread in order to concurrently convert the whole text file.
    """

    @doc """
    Returns a list with the contents of the file in a way the system can handle with the following methods.
    """
    def read_data(filename) do
        filename
        |> File.stream!()
        |> Enum.map(&String.trim/1)
        #|> encryptC()
    end

    @doc """
    This method converts the received string into a charlist; this is done so each of the
    chars can be converted into another symbol through its decimal value.
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
    Encrypts all patterns that would possibly match the conversion.
    """
    def shift(ch, n) when ch in 1..255 do
        rem(ch - 1 + n, 255) + 1
    end
    def shift(ch, _), do: ch

    @doc """
    Iterates the received list to encrypt it.
    """
    def encryptC(list, key), do: do_encryptC(list, [], key)
    defp do_encryptC([], result, key),
        do: result
    defp do_encryptC([head|tail], result, key),
        do: do_encryptC(tail, result ++ [convert(head, key)], key)

    @doc """
    This method makes the encryptC() call parallel.
    """
    def encrypt_parallel(list, key) do
        n = length(list)
        temp = []

        1..n
        |> Enum.map(&Task.async(fn -> encryptC([Enum.at(list, &1 - 1)] ++ temp, key) end))
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
    def main(filename, key) do
        if ((key >= -6) && (key <= 6)) do
            data = filename
            |> read_data()
            res = encrypt_parallel(data, key)
            write_data(res, "encriptado.txt")
        else
           "Out of bounds parameter, only up to 6 to encypt and -6 to decrypt."
        end
    end
end
