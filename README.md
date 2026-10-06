# RecurLoop VS Code — Quickstart

A quick introduction to running, debugging and using project code in the
RecurLoop terminal. The probe moves 10 km per tick for three ticks.

For installation and runtime requirements, follow the
[extension guide](https://github.com/RecurLoop/RecurLoop/blob/main/tools/vscode-recurloop/README.md).
Then open this repository's root folder as a trusted VS Code workspace.
Everything below is already configured.

## Run and debug

In **Run and Debug**, select **Probe: run** and press **F5**. The `run` target
builds the program and prints:

```text
Tick 1: 10 km
Tick 2: 20 km
Tick 3: 30 km
```

Set a breakpoint on `distance = Probe:advance(distance, 10)` in `src/main.rl`.
Select **Probe: debug** and press **F5**. Inspect `distance` and `tick`, then
press **F11** to step into `Probe:advance`.

## Use the same function in the terminal

Run **RecurLoop: Open Project Console** from the Command Palette. In this
RecurLoop terminal, enter:

```rl
Probe:main()
```

It prints the three `Tick` lines directly in this console. To display a
function's return value, use `print`:

```rl
print str(Probe:advance(0, 10))
```

It prints **10**. This is the same function called by the application.
In `src/probe.rl`, change its return expression to `distance + speed * 2`
and **save the file**. Once the project reloads, enter in the same terminal:

```rl
:refresh
print str(Probe:advance(0, 10))
```

Now it prints **20**. Saving republishes project code; `:refresh` makes an
already-open terminal use that code. You can call functions directly without
building a separate executable. Run **Probe: run** again to see the application
use the changed function too: its distances become 20, 40 and 60 km.

You can also run project targets from this terminal:

```rl
:targets
:target check
:target run
```

## How the configuration fits together

- `src/probe.rl` defines `Probe:advance`; `src/main.rl` calls it.
- `recurloop.project.rl` includes the source and defines `check`, `prepare`,
  `build`, `run` and `debug`. Opening the project loads definitions only.
- `.vscode/launch.json` selects a target using `"type": "recurloop"` and
  `"target": "run"` or `"target": "debug"`.
- Both launch targets depend on `build`, which creates a debug-enabled executable
  in `.cache/recurloop/`. Dependencies run automatically; no `preLaunchTask` is needed.
- `.vscode/tasks.json` maps **Ctrl+Shift+B** to `build` and exposes `check` in
  **Terminal → Run Task**.

Use **F12** on `Probe:advance` to jump to its definition, or trigger completion
after `Probe:`. For your own project setup and more features, continue with the
[extension guide](https://github.com/RecurLoop/RecurLoop/blob/main/tools/vscode-recurloop/README.md).
