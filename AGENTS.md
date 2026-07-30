# Agent Instructions

This repo is a personal Neovim configuration (lazy.nvim + Lua).

## Keep README.md in sync

**Every time a keymap is added, changed, or removed, or a plugin is installed or removed,
update `README.md` accordingly before finishing the task.**

Specifically:
- New/changed/removed keymap → update the relevant table in the "Keymaps" section of
  `README.md` (or add a new table/section if it's a new plugin/feature area).
- New plugin installed → add a row to the "Plugins" table in `README.md` with a one-line
  description of its purpose, and add a "Keymaps" section for it if it defines any.
- Plugin removed → remove its row from the "Plugins" table and its keymap section/table.
- If a change causes one plugin's keymap to shadow/override another's (e.g. a `ft`-lazy-loaded
  plugin setting a global keymap that conflicts with an existing one), note that explicitly in
  `README.md` near the affected keymap(s).

Do this as part of the same change — don't leave it for a follow-up unless the user explicitly
asks to defer it.
