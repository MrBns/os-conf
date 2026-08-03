#!/usr/bin/env sh
# ---------------------------------------------------------------------------
# Compiles the Amber sources to build/.
#
#   build/index      prints the zsh config; .zshrc evaluates it
#   build/bin/*      the standalone programs the config's wrappers call
#
# Everything is compiled with --target zsh, so the output is zsh rather than
# bash and needs no extra interpreter on this machine.
# ---------------------------------------------------------------------------
set -eu

HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
OUT="$HERE/build"

if ! command -v amber >/dev/null 2>&1; then
  echo "build.sh: amber is not installed - see https://amber-lang.com" >&2
  exit 127
fi

rm -rf "$OUT"
mkdir -p "$OUT/bin"

amber build --target zsh "$HERE/index.ab" "$OUT/index"
chmod +x "$OUT/index"
echo "built build/index"

for src in "$HERE"/bin/*.ab; do
  name=$(basename "$src" .ab)
  amber build --target zsh "$src" "$OUT/bin/$name"
  chmod +x "$OUT/bin/$name"
  echo "built build/bin/$name"
done

# The machine-local override module is optional and gitignored; index.ab only
# emits an eval for it when the compiled result is actually here.
if [ -f "$HERE/local.ab" ]; then
  amber build --target zsh "$HERE/local.ab" "$OUT/bin/local"
  chmod +x "$OUT/bin/local"
  echo "built build/bin/local"
else
  echo "no local.ab - skipping (see local.example.ab)"
fi
