#!/usr/bin/env bash
# Creates or updates this repository's issue labels with the GitHub CLI.
# The maintainer runs it after changing the list: `.github/labels.sh`.
# Labels that aren't listed here, such as GitHub's defaults, are left alone.
set -euo pipefail

repo=alopex-org/alopex

while IFS='|' read -r name color description; do
  [[ -z $name || $name == '#'* ]] && continue
  gh label create "$name" --repo "$repo" --color "$color" --description "$description" --force
done <<'EOF'
# Who does the work (docs/ROADMAP.md, "How to read this file").
who: code|0e8a16|A change in a pull request; anyone can do it, including a coding agent
who: hands-on|fbca04|Work on a board, a module or a device; the maintainer runs or approves each step
who: maintainer|d93f0b|Contacting companies, agreements, purchases, money and keys; the maintainer only
# What the work touches.
area: requirements|1d76db|What a device must offer
area: boards|1d76db|Development boards and their bring-up
area: cellular|1d76db|Cellular modules and evaluation kits
area: lora|1d76db|The LoRa mesh radio
area: partners|1d76db|ODMs, makers and quotes
area: rules|1d76db|Certification, market and cybersecurity rules
# State and review.
needs: person review|b60205|The recommendation, a decision, or a fusing, flashing, relocking or key procedure
blocked|000000|Waits on a decision, a check or another task
dependencies|0366d6|Dependency updates
EOF
