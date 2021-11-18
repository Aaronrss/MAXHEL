# Final Project
#
# Maximiliano Sapien
# Aaron Rosas
# 2021-11-18

defmodule Maxhel do
    @moduledoc """
    Functions to encrypt a file
    """
    def read_data(filename) do
        filename
        |> File.stream!()
        |> Enum.map(&String.trim/1)
        |> IO.inspect()
    end
    
end