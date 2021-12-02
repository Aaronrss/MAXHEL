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
        |> Enum.map(&(String.split(&1,",")))
        #|> encryptC()
        # Cuenta el numero de renglos para dividir la encripción a los procesadores
        |> Enum.count()
        #|> IO.inspect()
    end

    @doc """
    Encrypt the contents of the file with Caesar Cipher
    """
    def encryptC(mapfile) do
       # Recorrer renglon 
       # new_data = for row <- file do
    end

    @doc """
    Write the content encrypted into a file
    """
    def write_file do
 
    end

    @doc """
    
    """
    def main() do
        filename = IO.gets("Give me the name of the file with the extension: ")
            |> String.replace("\n", "")
        data = filename
            |> read_data()
        
        # Llamar metodo de encriptación

    end

end