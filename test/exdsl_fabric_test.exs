Code.require_file "test_helper.exs", __DIR__

defmodule Exdsl.Fabric.Test.Exec do
  use ExUnit.Case
  alias Exdsl.Fabric.Exec

  test "compare normal and paralel map" do
      fun = fn x -> x*x end
      collection = [1,2,3,4]

      assert (
              Enum.map( collection, fun ) #|> IO.inspect
              == Exec.pmap( collection, fun ) #|> IO.inspect
          )
  end
end
