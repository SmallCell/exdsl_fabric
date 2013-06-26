# File    : template.ex

defmodule Exdsl.Fabric.Template do
    @moduledoc """
Provides a template for empty Fabric.
"""
    

    @template_header """
# File    : template.ex

defmodule #{UserModuel} do
    
"""
    
    @template_footer """

end
"""
    @doc """
Returns template for empty Fabric.
"""
    def generate(args) do
        user_module = args[:script]
        snippets = args[:snippets]
        
        output = args[:out_dir] <> "/" <> user_module <> ".exs"
        {:ok, file} = File.open(output, [:write])
        
        IO.write(file, @template_header)

        lc snippet inlist snippets do
            IO.write(file, "#{snippet}\n")
        end

        IO.write(file, @template_footer)

    end
    
end

