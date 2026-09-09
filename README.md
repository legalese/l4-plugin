# L4 Computational Law — plugin bundle

**This directory is generated. Do not edit it by hand.** Every file here was
copied out of [legalese/l4-ide](https://github.com/legalese/l4-ide) by
`etc/build-plugin-bundle.mjs`; edits made here are lost on the next build.
Change the skill in l4-ide at `.claude/skills/writing-l4-rules/` and rebuild.

Generated from l4-ide `7d661166ba1b`.

## What is here, and why

`skills/writing-l4-rules/` is the skill. Everything else is the material the
skill **cites**: it teaches by worked example, naming files like
`jl4/examples/legal/regcf/regcf.l4` in its prose rather than restating them.
Those citations are carried at their original repo-relative paths, so each one
resolves against this bundle root exactly as it resolves against the l4-ide
root. Nothing in the skill text was rewritten.

The set is computed from the skill's own text, not from a maintained list, so
citing a new example carries that example on the next build.

| | |
|---|---|
| skill | 22 files |
| cited material | 49 files |
| bundle | 4.82 MB |
| the repo it came from | 289 MB packed |

That last row is the reason this bundle exists: installing the plugin used to
mean cloning the whole monorepo to deliver half a megabyte of skill.
