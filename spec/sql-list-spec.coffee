SqlList = require '../lib/sql-list'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.


describe "Proof of concept test suite", ->
  it "two plus is two equals to four", ->
    expect(2+2).toBe 4
