# Contributing to FoxieOS hardware

Thank you for helping.
This page explains how to suggest a change and the rules every change follows.
GitHub words such as branch, commit and pull request are explained in the [organization's glossary][glossary].

The project is still doing research.
This repository holds the research and the plan, and later the notes from bench work on boards and modules.
It is separate from the FoxieOS operating system, which has its own repository and rules.

Everyone in the `alopex-org` organization follows its [code of conduct][coc], and its [governance][governance] says who decides what.
If you use an AI coding agent, you are responsible for its work as for your own; the agent's own rules are in [AGENTS.md](AGENTS.md).

## In short

1. Read [README.md](README.md) and [docs/FEASIBILITY.md](docs/FEASIBILITY.md).
2. Pick something from [docs/ROADMAP.md](docs/ROADMAP.md) or its issues, or open an issue about what you want to change.
3. Fork the repository (until the founding meeting, members work from forks), then make a new branch for your change.
4. Make the change, with a source for every fact, and commit it with a sign-off (`git commit -s`).
5. Open a pull request and say what you changed, why, which sources you checked, and what you ran.
6. Someone else reviews it; answer their comments.
7. The maintainer merges it.

The sections below explain each rule.

## Before you start

- **Install the checks.**
  Install [pre-commit](https://pre-commit.com/#install), then run `pre-commit install` in your clone.
  From then on, every commit is checked for secrets, key files and private notes ([Keys, secrets and personal details](#keys-secrets-and-personal-details)), and for a sign-off ([Sign-off](#sign-off)).
  If you set up your clone before the sign-off check was added, run `pre-commit install` again.
- **Choose the work.**
  Pick work from [docs/ROADMAP.md](docs/ROADMAP.md), or from its [issues](#issues-and-labels).
  Decisions marked open there are the maintainers' to make, so ask before building on one.
- **Talk it over.**
  Members ask questions and discuss the work on the Alopex Discord, which has no public invite for now.
  Discord is for conversation, not for keeping a record.
  Put anything that should be kept, such as a correction, a source or an argument for a decision, in an issue or a pull request.
- **Security problems** go through [SECURITY.md](SECURITY.md), never a public issue.
  Don't post them, or code-of-conduct reports, on Discord either.
- **Something wrong or out of date?**
  Use the correction issue form, or open a pull request with the new source.

## Branches

Until the founding meeting on 2026-11-24 ([governance][governance]), members can read this repository but not change it directly, like everyone else.
Put your branch in your own fork and open the pull request from there.

Use a new branch for each change, named after what it changes:

- `docs/<topic>` for the docs, `fix/<topic>` for a fix;
- `research/<topic>` for new research;
- `bench/<board-or-module>` for bench work (roadmap tasks T2 and T3).

## Commits

- **Subject line:** write `scope: description`, as a command, for example `feasibility: add ODM costs from two quotes`.
  The scope is the part of the project the change touches.
- **Body:** explain *why* you made the change.
- **Sign-off:** sign off every commit with `git commit -s` ([Sign-off](#sign-off)).
- **One change per commit:** keep each commit to one logical change.
- **Email address:** commit with your GitHub noreply address (`<id>+<login>@users.noreply.github.com`, set with `git config --local user.email`), not a personal address.

## Sign-off

The project uses the [Developer Certificate of Origin][dco] (DCO) instead of a contributor licence agreement.
By adding a `Signed-off-by:` line to a commit, you state that you wrote the change, or otherwise have the right to submit it, under the project's licence.

- `git commit -s` adds the line from your `user.name` and `user.email`.
  It must use the same address as the commit's author, which is your GitHub noreply address ([Commits](#commits)).
- The commit check in `.pre-commit-config.yaml` refuses a commit without the line.
  On GitHub, the DCO workflow (`.github/workflows/dco.yml`) checks every commit in a pull request, and `main` accepts a pull request only once it passes.
- **Forgot the sign-off?**
  Run `git rebase --signoff main`, then push the branch again with `git push --force-with-lease`.
- **Updating your branch:** the check also covers merge commits, so a plain `git merge`, or a `git pull` that creates a merge commit, is refused.
  Bring a branch up to date with `git pull --rebase` or `git rebase main` instead.
  If you really need a merge commit, use `git merge --signoff`.
- Commits from bots, such as Dependabot, don't need a sign-off.

The sign-off is a person's statement.
If an AI coding agent writes a commit for you, you sign it off with your own name, and you take responsibility for it as for your own work.

## Review

Someone other than the author reviews every change.

- **Until the founding meeting** on 2026-11-24 ([governance][governance]), only the interim maintainer's approval lets a pull request merge.
  `.github/CODEOWNERS` names them as the owner of every file.
- **Members still review** each other's changes and the maintainer's own, and their comments are answered before merging.
  A member's approval doesn't count toward merging while members only have read access, but GitHub still records it on the pull request.
- **Research and docs** may be reviewed by the reviewer with the help of a coding agent; the reviewer answers for that review as for their own.

A person must read every change to:

- the recommendation in [docs/FEASIBILITY.md](docs/FEASIBILITY.md#summary);
- any part of [docs/ROADMAP.md](docs/ROADMAP.md) or [docs/DESIGN.md](docs/DESIGN.md), which hold the decisions;
- any procedure for fusing, flashing, unlocking or relocking hardware, or for handling keys, because a mistake there can't be undone.

`.github/CODEOWNERS` asks for these reviews automatically where it can, and the rules on `main` require a code owner's approval before such a change merges.

These rules, called a ruleset, protect `main`:

- every change arrives through a pull request; nobody pushes to `main` directly;
- someone with write access, other than the author, approves the pull request (until the founding meeting, only the interim maintainer has write access);
- pushing new commits cancels earlier approvals;
- every review comment thread is resolved before merging;
- the DCO check passes;
- the history stays one straight line: pull requests are merged by rebasing, so each commit lands on `main` as written, and rewriting or deleting `main` is blocked;
- the maintainer can override these rules on a pull request, for example to merge their own change, which no other code owner can approve, once another member has approved it.
  Every override is recorded in the ruleset's history.

A second ruleset covers tags: only the maintainer creates, moves or deletes a tag, so only the maintainer publishes a release.

In the pull request, list the sources you checked and the commands you ran, and what happened: what passed, what failed (with a short excerpt of the output) and what you skipped.

**Changes that touch another repository.**
If a change needs a matching change in another FoxieOS repository, such as [foxieos](https://github.com/alopex-org/foxieos), open a pull request there as well, and link each one from the other.
FoxieOS depends on this project, not the other way round.
A change here can need a matching change in FoxieOS, but a change in FoxieOS never asks this project to adapt.

## Issues and labels

- **Every roadmap item has an issue.**
  Every decision (D), task (T) and check (C) in [docs/ROADMAP.md](docs/ROADMAP.md) has one, and each roadmap phase is a [milestone](https://github.com/alopex-org/foxieos-hardware/milestones).
  The roadmap stays the plan; the issues track progress and discussion.
  When an item changes, update the roadmap in a pull request and link the issue.
- **Issue types** say what an issue is: Decision, Task, Check, Bug or Feature.
- **Labels** say who does the work (`who:`), what it touches (`area:`) and what it is waiting for.
  The list lives in `.github/labels.sh`; change it there, not by hand on GitHub.
- Until the founding meeting, only the maintainer sets labels, types and milestones.
  Suggest them in a comment.

## Keys, secrets and personal details

- **Never commit keys or secrets**, such as passwords, tokens or signing keys.
- **The pre-commit checks** in `.pre-commit-config.yaml` look at every commit:
  - [gitleaks][gitleaks] scans your changes for keys, tokens and other secrets;
  - two more checks block key files (the "Key material" patterns in `.gitignore`) and private `*.local.md` notes by name, in case one was added with `git add -f`.
- **Don't skip the checks** with `git commit --no-verify` or `SKIP=`.
  If gitleaks flags something that isn't a secret, say so in the pull request, and add a `gitleaks:allow` comment to the line, or the finding's fingerprint to `.gitleaksignore`.
- **If a check stops a real secret,** take the secret out of the change.
  If a secret ever reached GitHub, deleting it isn't enough: cancel or replace it, and tell the maintainer.
- **Secure-boot and verified-boot keys** are handled only by the maintainer.
- **Describe computers by their role** (build host, bench host).
  Computer names, addresses, folder paths on your computer, account details and other personal information stay out of commits, pull requests and issues.
  Keep such notes in a `*.local.md` file, which git ignores.
- **Leave out what companies tell you in confidence:** quotes, contract terms, documents under a confidentiality agreement, and the contact details of their staff.
  A summary such as "two ODMs quoted minimum orders of a few thousand units" is fine once the maintainer agrees to it.

[gitleaks]: https://github.com/gitleaks/gitleaks
[coc]: https://github.com/alopex-org/.github/blob/main/CODE_OF_CONDUCT.md
[governance]: https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md
[glossary]: https://github.com/alopex-org/.github/blob/main/GLOSSARY.md
[dco]: https://developercertificate.org/

## Licensing and trademarks

- This repository is under the Apache License 2.0.
- Quote sources rarely and briefly; summarise them in your own words and link them.
- Use "Android" only to describe something ("an operating system based on Android"), together with the line "Android is a trademark of Google LLC."
- Don't use company logos, or suggest that a company named here supports the project.

## Writing docs

The docs are read by people first, many of them not technical, and reviewed as changes line by line.

- **Write for a reader who isn't technical.**
  Use short sentences and everyday words.
  Say what something means for the project before the technical detail.
- **Explain technical words** the first time a page uses them, or link to the [glossary](docs/GLOSSARY.md); add new words to the glossary.
- **Name the roadmap codes.**
  Write "decision D5 (prototype or product)", not just "D5", the first time a section uses a code.
- **One sentence per line.**
  The page on GitHub looks the same, and a change then shows exactly which sentence changed.
- **Keep table cells short.**
  When an entry needs more than a phrase, give it its own section or bullet list.
- **Back facts with a source:** link it in the sentence, or list the sources at the end of the section.
  Give the date each source was checked; prices, products and laws change quickly.
- **Mark doubt.**
  Mark a claim that isn't confirmed, or that sources disagree on, with ⚠, and add a check to [docs/ROADMAP.md](docs/ROADMAP.md#checks) that would confirm it.
  Check a ⚠ claim before acting on it, then update the doc.
  Mark a statement from general knowledge, with no source checked, as "(unsourced)".
- **Give costs as rough sizes** ("tens of thousands"), and never present an estimate as a quote.
- **Label anything not done yet as planned.**
- **Call the project's owner "the maintainer".**
- **Keep instructions for coding agents in [AGENTS.md](AGENTS.md),** not in the docs people read.
