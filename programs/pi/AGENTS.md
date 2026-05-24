# System-specific info

This is NixOS with fully declarative configuration living in `$NIXOS_HOME`.
Do not try to install anything non-declaratively.

## Pi configuration

All pi configuration is stored in `$NIXOS_HOME/programs/pi` (for example, this AGENTS.md source is `$NIXOS_HOME/programs/pi/AGENTS.md`).

## Extensions

Extensions are TypeScript modules in `$NIXOS_HOME/programs/pi/extensions/`.
They are symlinked to `~/.pi/agent/extensions/`

## Skills

Skills are self-contained capability packages in `$NIXOS_HOME/programs/pi/skills/`.
They are symlinked to `~/.pi/agent/skills/`
Each skill has a `SKILL.md` with frontmatter and instructions, plus optional `scripts/` and `references/`.

## Modifying config

If you need to modify pi or NixOS config:
1. Plan changes and ask user for approval
2. Once user approves, apply changes
3. Run `just switch` from `$NIXOS_HOME`
