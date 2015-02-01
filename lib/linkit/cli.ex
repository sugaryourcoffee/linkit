defmodule Linkit.CLI do

  @moduledoc """
  Parses the command line and dispatches to the respective functions to add,
  update, delete, check and list URIs
  """
  @vsn 0.1

  @doc """
  Entry for parsing the command line options
  """
  def main(argv) do
    argv
    |> parse_args
  end

  @doc """
  parses *argv* that is retrieved from the command line. *argv* can have 
  following values.

  * ["--help  "]
  * ["--add   ", "uri", "--tag", "tag", "--description", "description"]
  * ["--update", "uri", "--tag", "tag", "--description", "description"]
  * ["--delete", "uri"]
  * ["--check ", "uri"]
  * ["--list  ", "uri", "--tag", "tag", "--description", "description"]

  Returns tuples for each of the commands, except for help which is returned as
  an atom.

  * :help
  * {:add,    URI, TAG, DESCRIPTION}
  * {:update, URI, TAG, DESCRIPTION}
  * {:remove, URI}
  * {:check,  URI}
  * {:list,   URI, TAG, DESCRIPTION}
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,
                               switches: [help:        :boolean,
                                          add:         :boolean,
                                          update:      :boolean,
                                          remove:      :boolean,
                                          check:       :boolean,
                                          list:        :boolean,
                                          tag:         :string,
                                          description: :string],

                               aliases:  [h: :help,
                                          a: :add,
                                          u: :update,
                                          r: :remove,
                                          c: :check,
                                          l: :list,
                                          t: :tag,
                                          d: :description])

    command(parse)
  end

  def command({[{:help,   true} |    _],    _, _}), do:  :help
  def command({[{:add,    true} | args], argv, _}), do: {:add,    args, argv}
  def command({[{:update, true} | args], argv, _}), do: {:update, args, argv}
  def command({[{:remove, true} | args], argv, _}), do: {:remove, args, argv}
  def command({[{:check,  true} | args], argv, _}), do: {:check,  args, argv}
  def command({[{:list,   true} | args], argv, _}), do: {:list,   args, argv}
  def command({[_                     ],    _, _}), do:  :help
end
