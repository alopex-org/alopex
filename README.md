# Alopex

Alopex is the hardware project of the Alopex student organization, in the `alopex` repository.
It designs a cyber-deck: a rugged, hand-held computer with a slide-out keyboard and a LoRa radio for messaging without a mobile network.
Whether the project stops at a prototype or aims at a product it sells is open: the maintainers decide it at their founding meeting on 2026-11-24 (roadmap decision D5).

**Status: research.**
No hardware is designed, bought or ordered.
This repository holds the research and the plan.
The project set out to build a phone for an Android-based system; the proposal in these docs turns it to a cyber-deck running Linux.
Its decisions belong to the maintainers, who are chosen at the founding meeting and confirm or change that direction ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).

Unfamiliar words are explained in two glossaries: [hardware, radios and rules](docs/GLOSSARY.md), and [GitHub and how we work](https://github.com/alopex-org/.github/blob/main/GLOSSARY.md).

## What this project will be

- **A cyber-deck prototype** ([docs/CYBERDECK.md](docs/CYBERDECK.md)), proposed from a set of concept renders:
  - an upright touchscreen that slides sideways to uncover a physical keyboard;
  - a LoRa mesh radio with a telescopic antenna, and two gauges that show the signal received;
  - knobs on the sides, and hardware switches that cut the radios and the microphone;
  - two 18650 batteries at the back, swapped one at a time while it runs;
  - Wi-Fi only, with the main board still to choose: a Raspberry Pi compute module, another single-board computer or module, or something else (decision D1).
- **First, cheap bench work:** candidate boards tried side by side, the electronics wired up on the bench, and the case and sliding screen as a mock-up.
- **Later, if the maintainers decide so,** a few devices built by hand, and possibly a product after it (decision D5).

The cyber-deck runs [FoxieOS](https://github.com/alopex-org/foxieos), a Linux system for it (decision D6).
The project doesn't follow FoxieOS's plan; [docs/DESIGN.md](docs/DESIGN.md) explains why.

## The findings in brief

- A cyber-deck built from a ready-made board or compute module, ready-made radio boards and a case of the project's own is within a small team's reach; hobbyists and small companies already make similar devices ([docs/CYBERDECK.md](docs/CYBERDECK.md#cyber-decks-that-already-exist)).
- None of the cyber-decks compared has a screen that slides over its keyboard, hardware switches for its radios, or batteries swapped while it runs; with the signal gauges, those would set this one apart.
- A Wi-Fi-only device needs no cellular module, no approval from mobile networks and no mobile-network patent licences.
- Whoever sells a device becomes its manufacturer, with radio certification and EU duties for years.
  A prototype that isn't sold stays clear of most of that ⚠ (roadmap check C12).
- The research into phones, which this project started with, stays in [docs/FEASIBILITY.md](docs/FEASIBILITY.md): it applies if a later device adds a mobile network (decision D2).

## Where to start

1. [docs/CYBERDECK.md](docs/CYBERDECK.md): the proposed cyber-deck: its design, its parts, the cyber-decks that already exist, and what it costs the user.
2. [docs/ROADMAP.md](docs/ROADMAP.md): the open decisions and the next piece of work.
3. [docs/DESIGN.md](docs/DESIGN.md): the case for a prototype and for a product (decision D5), who holds which keys, and why the project is set up this way.
4. [docs/LORA.md](docs/LORA.md): the LoRa mesh radio: the Meshtastic, MeshCore and Reticulum networks, how to build the radio in, and its band rules.
5. [docs/BOARDS.md](docs/BOARDS.md): the candidate boards for the cyber-deck's main board, Arm and RISC-V, with their Linux and secure-boot support.
6. [docs/FEASIBILITY.md](docs/FEASIBILITY.md): the research, with sources: the routes to a device, the rules, earlier phone projects and the risks.

## What's in this repository

- `docs/`: the documents listed above, and the [glossary](docs/GLOSSARY.md).
- `.github/`: GitHub settings: who reviews what, issue forms, the pull-request template, the automatic sign-off check, Dependabot, and the list of labels (`labels.sh`).
- `.pre-commit-config.yaml`: the checks that run on your computer before every commit ([CONTRIBUTING.md](CONTRIBUTING.md#before-you-start)).

The requirements, the notes from bench work and, later, the design files will join this repository as the roadmap's tasks are done.

## Relation to FoxieOS

[FoxieOS](https://github.com/alopex-org/foxieos) is the operating system planned for the cyber-deck.
It is a separate project, and this project doesn't follow its plan or its rules.
FoxieOS depends on this project, and only in that direction: this project doesn't depend on FoxieOS, and FoxieOS adapts to its choices.
FoxieOS sets the terms on which it supports a device from here in its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
Members talk the work over on the Alopex Discord, which has no public invite for now; issues and pull requests remain the record.
Report security problems as [SECURITY.md](SECURITY.md) describes, never in a public issue.
AI coding agents also follow [AGENTS.md](AGENTS.md).

## License

Apache License 2.0; see [LICENSE](LICENSE).
The license gives no rights to the Alopex or FoxieOS names or logos.

Raspberry Pi is a trademark of Raspberry Pi Ltd.
This project is not affiliated with Raspberry Pi Ltd, the Meshtastic project or any company named in these documents.
