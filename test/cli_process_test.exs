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

  test "add new link" do
    result = capture_io fn -> process({:add, ["http://example.com"],
                                      [{:tags, "tag"}, 
                                       {:description, "description"}]}) end
    assert result == """
    Link added
    ==========
    Link               | Tags | Description
    -------------------+------+------------
    http://example.com | tag  | description 
    """
  end

  test "update all values" do
    result = capture_io fn -> process({:update, ["http://example.com"],
                                      [{:tags, "tag 1"}, 
                                       {:description, "description 1"}]}) end
    assert result == """
    Link updated
    ============
    Link               | Tags  | Description
    -------------------+-------+--------------
    http://example.com | tag 1 | description 1
    """
  end

  test "remove" do
    result = capture_io fn -> process({:remove, ["http://example.com"], []}) end

    assert result == """
    Link removed
    ============
    """
  end

  test "check a specific URI" do
    result = capture_io fn -> process({:check, ["http://example.com",
                                               "http://example.cmo"], []}) end

    assert result == """
    Check results
    =============
    Link               | Response
    -------------------+---------
    http://example.com | ok
    http://example.cmo | 404
    """
  end

  test "check URIs based on a filter" do
    process({:add, ["http://example.com"], 
                  [{:tag, "tag"}, {:description, "description"}]})

    result = capture_io fn -> process({:check, [], 
                                      [{:tag, "tag"}, 
                                       {:description, "description"}]}) end
    assert result == """
    Check results
    =============
    Link               | Response
    -------------------+---------
    http://example.com | ok
    """
  end

  test "list a specific URI" do
    process({:add, ["http://example.com"], 
                  [{:tag, "tag"}, {:description, "description"}]})

    result = capture_io fn -> process({:list, ["http://example.com"], []}) end

    assert result == """
    Link updated
    ============
    Link               | Tags | Description
    -------------------+------+------------
    http://example.com | tag  | description
    """
  end

  test "list all URIs" do
    process({:add, ["http://example.com"], 
                  [{:tag, "tag"}, {:description, "description"}]})

    result = capture_io fn -> process({:list, [], []}) end

    assert result == """
    Link updated
    ============
    Link               | Tags | Description
    -------------------+------+------------
    http://example.com | tag  | description
    """
  end

  test "list URIs based on a filter" do
    process({:add, ["http://example.com"], 
                  [{:tag, "tag"}, {:description, "description"}]})

    result = capture_io fn -> process({:list, [], [{:tag, "tag"}]}) end

    assert result == """
    Link updated
    ============
    Link               | Tags | Description
    -------------------+------+------------
    http://example.com | tag  | description
    """
  end
end
