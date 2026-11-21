# Contributing to FoxieOS hardware

FoxieOS hardware is in its research phase.
This repository holds the research and the plan, and later the notes from bench work on boards and modules.
It is separate from the FoxieOS operating system, which has its own repository and rules.

These rules apply to everyone, people and coding agents alike.
Agents also follow [AGENTS.md](AGENTS.md).
Everyone in the `alopex-org` organization also follows its [code of conduct][coc], and its [governance][governance] says who decides what.

## Before you start

- Read [README.md](README.md) and [docs/FEASIBILITY.md](docs/FEASIBILITY.md).
- Install [pre-commit](https://pre-commit.com/#install) and run `pre-commit install` in your clone.
  Every commit is then checked for secrets, key files and private notes ([Keys, secrets and personal details](#keys-secrets-and-personal-details)), and for a sign-off ([Sign-off](#sign-off)).
  If you set up your clone before the sign-off hook was added, run `pre-commit install` again.
- Pick work from [docs/ROADMAP.md](docs/ROADMAP.md), or from its [issues](#issues-and-labels).
  Decisions marked open there are the maintainer's to make; ask before building on one.
- Report security problems as described in [SECURITY.md](SECURITY.md), never in a public issue.
- To fix a claim that is wrong or out of date, use the correction issue form, or open a pull request with the new source.

## Branches

Use a fresh branch for each change, named by what it changes:

- `docs/<topic>`, `fix/<topic>`
- `research/<topic>` for new research
- `bench/<board-or-module>` for bench work (roadmap tasks T2 and T3)

## Commits

- Write the subject as `scope: description`, in the imperative, for example `feasibility: add ODM costs from two quotes`.
- Explain *why* in the body.
- Sign off every commit with `git commit -s` ([Sign-off](#sign-off)).
- Keep one logical change per commit.
- Commit with your GitHub noreply address (`<id>+<login>@users.noreply.github.com`, set with `git config --local user.email`), not a personal address.
- Coding agents add a `Co-Authored-By:` trailer naming themselves.

## Sign-off

The project uses the [Developer Certificate of Origin][dco] (DCO) instead of a contributor licence agreement.
By adding a `Signed-off-by:` line to a commit, you certify that you wrote the change or otherwise have the right to submit it under the project's licence.

- `git commit -s` adds the line from your `user.name` and `user.email`.
  It must use the same address as the commit's author, which is your GitHub noreply address ([Commits](#commits)).
- The commit-msg hook in `.pre-commit-config.yaml` refuses a commit without the line.
  The DCO workflow (`.github/workflows/dco.yml`) checks every commit in a pull request, and `main` accepts a pull request only once it passes.
- To fix a branch that lacks the line, run `git rebase --signoff main` and push the branch again with `git push --force-with-lease`.
- The hook also checks the message of a merge commit, so a plain `git merge` or `git pull` that creates one is refused.
  Bring a branch up to date with `git pull --rebase` or `git rebase main` instead; if you need a merge commit, use `git merge --signoff`.
- Commits from bots, such as Dependabot, are exempt.

**Commits written by coding agents.**
The sign-off is a person's statement, so an agent never certifies on its own behalf.
The person who directs the agent and asks it to commit signs those commits off with their own identity, and takes responsibility for them as for their own work.
The agent still names itself in a `Co-Authored-By:` trailer.

## Review

Every change is reviewed by someone other than its author, and a member other than the author approves the pull request on GitHub.
For research and docs, the approving member may have a different coding agent read the change, and answers for the approval as for their own review.

A person must review changes to:

- the recommendation in [docs/FEASIBILITY.md](docs/FEASIBILITY.md#summary);
- any part of [docs/ROADMAP.md](docs/ROADMAP.md) or [docs/DESIGN.md](docs/DESIGN.md), which hold the decisions;
- any procedure for fusing, flashing, unlocking or relocking hardware, or for handling keys.

`.github/CODEOWNERS` requests these reviews automatically where it can, and the ruleset on `main` requires a code owner's approval before a change to those paths is merged.

A ruleset protects `main`:

- every change arrives through a pull request, and no one pushes to `main` directly;
- a member with write access other than the author approves the pull request, and pushing new commits dismisses earlier approvals;
- review threads are resolved before merging;
- the DCO check must pass;
- history stays linear: pull requests are merged by rebasing, so each commit lands on `main` as written, and force pushes and deleting the branch are blocked;
- the maintainer can bypass these rules on a pull request, for example to merge their own change to a code-owned path once another member has approved it.
  Bypasses are recorded in the ruleset's history.

A second ruleset covers tags: only the maintainer creates, moves or deletes a tag, so only the maintainer publishes a release.

In the pull request, list the sources you checked and the commands you ran, with their results: what passed, what failed (with a log excerpt) and what you skipped.

If a change needs a matching change in another FoxieOS repository, such as [foxieos](https://github.com/alopex-org/foxieos), open a pull request there as well, and link each one from the other.

## Issues and labels

- Every decision (D), task (T) and check (C) in [docs/ROADMAP.md](docs/ROADMAP.md) has an issue, and each roadmap phase is a [milestone](https://github.com/alopex-org/foxieos-hardware/milestones).
  The roadmap stays the plan; the issues track status and discussion.
  When an item changes, update the roadmap in a pull request and link the issue.
- Issue types say what an issue is: Decision, Task, Check, Bug or Feature.
- Labels say who does the work (`who:`), what it touches (`area:`) and what it waits on.
  The list lives in `.github/labels.sh`; change it there, not by hand on GitHub.

## Keys, secrets and personal details

- Never commit key material or secrets.
- The pre-commit hooks in `.pre-commit-config.yaml` check every commit:
  - [gitleaks][gitleaks] scans the staged changes for keys, tokens and other secrets;
  - two more hooks block key files (the "Key material" patterns in `.gitignore`) and `*.local.md` notes by name, in case one was added with `git add -f`.
- Don't skip the hooks with `git commit --no-verify` or `SKIP=`.
  If a gitleaks finding is a false positive, say so in the pull request, and add a `gitleaks:allow` comment to the line or the finding's fingerprint to `.gitleaksignore`.
- If the hook stops a commit because of a real secret, take the secret out of the change.
  If a secret ever reached a pushed commit, removing it is not enough: revoke or rotate it, and tell the maintainer.
- Secure-boot and verified-boot keys are handled only by the maintainer.
- Describe machines by their role (build host, bench host).
  Hostnames, addresses, local paths, account details and other personal information stay out of commits, pull requests and issues.
  Keep such notes in a `*.local.md` file, which git ignores.
- Leave out what companies share in confidence: quotes, contract terms, documents under a confidentiality agreement, and the contact details of their staff.
  A summary such as "two ODMs quoted minimum orders of a few thousand units" is fine once the maintainer agrees to it.

[gitleaks]: https://github.com/gitleaks/gitleaks
[coc]: https://github.com/alopex-org/.github/blob/main/CODE_OF_CONDUCT.md
[governance]: https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md
[dco]: https://developercertificate.org/

## Licensing and trademarks

- This repository is under the Apache License 2.0.
- Quote sources sparingly and briefly; summarise them in your own words and link them.
- Use "Android" only as a descriptor ("an operating system based on Android"), together with the line "Android is a trademark of Google LLC."
- Don't use company logos, or suggest that a company named here endorses the project.

## Writing docs

The docs are read by people first, and reviewed as diffs.

- Put each sentence on its own line.
  The rendered page is unchanged, and a diff then shows exactly which sentence changed.
- Write short, plain sentences.
  Explain a technical term the first time a document uses it, or add it to the [terms in FEASIBILITY.md](docs/FEASIBILITY.md#terms).
- Keep table cells short.
  When an entry needs more than a phrase, give it its own section or bullet list.
- Back factual claims with a source: link it in the sentence, or list the sources at the end of the section.
  Give the date each source was checked; prices, products and laws change quickly.
- Mark a claim that is unconfirmed or disputed with ⚠, and add a check to [docs/ROADMAP.md](docs/ROADMAP.md#checks) that would confirm it.
  Check a ⚠ claim before acting on it, then update the doc.
- Mark a statement that rests on general knowledge, with no source checked, as "(unsourced)".
- Give costs as orders of magnitude, and never present an estimate as a quote.
- Label anything not done yet as planned.
- Refer to the project's owner as "the maintainer".
