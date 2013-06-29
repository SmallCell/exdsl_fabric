# File    : map_reduce.ex

defmodule Exdsl.Fabric.Exec do
    @moduledoc """
Provides an alternative control flow.
"""
    def child(elem, func, parent) do
        parent <- {self, func.(elem)}
    end

    def spawn_children(collection, func) do
        Enum.map collection, fn el -> spawn(__MODULE__, :child, [el, func, self]) end
    end

    def reduce_results(pids) do
        Enum.map pids, fn pid -> receive do: ( {^pid, value} -> value) end
    end

    def pmap(collection, func) do
        collection |> spawn_children(func) |> reduce_results
    end
    
end