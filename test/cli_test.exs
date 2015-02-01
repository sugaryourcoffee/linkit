defmodule CliTest do
  use ExUnit.Case

  import Linkit.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["--help"]) == :help
    assert parse_args(["-h"])     == :help
  end

  test ":add returned with uri, tag and description" do
    long   = ["--add", "http://example.com", 
              "--tag", "tag", 
              "--description", "description"] 
    short  = ["--add", "http://example.com", 
              "--tag", "tag", 
              "--description", "description"] 
    result = {:add, 
              [tag: "tag", description: "description"], 
              ["http://example.com"]}

    assert parse_args(long)  == result
    assert parse_args(short) == result
  end

  test ":update returned with uri, tag and description" do
    long   = ["--update", "http://example.com", 
              "--tag", "tag", 
              "--description", "description"] 
    short  = ["--update", "http://example.com", 
              "--tag", "tag", 
              "--description", "description"] 
    result = {:update, 
              [tag: "tag", description: "description"], 
              ["http://example.com"]}

    assert parse_args(long)  == result
    assert parse_args(short) == result
  end

  test ":remove returned with uri" do
    long   = ["--remove", "http://example.com"]
    short  = ["-r",       "http://example.com"]
    result = {:remove, [], ["http://example.com"]}

    assert parse_args(long)  == result
    assert parse_args(short) == result
  end

  test ":check returned with uri" do 
    long   = ["--check", "http://example.com"]
    short  = ["-c",      "http://example.com"]
    result = {:check, [], ["http://example.com"]}

    assert parse_args(long)  == result
    assert parse_args(short) == result
  end

  test ":list returned with given tag and description filter" do
    long   = ["--list", "http://example.com",
              "--tag", "tag",
              "--description", "description"]
    short  = ["--list", "http://example.com",
              "-t", "tag",
              "-d", "description"]
    result = {:list, [tag: "tag", description: "description"],
              ["http://example.com"]}

    assert parse_args(long)  == result
    assert parse_args(short) == result
  end

end
