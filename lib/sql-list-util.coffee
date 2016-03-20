{CompositeDisposable} = require 'atom'

# Includes generic utility functions for sql-list.

# How to use:
# SqlListUtil = require './sql-list-util'
# SqlListUtil.greet("Tom")


module.exports =
class SqlListUtil
  constructor: () ->
    pass


  @greet: (name) ->
    # a simple greeting function.
    # can be used to test whether the module has been imported or not.
    alert "greetings, #{name}"


  @startsWith: (haystack, needle) ->
    # returns true if the haystack starts with needle, false otherwise.
    result = false
    if needle.length == 0
      result = true
    else if haystack[..needle.length - 1] == needle
      result = true
    return result


  @endsWith: (haystack, needle) ->
    # returns true if the haystack ends with needle, false otherwise.
    result = false
    if needle.length == 0
      result = true
    else if haystack[-needle.length..] == needle
      result = true
    return result


  @removeIfStartsWith: (haystack, needle) ->
    # returns a copy of haystack where needle is removed from the start.
    # alert(removeIfStartsWith("abc", ""))  # -> "abc"
    # alert(removeIfStartsWith("abc", "ab")) # -> "c"
    result = haystack
    if haystack[..needle.length - 1] == needle
      result = haystack[needle.length..]
    return result


  @removeIfEndsWith = (haystack, needle) ->
    # returns a copy of haystack where needle is removed from the end.
    # alert(removeIfEndsWith("abcdef", ""))  # -> "abcdef"
    # alert(removeIfEndsWith("abcdef", "def")) # -> "abc"
    result = haystack
    if haystack[-needle.length..] == needle
      result = haystack[..-(needle.length+1)]
    return result


  @ltrim: (haystack) ->
    # trims a string from left
    "#{haystack}".replace(/^\s*/g, '')


  @rtrim: (haystack) ->
    # trims a string from right
    "#{haystack}".replace(/\s*$/g, '')


  @reverse: (haystack) ->
    # reverses a string
    haystack.split("").reverse().join("")


  @extractLeadingWhiteSpace: (haystack) ->
    # returns all the whitespace at the beginning of a string.
    buffer = ""
    for ch, i in haystack
      if ch == "\n"
        buffer = buffer + "\n"
      else if ch == "\r"
        buffer = buffer + "\r"
      else if ch == "\t"
        buffer = buffer + "\t"
      else if ch == " "
        buffer = buffer + " "
      else
        break
    return buffer


  @extractTrailingWhiteSpace: (haystack) ->
    # returns all the whitespace at the end of a string.
    reversedHaystack = @reverse(haystack)
    buffer = ""
    for ch, i in reversedHaystack
      if ch == "\n"
        buffer = buffer + "\n"
      else if ch == "\r"
        buffer = buffer + "\r"
      else if ch == "\t"
        buffer = buffer + "\t"
      else if ch == " "
        buffer = buffer + " "
      else
        break
    return @reverse(buffer)


  @escapeQuote: (haystack, quoteChar="'") ->
    # escapes a quote, ' becomes ''
    quoteChar = quoteChar[0]  # quote must be one character
    haystack.replace(/'/g, "''");


  @deEscapeQuote: (haystack, quoteChar="'") ->
    # de-escapes a quote, '' becomes '
    quoteChar = quoteChar[0]  # quote must be one character
    haystack.replace(/''/g, "'");
