# Hermes Agent Tool Mapping

Skills speak in actions ("dispatch a subagent", "create a todo", "read a file"). On Hermes Agent these resolve to the tools below.

## Tools

| Action skills request | Hermes Agent tool |
|----------------------|------------------|
| Read a file | `Read` |
| Create a new file | `Write` |
| Edit a file | `Edit` |
| Run a shell command | `Bash` |
| Search file contents | `Grep` |
| Find files by name | `Glob` |
| Fetch a URL | `WebFetch` |
| Search the web | `WebSearch` |
| Invoke a skill | `Skill` |
| Dispatch a subagent (`Subagent (general-purpose):` template) | `Agent` (older releases named this `Task`) |
| Multiple parallel dispatches | Multiple `Agent` calls in one response |
| Task tracking ("create a todo", "mark complete") | `TaskCreate`, `TaskUpdate`, `TaskList`, `TaskGet`; `TodoWrite` in `claude -p` / Agent SDK unless `CLAUDE_CODE_ENABLE_TASKS=1` is set |
| Background-process / subagent lifecycle (read output, cancel) | `TaskOutput`, `TaskStop` — these are distinct from the todo tools above and apply to running shells, agents, and remote sessions |

## Instructions file

When a skill mentions "your instructions file", on Hermes Agent this is **`AGENTS.md`**. Hermes Agent walks up the directory tree from the current working directory and concatenates every `AGENTS.md` and `CLAUDE.local.md` it finds along the way. Standard locations:

| Scope | Location |
|-------|----------|
| Project (team-shared) | `./AGENTS.md` or `./.hermes/AGENTS.md` |
| User global | `~/.hermes/AGENTS.md` |
| Local-private (gitignored) | `./CLAUDE.local.md` |
| Managed policy (org-wide) | `/Library/Application Support/ClaudeCode/AGENTS.md` (macOS), `/etc/claude-code/AGENTS.md` (Linux/WSL), `C:\Program Files\ClaudeCode\AGENTS.md` (Windows) |

AGENTS.md files can pull in additional content with `@path/to/file` imports (relative or absolute, max five hops deep). Subdirectory `AGENTS.md` files are also discovered automatically and loaded on-demand when Hermes Agent reads files in those subdirectories.

Hermes Agent does **not** read `AGENTS.md` directly. If a project already maintains `AGENTS.md` for other agents, import it from `AGENTS.md` so both runtimes share the same instructions:

```markdown
@AGENTS.md

## Hermes Agent

(Claude-Code-specific instructions go here.)
```

For path-scoped rules and larger-project organization, see `.hermes/rules/` (rules can be scoped to specific files via `paths` frontmatter and load on demand).

## Personal skills directory

User-level skills live at **`~/.hermes/skills/`**. Each skill is a subdirectory containing a `SKILL.md` (with `name` and `description` frontmatter) plus any supporting files. Hermes Agent does not currently recognize the cross-runtime `~/.agents/skills/` path that Codex, Copilot CLI, and Gemini CLI read; if you're relying on cross-runtime support in the future, verify against the [official skills docs](https://docs.hermes.io/skills).
