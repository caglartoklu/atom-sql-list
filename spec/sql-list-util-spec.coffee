SqlListUtil = require '../lib/sql-list-util'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.


describe "sql-list-util test suite", ->


  # startsWith

  it "returns true if starts with", ->
    expect(SqlListUtil.startsWith("abcdef", "a")).toBe true
    expect(SqlListUtil.startsWith("abcdef", "abc")).toBe true
    expect(SqlListUtil.startsWith("abcdef", "")).toBe true
    expect(SqlListUtil.startsWith("", "")).toBe true

  it "returns false if does not start with", ->
    expect(SqlListUtil.startsWith("abcdef", "xxx")).toBe false
    expect(SqlListUtil.startsWith("", "x")).toBe false


  # endsWith

  it "returns true if ends with", ->
    expect(SqlListUtil.endsWith("abcdef", "f")).toBe true
    expect(SqlListUtil.endsWith("abcdef", "def")).toBe true
    expect(SqlListUtil.endsWith("abcdef", "")).toBe true
    expect(SqlListUtil.endsWith("", "")).toBe true

  it "returns false if does not end with", ->
    expect(SqlListUtil.endsWith("abcdef", "xxx")).toBe false
    expect(SqlListUtil.endsWith("", "x")).toBe false


  # removeIfStartsWith

  it "returns true if starts with", ->
    expect(SqlListUtil.removeIfStartsWith("abcdef", "a")).toBe "bcdef"
    expect(SqlListUtil.removeIfStartsWith("abcdef", "abc")).toBe "def"
    expect(SqlListUtil.removeIfStartsWith("abcdef", "")).toBe "abcdef"
    expect(SqlListUtil.removeIfStartsWith("", "")).toBe ""

  it "returns false if does not start with", ->
    expect(SqlListUtil.removeIfStartsWith("abcdef", "xxx")).toBe "abcdef"
    expect(SqlListUtil.removeIfStartsWith("", "x")).toBe ""


  # removeIfEndsWith

  it "returns true if ends with", ->
    expect(SqlListUtil.removeIfEndsWith("abcdef", "f")).toBe "abcde"
    expect(SqlListUtil.removeIfEndsWith("abcdef", "def")).toBe "abc"
    expect(SqlListUtil.removeIfEndsWith("abcdef", "")).toBe "abcdef"
    expect(SqlListUtil.removeIfEndsWith("", "")).toBe ""

  it "returns false if does not end with", ->
    expect(SqlListUtil.removeIfEndsWith("abcdef", "xxx")).toBe "abcdef"
    expect(SqlListUtil.removeIfEndsWith("", "x")).toBe ""


  # removeIfEndsWith

  it "returns true if ends with", ->
    expect(SqlListUtil.removeIfEndsWith("abcdef", "f")).toBe "abcde"
    expect(SqlListUtil.removeIfEndsWith("abcdef", "def")).toBe "abc"
    expect(SqlListUtil.removeIfEndsWith("abcdef", "")).toBe "abcdef"
    expect(SqlListUtil.removeIfEndsWith("", "")).toBe ""

  it "returns false if does not end with", ->
    expect(SqlListUtil.removeIfEndsWith("abcdef", "xxx")).toBe "abcdef"
    expect(SqlListUtil.removeIfEndsWith("", "x")).toBe ""


# ltrim

  it "removes all the leading whitespace", ->
    expect(SqlListUtil.ltrim(" abc")).toBe "abc"
    expect(SqlListUtil.ltrim("abc  ")).toBe "abc  "
    expect(SqlListUtil.ltrim("  abc  ")).toBe "abc  "
    expect(SqlListUtil.ltrim(" \t \r \n  abc  ")).toBe "abc  "


# rtrim

  it "removes all the trailing whitespace", ->
    expect(SqlListUtil.rtrim("abc ")).toBe "abc"
    expect(SqlListUtil.rtrim("  abc")).toBe "  abc"
    expect(SqlListUtil.rtrim("  abc  ")).toBe "  abc"
    expect(SqlListUtil.rtrim("  abc \t \r \n ")).toBe "  abc"


  # reverse

  it "reverses a string", ->
    expect(SqlListUtil.reverse("A")).toBe "A"
    expect(SqlListUtil.reverse("AYA")).toBe "AYA"
    expect(SqlListUtil.reverse("abc")).toBe "cba"
    expect(SqlListUtil.reverse("\t abc \t")).toBe "\t cba \t"


# extractLeadingWhiteSpace

  it "extracts the leading whitespace from a string", ->
    expect(SqlListUtil.extractLeadingWhiteSpace("a")).toBe ""
    expect(SqlListUtil.extractLeadingWhiteSpace(" a")).toBe " "
    expect(SqlListUtil.extractLeadingWhiteSpace("  aa ")).toBe "  "
    expect(SqlListUtil.extractLeadingWhiteSpace(" \t \r \n  a ")).toBe " \t \r \n  "


# extractTrailingWhiteSpace

  it "extracts the leading whitespace from a string", ->
    expect(SqlListUtil.extractTrailingWhiteSpace("a")).toBe ""
    expect(SqlListUtil.extractTrailingWhiteSpace("a ")).toBe " "
    expect(SqlListUtil.extractTrailingWhiteSpace(" aa  ")).toBe "  "
    expect(SqlListUtil.extractTrailingWhiteSpace(" a \t \r \n  ")).toBe " \t \r \n  "
