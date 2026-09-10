#!/usr/bin/env bash
# Install the l4 CLI and jl4-lsp for this plugin's skill.
#
# GENERATED. The release tag and the digests below were embedded when this
# bundle was built, so they travel with a bundle you can inspect rather than
# being fetched from the same host as the download at the same moment.
#
# Installs to ~/.local/lib/l4-<tag>/ and links ~/.local/bin/{l4,jl4-lsp}.
set -euo pipefail

TAG="unstable-20260907-9d6536a"
REPO="legalese/prereleases"
SHA_darwin_arm64="408fa6494ab786c841d1008caa7d86ad70df86910ed1a47972764e37ca399a5a"
SHA_linux_x64="cc6895c765c57fb7c218311e95ad66781e86e88a5694b7b7b4fa40f5446a8226"
SHA_win32_x64="403c6667c9e7f7578fb4cad32e955f411b224c8809e804e5b3ca480fd1aff2df"

os="$(uname -s)"; arch="$(uname -m)"
case "$os/$arch" in
  Darwin/arm64)        plat="darwin-arm64"; sha="$SHA_darwin_arm64" ;;
  Linux/x86_64|Linux/amd64) plat="linux-x64"; sha="$SHA_linux_x64" ;;
  *)
    echo "No prebuilt l4 for $os/$arch." >&2
    echo "Windows x64 builds are published at:" >&2
    echo "  https://github.com/$REPO/releases/tag/$TAG" >&2
    echo "Otherwise build from source: https://github.com/legalese/l4-ide" >&2
    exit 1 ;;
esac

ARCHIVE="l4-$TAG-$plat.tar.gz"
URL="https://github.com/$REPO/releases/download/$TAG/$ARCHIVE"
PREFIX="${L4_PREFIX:-$HOME/.local}"
LIBDIR="$PREFIX/lib/l4-$TAG"
BINDIR="$PREFIX/bin"

if [ -x "$LIBDIR/l4" ]; then
  echo "Already installed: $LIBDIR/l4"
else
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  echo "Downloading $ARCHIVE ..."
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL --retry 3 -o "$tmp/$ARCHIVE" "$URL"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$tmp/$ARCHIVE" "$URL"
  else
    echo "Need curl or wget to download the archive." >&2; exit 1
  fi

  # Verify BEFORE unpacking. An archive is unpacked by code that trusts it.
  echo "Verifying ..."
  if command -v sha256sum >/dev/null 2>&1; then
    got="$(sha256sum "$tmp/$ARCHIVE" | cut -d' ' -f1)"
  elif command -v shasum >/dev/null 2>&1; then
    got="$(shasum -a 256 "$tmp/$ARCHIVE" | cut -d' ' -f1)"
  else
    echo "Need sha256sum or shasum to verify the download; refusing to install unverified." >&2
    exit 1
  fi
  if [ "$got" != "$sha" ]; then
    echo "CHECKSUM MISMATCH -- refusing to install." >&2
    echo "  expected $sha" >&2
    echo "  got      $got" >&2
    echo "This means the archive is not the one this bundle was built against." >&2
    exit 1
  fi

  mkdir -p "$LIBDIR"
  tar -xzf "$tmp/$ARCHIVE" -C "$tmp"
  # The archive unpacks to a single directory named for the build; move its
  # contents up so the layout here does not depend on that name.
  src="$tmp/l4-$TAG-$plat"
  [ -d "$src" ] || { echo "Unexpected archive layout: $src is missing." >&2; exit 1; }
  cp -R "$src/." "$LIBDIR/"
  chmod +x "$LIBDIR/l4" "$LIBDIR/jl4-lsp" 2>/dev/null || true
fi

mkdir -p "$BINDIR"
ln -sf "$LIBDIR/l4" "$BINDIR/l4"
ln -sf "$LIBDIR/jl4-lsp" "$BINDIR/jl4-lsp"

echo
echo "Installed:"
echo "  $BINDIR/l4"
echo "  $BINDIR/jl4-lsp   (language server: diagnostics and hovers)"
echo
# The standard library ships INSIDE the archive, beside the binary, and is also
# compiled into it. Both are version-matched to this binary by construction,
# which is why this bundle deliberately carries no copy of its own: an l4 aimed
# at a prelude newer than itself does not report a version mismatch, it fails as
# cascading "could not find a definition" errors that read as a broken program.
echo "The standard library is version-matched inside the install; do not set"
echo "JL4_LIBRARY_PATH at anything else."
case ":$PATH:" in
  *":$BINDIR:"*) ;;
  *) echo; echo "NOTE: $BINDIR is not on your PATH." ;;
esac
