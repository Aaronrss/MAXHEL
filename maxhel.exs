# Final Project
#
# Marce Fuentes
# Aaron Rosas
# Maximiliano Sapien
# 2021-11-18 v1

defmodule Maxhel do
    @moduledoc """
    Functions to encrypt a file
    """

    @doc """
    Return a matrix with the contents of the file
    """
    def read_data(filename) do
        filename
        |> File.stream!()
        |> Enum.map(&String.trim/1)
        |> encryptC()
        # LO DE ARRIBA PARECE SER SOLUCION
        # LO DE ABAJO HACE UNA LISTA DE LISTAS
        #|> Enum.map(&(String.split(&1,",")))
        #|> encryptC()
        # Cuenta el numero de renglos para dividir la encripción a los procesadores
        #|> Enum.count()
        #|> IO.inspect()
    end

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

    @doc """
    Encrypt the contents of the file with Caesar Cipher
    """
    def encryptC(mapfile), do: do_encryptC(mapfile, [])
    defp do_encryptC([], result),
        do: result
    defp do_encryptC([head|tail], result),
        do: do_encryptC(tail, result ++ caesar(to_charlist(head), 0))
    defp do_encryptC([""|tail], result),
        do: do_encryptC(tail, result ++ caesar(to_charlist()))

    #PARECE SER TODO LO NECESARIO PARA CONCURRENCIA
    #def encrypt_parallel(n, cores) do
    #   block = div(n, cores) #divides the range in blocks

#        1..cores
 #       |> Enum.map(&Task.async(fn -> encryptC((&1 * block), ((&1 - 1) * block + 1)) end))
  #      |> Enum.map(&Task.await(&1, 50000))
   #     |> Enum.sum()
    #end

    @doc """
    Write the content encrypted into a file
    """
    def write_file do
 
    end

    @doc """
    
    """
    def main() do
        filename = IO.gets("Give me the name of the file with the extension: ")
            |> String.replace("\n", "10")
        data = filename
            |> read_data()
        
        # Llamar metodo de encriptación

    end

end