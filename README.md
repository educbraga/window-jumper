# Window Jumper

A **MacOS Hammerspoon script** for easily jumping between visible windows in the current space using simple keyboard shortcuts.

## Features
- Quickly cycle through open windows in the current space.
- Uses `Cmd + \\`` to switch to the next window.
- Uses `Cmd + Shift + \\`` to switch to the previous window.
- Automatically updates the window list when windows are opened, closed, or moved.

## Installation
1. Install **Hammerspoon** if you haven't already: [Hammerspoon website](https://www.hammerspoon.org/)
2. Open your Hammerspoon configuration directory:
   ```sh
   mkdir -p ~/.hammerspoon
   cd ~/.hammerspoon
   ```
3. Create or edit your `init.lua` file:
   ```sh
   nano ~/.hammerspoon/init.lua
   ```
4. Copy and paste the script into `init.lua`, then save and exit.
5. Reload Hammerspoon:
   - Click the Hammerspoon menu bar icon → "Reload Config"
   - Or run the following in the Hammerspoon console:
     ```lua
     hs.reload()
     ```

## Usage
- **Switch to the next window:** Press `Cmd + \\``
- **Switch to the previous window:** Press `Cmd + Shift + \\``

## How It Works
- The script maintains a list of **visible windows** in the current space.
- It detects the **currently focused window** and updates the list dynamically.
- Uses `hs.window.filter` to track changes such as window creation, destruction, minimization, and visibility changes.
- Allows seamless cycling through windows in a **consistent order**.

## Notes
- The script **only cycles through visible windows** in the current macOS space.
- If a window is minimized or moved to another space, it will be **excluded** from the cycle.

## Debugging
If the script does not behave as expected:
1. Open **Hammerspoon Console** (`Cmd + Alt + \`` inside Hammerspoon).
2. Run:
   ```lua
   updateWindowList()
   ```
3. Check if window cycling works properly.

## License
MIT License

