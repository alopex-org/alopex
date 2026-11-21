# Instructions for coding agents

This file is for AI coding agents working in this repository.
[CONTRIBUTING.md](CONTRIBUTING.md) applies to you as well: branches, commits, review and how to write the docs.

If an `AGENTS.local.md` file exists next to this one, read it too.
Files named `*.local.md` are git-ignored and hold notes for one contributor's setup.
Never copy anything from them into a commit, pull request or issue.

## The project in brief

FoxieOS hardware researches how a small team could build a prototype phone, or a similar device, for an Android-based operating system.
The prototype is for enthusiasts, not a product: the project sells nothing.
It is separate from the FoxieOS operating system and doesn't follow its plan.
It is in the research phase: no hardware is designed, bought or ordered, and the repository holds documents only.

- What the research found, with sources: [docs/FEASIBILITY.md](docs/FEASIBILITY.md)
- Development boards for the bench work, focused on RISC-V: [docs/BOARDS.md](docs/BOARDS.md)
- How a device would come about, and why: [docs/DESIGN.md](docs/DESIGN.md)
- What to do next: [docs/ROADMAP.md](docs/ROADMAP.md)
- How it relates to FoxieOS, which depends on it (not the reverse): [docs/DESIGN.md](docs/DESIGN.md#related-repositories)

Every step in these docs is a plain shell or file step, so any agent can follow it.
Don't add a step that only one agent's own tools can perform.

## Commands

- Build: none yet.
  The bench tasks T2 and T3 add the commands for building Android for a board.
- Checks: the pre-commit hooks in `.pre-commit-config.yaml` (gitleaks, blocks on key files and `*.local.md` notes, and a DCO sign-off on the commit message) run on every commit once `pre-commit install` has been run in the clone ([CONTRIBUTING.md](CONTRIBUTING.md#keys-secrets-and-personal-details)).
  On pull requests, the DCO workflow checks the sign-off again.
  If pre-commit isn't installed or set up in the clone, tell the maintainer rather than committing without the hooks.

## Hard rules

1. **Keys are off-limits.**
   Never generate, read, print, copy, hash, upload or move secure-boot or verified-boot keys.
   Write the procedure; the maintainer handles the keys.
   Bench work uses dev keys that never sign anything published.
2. **No action on hardware without a go-ahead for that action.**
   This covers blowing secure-boot fuses, `fastboot flash`, unlocking and locking a bootloader, erasing or flashing `avb_custom_key`, and wiping a board or device.
   Blown fuses can't be restored, and relocking a device that isn't proven relockable can brick it.
3. **Nothing outward-facing without the maintainer.**
   That includes contacting a company, asking for a quote, signing up for a vendor portal, accepting terms, buying hardware, pushing to any remote and posting anything.
   You may draft messages for the maintainer to send.
4. **Run long jobs in the background.**
   An Android build for a board takes hours.
   Log its output to `logs/<date>-<job>.log`, don't wait on it in the foreground, and report what ran and its exit status.
5. **Check ⚠ claims before building on them**, then update the doc where you found the claim and the check in [docs/ROADMAP.md](docs/ROADMAP.md#checks).
6. **Report honestly.**
   List the sources you checked, the claims you couldn't confirm, the commands you ran with their results, and anything you skipped.
7. **Keep private and confidential details out of the repository.**
   Describe machines by their role, never by name, address, hardware inventory or local path.
   Leave out terms a company gave in confidence and the contact details of people at companies ([CONTRIBUTING.md](CONTRIBUTING.md#keys-secrets-and-personal-details)).

## Stop and ask when…

- a roadmap decision (D1–D4) is needed and not yet recorded;
- a finding would change the recommendation in [docs/FEASIBILITY.md](docs/FEASIBILITY.md#summary);
- a step would spend money, contact a company, accept terms or create an account;
- a step would fuse, flash, unlock, lock or wipe a board or device;
- a ⚠ step behaves differently from the docs (report what happened, and don't improvise on device-level steps);
- a change here needs a matching change in another FoxieOS repository, such as `foxieos`: propose one pull request in each, linking the other.
  FoxieOS depends on this project, not the reverse, so don't change anything here only to suit FoxieOS.

## Sign-off

Commit with `git commit -s` only when the person directing you asked for the commit: the sign-off is theirs, in their name ([CONTRIBUTING.md](CONTRIBUTING.md#sign-off)).
Never add a `Signed-off-by:` line for yourself or for anyone who didn't ask for the commit.
Add your own `Co-Authored-By:` trailer as well.

## Don't

- Commit `keys/`, `*.pk8`, `*.pem`, `*.key`, `avb*.bin`, `out/` or `logs/`; `.gitignore` already excludes them.
- Skip the pre-commit hooks with `git commit --no-verify` or `SKIP=`.
  Report a finding you think is a false positive instead.
- Present an estimate as a quote, or a secondary report as confirmed.
- Put an Android source tree, build output or a vendor document under a confidentiality agreement inside this repository.
