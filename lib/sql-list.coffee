{CompositeDisposable} = require 'atom'

SqlListUtil = require './sql-list-util'

module.exports = SqlList =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command(s)
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Quote Each Line': => @quoteEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Unquote Each Line': => @unquoteEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Comment Each Line': => @commentEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Uncomment Each Line': => @uncommentEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Add Leading Commas': => @addLeadingCommasToEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Remove Leading Commas': => @removeLeadingCommasFromEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Add Trailing Commas': => @addTrailingCommasToEachLine()
    @subscriptions.add atom.commands.add 'atom-workspace', 'sql-list:Remove Trailing Commas': => @removeTrailingCommasFromEachLine()


  serialize: ->
    # pass


  singleQuoteLine: (haystack) ->
    # quotes a string with ' characters
    leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.ltrim(haystack)
    haystack = SqlListUtil.rtrim(haystack)
    haystack = SqlListUtil.escapeQuote(haystack)
    haystack = "'#{haystack}'"
    haystack = leadingWhiteSpace + haystack + trailingWhiteSpace
    return haystack


  singleUnquoteLine: (haystack, quoteChar="'") ->
    # unquotes a string with ' characters
    quoteChar = quoteChar[0]  # quote must be one character
    leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = haystack.trim()

    quoted = true
    if haystack.length < 2
      quoted = false

    if !SqlListUtil.startsWith(haystack, quoteChar)
      quoted = false

    if !SqlListUtil.endsWith(haystack, quoteChar)
      quoted = false

    if quoted
      haystack = haystack[1..]
      haystack = haystack[..-2]

    haystack = SqlListUtil.deEscapeQuote(haystack)
    haystack = leadingWhiteSpace + haystack + trailingWhiteSpace
    return haystack


  commentLine: (haystack) =>
    # comments a string with -- characters
    leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    # trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.ltrim(haystack)
    haystack = "-- #{haystack}"
    haystack = leadingWhiteSpace + haystack
    return haystack


  uncommentLine: (haystack) ->
    # uncomments a string, removes the leading -- characters
    leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    # trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.ltrim(haystack)
    haystack = SqlListUtil.removeIfStartsWith(haystack, "-- ")
    haystack = SqlListUtil.removeIfStartsWith(haystack, "--")
    haystack = leadingWhiteSpace + haystack
    return haystack


  addLeadingCommaToLine: (haystack) ->
    # add a leading comma to each line
    leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    # trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.ltrim(haystack)
    haystack = ",#{haystack}"
    haystack = leadingWhiteSpace + haystack
    return haystack


  removeLeadingCommaFromLine: (haystack) ->
    # remove a leading comma from each line
    leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    # trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.ltrim(haystack)
    haystack = SqlListUtil.removeIfStartsWith(haystack, ", ")
    haystack = SqlListUtil.removeIfStartsWith(haystack, ",")
    haystack = leadingWhiteSpace + haystack
    return haystack


  addTrailingCommaToLine: (haystack) ->
    # add a trailing comma to each line
    # leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.rtrim(haystack)
    haystack = "#{haystack},"
    haystack = haystack + trailingWhiteSpace
    return haystack


  removeTrailingCommaFromLine: (haystack) ->
    # remove a trailing comma from each line
    # leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(haystack)
    trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(haystack)
    haystack = SqlListUtil.rtrim(haystack)
    haystack = SqlListUtil.removeIfEndsWith(haystack, " ,")
    haystack = SqlListUtil.removeIfEndsWith(haystack, ",")
    haystack = haystack + trailingWhiteSpace
    return haystack


  processEachLine: (callback) ->
    # https://atom.io/docs/api/v1.3.3/Workspace
    editor = atom.workspace.getActiveTextEditor()

    # https://atom.io/docs/api/v1.3.3/TextEditor
    selections = editor.getSelections()

    for selection in selections
      # loop each selection
      output = ""
      selectionText = selection.getText()

      # store the leading white space of this selection:
      leadingWhiteSpace = SqlListUtil.extractLeadingWhiteSpace(selectionText)
      # store the trailing white space of this selection:
      trailingWhiteSpace = SqlListUtil.extractTrailingWhiteSpace(selectionText)

      # split the selection to lines:
      textLines = selectionText.split("\n")

      for textLine in textLines
        # loop each line in selection
        if textLine.trim().length > 0
          outputTextLine = "#{callback(textLine)}"
          output = output + outputTextLine
        else
          output = output + "\n\n"

      # remove the last \n character:
      output = SqlListUtil.rtrim(output) + trailingWhiteSpace

      # https://atom.io/docs/api/v1.3.3/Selection#instance-insertText
      selection.insertText(output, { "select": true, "normalizeLineEndings": true })


  quoteEachLine: ->
    @processEachLine(@singleQuoteLine)


  unquoteEachLine: ->
    @processEachLine(@singleUnquoteLine)


  commentEachLine: ->
    @processEachLine(@commentLine)


  uncommentEachLine: ->
    @processEachLine(@uncommentLine)


  addLeadingCommasToEachLine: ->
    @processEachLine(@addLeadingCommaToLine)


  removeLeadingCommasFromEachLine: ->
    @processEachLine(@removeLeadingCommaFromLine)


  addTrailingCommasToEachLine: ->
    @processEachLine(@addTrailingCommaToLine)


  removeTrailingCommasFromEachLine: ->
    @processEachLine(@removeTrailingCommaFromLine)
