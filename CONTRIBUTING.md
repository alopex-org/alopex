# Contributing to FoxieOS hardware

FoxieOS hardware is in its research phase.
This repository holds the research and the plan, and later the notes from bench work on boards and modules.
It is separate from the FoxieOS operating system, which has its own repository and rules.

These rules apply to everyone, people and coding agents alike.
Agents also follow [AGENTS.md](AGENTS.md).

## Before you start

- Read [README.md](README.md) and [docs/FEASIBILITY.md](docs/FEASIBILITY.md).
- Install [pre-commit](https://pre-commit.com/#install) and run `pre-commit install` in your clone.
  Every commit is then checked for secrets, key files and private notes ([Keys, secrets and personal details](#keys-secrets-and-personal-details)).
- Pick work from [docs/ROADMAP.md](docs/ROADMAP.md).
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
- Keep one logical change per commit.
- Commit with your GitHub noreply address (`<id>+<login>@users.noreply.github.com`, set with `git config --local user.email`), not a personal address.
- Coding agents add a `Co-Authored-By:` trailer naming themselves.

## Review

Every change is reviewed by someone other than its author.
For research and docs, a review by a different coding agent is enough.

A person must review changes to:

- the recommendation in [docs/FEASIBILITY.md](docs/FEASIBILITY.md#summary);
- the decisions in [docs/ROADMAP.md](docs/ROADMAP.md#decisions) and the key decisions in [docs/DESIGN.md](docs/DESIGN.md#key-decisions);
- any procedure for fusing, flashing, unlocking or relocking hardware, or for handling keys.

`.github/CODEOWNERS` requests these reviews automatically where it can.

In the pull request, list the sources you checked and the commands you ran, with their results: what passed, what failed (with a log excerpt) and what you skipped.

If a change needs a matching change in another FoxieOS repository, such as [foxieos](https://github.com/alopex-org/foxieos), open a pull request there as well, and link each one from the other.

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
