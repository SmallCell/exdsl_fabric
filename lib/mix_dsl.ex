# File    : mix_dsl.ex

defmodule Mix.Tasks.New.Dsl do
    @hidden false
    @shortdoc "Create new Fabric script."
    @moduledoc """
Provides a way to create new Fabric script from template.

  : mix new.dsl --script SCRIPT [--out_dir PATH] [MODULES]

Example:
  Create new script, add script `install_db into lib using template
  from `shell and `nets mini languages.

  : mix new.dsl --script install_db shell nets

## Command line options

  * `--script`  - name of the script
  * `--out_dir` - output directory

"""
    use Mix.Task
    alias Exdsl.Fabric.Template

    def run(args) do
        Mix.shell Mix.Shell.IO

        { opts, langs } = OptionParser.parse(args, switches: [])
        
        if opts[:script] do

            snippets = lc lang inlist langs do
                get_snippet(lang) || "# Here be dragons of `#{lang}"
            end
            
            out_dir = opts[:out_dir] || "lib"
            File.mkdir(out_dir)

            Template.generate( script: opts[:script],
                               snippets: snippets,
                               out_dir:  out_dir
                             )
            
            :ok
        else
            Mix.Shell.error "** (Fabric) use --script SCRIPT to name the script."
            :noop
        end

    end

    def get_snippet(_lang) do
        nil
    end
end