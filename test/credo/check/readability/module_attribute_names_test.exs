defmodule Credo.Check.Readability.ModuleAttributeNamesTest do
  use Credo.TestHelper

  @described_check Credo.Check.Readability.ModuleAttributeNames

  #
  # cases NOT raising issues
  #

  test "it should NOT report expected code" do
"""
defmodule CredoSampleModule do
  @some_foobar
end
""" |> to_source_file
    |> refute_issues(@described_check)
  end

  test "it should NOT fail on a dynamic attribute" do
"""
defmodule CredoSampleModule do
  defmacro define(key, value) do
    quote do
      @unquote(key)(unquote(value))
    end
  end
end
""" |> to_source_file
    |> refute_issues(@described_check)
  end

  #
  # cases raising issues
  #

  test "it should report a violation" do
"""
defmodule CredoSampleModule do
  @someFoobar false
end
""" |> to_source_file
    |> assert_issue(@described_check)
  end

end
