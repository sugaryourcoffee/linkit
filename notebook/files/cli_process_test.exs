defmodule CliProcessTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Linkit.CLI, only: [process: 1]

  test "help" do
    result = capture_io fn -> process(:help) end

    assert result == """
    NAME
        linkit - organizing links and adding them to a web page

    SYNOPSIS
        linkit command [command options] [arguments...]

    VERSION
        0.1

    COMMANDS
        add    - Adds a link to linkit
        check  - Checks if link can be reached
        help   - Prints this help
        list   - Lists the links
        remove - Removes a link
        update - Updates a link

    """
  end

  test "add" do
  end

  test "update all values" do
  end

  test "update the tags" do
  end

  test "update the description" do
  end

  test "remove" do
  end

  test "check a specific URI" do
  end

  test "check all URIs" do
  end

  test "check URIs based on a filter" do
  end

  test "list a specific URI" do
  end

  test "list all URIs" do
  end

  test "list URIs based on a filter" do
  end
end
