# L4 Computational Law — plugin bundle

> ## ⚠️ Experimental prototype — may be taken down at any time
>
> This repository is an experiment in packaging the L4 authoring skill so it can
> be used **outside** the [l4-ide](https://github.com/legalese/l4-ide) monorepo,
> whose plugin install otherwise resolves to a 289 MB clone to deliver half a
> megabyte of skill.
>
> It has **not been through architectural review**. It is not a supported
> product, it carries no compatibility promise, and it may be **moved, renamed,
> restructured or deleted without notice or deprecation period**. The upstream
> decision about whether the plugin should live in its own repository at all has
> not been taken.
>
> If you depend on anything here, vendor it: take a copy, pin a commit, and do
> not assume this URL resolves next month. The skill itself is stable and lives
> in l4-ide; it is only this *packaging* that is provisional.

**This directory is generated. Do not edit it by hand.** Every file here was
copied out of [legalese/l4-ide](https://github.com/legalese/l4-ide) by
`etc/build-plugin-bundle.mjs`; edits made here are lost on the next build.
Change the skill in l4-ide at `.claude/skills/writing-l4-rules/` and rebuild.

Generated from l4-ide `3cf8f64a1e57`, then **hand-synced on 2026-09-25 to l4-ide
`7b937645548b`** (`unstable` after legalese/l4-ide#490, #478 and #489), because
`etc/build-plugin-bundle.mjs` is not on l4-ide `unstable` and could not be run.
The hand-sync followed this page's own rules: the skill copied whole, every file
its text cites carried at its l4-ide path (the standard library excepted), and
files it no longer cites that have left l4-ide dropped. The next real build
supersedes it.

## What is here, and why

`skills/writing-l4-rules/` is the skill. Everything else is the material the
skill **cites**: it teaches by worked example, naming files like
`jl4/examples/canon/us/regcf/regcf.l4` in its prose rather than restating them.
Those citations are carried at their original repo-relative paths, so each one
resolves against this bundle root exactly as it resolves against the l4-ide
root. Nothing in the skill text was rewritten.

The set is computed from the skill's own text, not from a maintained list, so
citing a new example carries that example on the next build.

One class is deliberately **not** carried: `jl4-core/libraries/*.l4`, the
standard library. The `l4` binary embeds it at compile time and resolves it
under the `jl4-embedded` scheme, so a copy here would be a second copy of
something the runtime already has -- and a second copy that ages past the
user's binary is worse than none, because an `l4` pointed at a prelude newer
than itself does not report a version mismatch; it fails as cascading
`could not find a definition` errors that read as a broken program.

| | |
|---|---|
| skill | 22 files |
| cited material | 51 files |
| cited but NOT carried | 5 standard-library files |
| bundle | 5.09 MB |
| the repo it came from | 289 MB packed |

That last row is the reason this bundle exists: installing the plugin used to
mean cloning the whole monorepo to deliver half a megabyte of skill.
