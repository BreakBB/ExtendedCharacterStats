# Extended Character Stats

![build](https://github.com/BreakBB/ExtendedCharacterStats/workflows/build/badge.svg) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![Downloads](https://img.shields.io/github/downloads/BreakBB/ExtendedCharacterStats/total.svg)](https://github.com/BreakBB/ExtendedCharacterStats/releases/)
[![Downloads Latest](https://img.shields.io/github/downloads/BreakBB/ExtendedCharacterStats/v3.3.14/total.svg)](https://github.com/BreakBB/ExtendedCharacterStats/releases/latest)
[![Date Latest](https://img.shields.io/github/release-date/BreakBB/ExtendedCharacterStats.svg)](https://github.com/BreakBB/ExtendedCharacterStats/releases/latest)
[![Commits Since Latest](https://img.shields.io/github/commits-since/BreakBB/ExtendedCharacterStats/latest.svg)](https://github.com/BreakBB/ExtendedCharacterStats/commits/master)

#### A simple addon to list all the available stats not displayed in the character info pane by default


### [Download on CurseForge](https://www.curseforge.com/wow/addons/extended-character-stats/files)

### [Download on GitHub](https://github.com/BreakBB/ExtendedCharacterStats/releases/latest)

![image](https://user-images.githubusercontent.com/33514570/120346975-2ac47f80-c2fc-11eb-90d4-c012a1e56296.png)


## Issues / Bug reports

**Please file any reports of issues and/or bugs to the [GitHub Repository](https://github.com/BreakBB/ExtendedCharacterStats/issues/new/choose)!**

## Development

### Installing lua

1. Install [Lua](https://www.lua.org/download.html) (5.1, since the WoW client uses Lua 5.1)
    - For macOS that is `brew install lua@5.1`
2. Install [luarocks](https://luarocks.org/)
    - For macOS that is `brew install luarocks`
3. Configure `luarocks` to use the correct Lua version (by default luarocks uses the latest installed Lua version)
    - `luarocks config lua_version 5.1`
4. Install [busted](https://github.com/lunarmodules/busted)
    - `luarocks install busted`
5. Install [luacheck](https://github.com/lunarmodules/luacheck/)
    - `luarocks install luacheck`

### luacheck

This project uses `luacheck` for linting. To run the linter, execute the following command:

```sh
luacheck -q .
```

### Unit Tests

This project uses `busted` for unit testing. To run the tests, execute the following command:

```sh
busted -p ".test.lua" .
```

## Donation

If you like this addon and want to support the development of it, you can do so here:

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=T9DMPD9EZDC98&source=url"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif"/></a>
