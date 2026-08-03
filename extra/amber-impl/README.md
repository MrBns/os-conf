# amber-impl

The zsh config in [`src/`](../../src/), rewritten in [Amber](https://amber-lang.com)
(targeting 0.6.0). Built and verified against `amber 0.6.0-alpha`.

Nothing here replaces the zsh files — they still work exactly as before. This is
a parallel implementation you can switch to by changing one line in `.zshrc`.

## The one constraint that shapes everything

An Amber program compiles to a shell script that runs **in its own process**, so
it can never mutate the calling shell. Aliases, `export`, `PATH`, `cd` — all of
it dies with the subprocess. Sourcing the compiled output instead is not an
option either: `--target zsh` opens every file with `emulate ksh`, which would
wreck an interactive shell.

So the config **prints** the zsh it wants installed, and `.zshrc` evaluates it:

```zsh
eval "$(~/.config/os-conf/extra/amber-impl/build/index)"
```

instead of

```zsh
source ~/.config/os-conf/index.sh
```

Every conditional the zsh version defers to runtime — `command -v eza`,
`[ -d "$dir" ]`, `[ -f "$NVM_DIR/nvm.sh" ]` — is instead **decided in Amber at
startup**, and only the surviving branch is printed. A machine without `mise`
emits no `mise` line at all rather than a dead `if`.

That leaves two kinds of code, and the split is the whole design:

| | lives as | why |
|---|---|---|
| aliases, exports, `PATH`, `jpwd` | printed zsh | must mutate the calling shell |
| `spao`, `killPort`, `gitac`, `copy`, … | real Amber programs in `bin/` | only ever run a program; a subprocess is fine |

## Layout

```
index.ab                  ≡ index.sh          entry point; prints the whole config
build.sh                                      compiles everything into build/
local.example.ab          ≡ local.example.sh  template for machine-local overrides

lib/emit.ab                                   emission primitives (alias/export/func/…)
lib/platform.ab                               OS_ID / OS_LIKE from /etc/os-release
lib/mode.ab                                   OC_MODE validation, desktop|server
lib/cli.ab                                    stderr diagnostics + argv helpers for bin/

conf/path.ab              ≡ src/_path.sh
conf/service.ab           ≡ src/_service.sh
conf/alias.ab             ≡ src/_alias.sh
conf/options.ab           ≡ src/_options.sh
conf/platform/{arch,fedora,ubuntu}.ab         ≡ src/platform-specific/*/alias.sh
conf/mode/{desktop,server}.ab                 ≡ src/mode-specific/*/alias.sh

bin/spao.ab               pacman orphan removal          (was: arch `spao`)
bin/killport.ab           kill whatever holds a port     (was: `killPort`)
bin/clip.ab               clipboard, wl-copy or xclip    (was: `oc_clip`/`copy`/`copyfile`)
bin/jump.ab               resolve a zoxide pick to a path(was: the `ji` half of `jnvim`/`jcode`/…)
bin/gac.ab                git add + commit               (was: `gitac`)
bin/gituser.ab            print the active git identity  (was: `gitUser`)
bin/initctp.ab            scaffold a CP directory        (was: `init_ctp`)
```

Each `conf/` and `lib/` module also has a `main` block, so you can run one on its
own to see just its slice of the output:

```sh
amber run conf/alias.ab
```

## Build and install

```sh
./build.sh
```

produces `build/index` (the config generator) and `build/bin/*` (the programs).
Everything is compiled with `--target zsh`, so no extra interpreter is needed.

Then in `.zshrc`:

```zsh
eval "$(~/.config/os-conf/extra/amber-impl/build/index)"
```

`oc-regen` is emitted into the config as a convenience — it rebuilds the sources
and re-evaluates them in the current shell.

`OC_MODE=server` and a pre-set `OS_ID` work exactly as they do in the zsh
version; both are read by Amber at generation time.

## Machine-local overrides

`local.ab` is the Amber counterpart of `local.sh` — gitignored, compiled to
`build/bin/local` when present, and `eval`'d last so it can override anything.
Copy `local.example.ab` to get started.

Your existing plain-zsh `local.sh` keeps working too: `index.ab` emits a `source`
for it whenever it exists, so you can use either or both.

## Verified parity

`build/index` was diffed against `index.sh` by loading each into a bare
`zsh -f` and dumping every alias, function name, `$path` entry and exported
variable. In both `OC_MODE=desktop` and `OC_MODE=server` the two are identical,
with one intentional addition: `oc-regen`.

## Behaviour that intentionally differs

Four places where the port does not reproduce a bug:

- **`init_ctp`** ran `mkdir $cwd+'.bin'` with `$cwd` never set, creating a
  directory literally named `+.bin`. `bin/initctp.ab` creates `.bin`, and is
  idempotent instead of erroring on a second run.
- **`killPort`** ran `sudo kill -9 $(...)` unconditionally, so `kill` got an
  empty argument list when nothing was listening. `bin/killport.ab` says so and
  stops, and rejects a non-numeric port.
- **`gitac`** ran `git commit` even when `git add` had failed. `bin/gac.ab` uses
  Amber's `?` operator, so it stops on the first failure and returns git's own
  exit code.
- **`jcode` / `jzed` / `jopen`** cd'd the shell around with `ji` purely to learn
  a path, then cd'd back. `bin/jump.ab` resolves the path instead and the
  wrappers act on it, so the calling shell never moves. Cancelling the picker
  still exits 130, as before.

One thing worth fixing on the zsh side: `src/_alias.sh` defines **`jpwd` twice**
— the first (using `j`) is dead, the second (using `ji`) wins. `conf/alias.ab`
emits only the effective one.

## Amber notes worth knowing before editing

Gathered the hard way while writing this:

- **String escaping.** `{` must be written `\{`; `}` is written plainly (`\}`
  leaves a stray backslash). `"` is `\"`. `$` is literal and needs no escape.
- **Nested strings inside interpolation don't parse.** `"{join(x, \" \")}"`
  is a syntax error — bind it to a `const` first.
- **Command interpolation is not quoted.** `$ printf "%s" {msg} $` word-splits
  the message; write `"{msg}"`. Arrays are expanded bare on purpose, which is
  what `sudo pacman -Rns {packages}` wants.
- **`main(args)` puts the shell name in `args[0]`.** `lib/cli.ab`'s `user_args`
  strips it.
- **Bare `return` is a parse error** in a `Null` function — restructure with
  `if`/`else` or a flag.
- The compiler warns on `let` that is never reassigned; use `const`.
