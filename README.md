# atom-sql-list

Various SQL related text and list processing commands.
Separate block selection is supported.

Atom package link:
https://atom.io/packages/atom-sql-list

![sql-list-1](https://cloud.githubusercontent.com/assets/2071639/13898959/06d57d4a-edeb-11e5-8995-9e5d8a38c03d.gif)

## Usage

The following commands can be accessed via [Command Palette](https://atom.io/docs/latest/getting-started-atom-basics#command-palette):

**Quote Each Line**

Quotes each selected line with a single quote `'` .
This command minds the single quote `'` characters and escapes them.
That is, `My friend's computer` becomes `'My friend''s computer'`.

**Unquote Each Line**

Remove single quote from selected lines.
This command minds the single quote `'` characters and de-escapes them.
That is, `'My friend''s computer'` becomes `My friend's computer`.

**Comment Each Line**

Comments selected lines with `--` characters.

**Uncomment Each Line**

Removes leading `--` characters from selected lines.

**Add Leading Commas**

Adds leading comma `,` to the selected lines.

**Remove Leading Commas**

Removes leading comma `,` from the selected lines, if exists.

**Add Trailing Commas**

Adds trailing comma `,` to the selected lines.

**Remove Trailing Commas**

Removes trailing comma `,` from the selected lines, if exists.


## Installation

```
apm install atom-sql-list
```

## Settings

None, at least for now.

## Key Bindings

None, at least for now.

## Changelog

See the [CHANGELOG.md](CHANGELOG.md) file.

## License

MIT, see the [LICENSE.md](LICENSE.md) file.
