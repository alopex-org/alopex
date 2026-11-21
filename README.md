# Alopex

Research into how a small team could build a prototype phone, or a similar device, for an Android-based operating system.
Whether it stays with a prototype or aims at a product is open: the maintainers decide it at their founding meeting on 2026-11-24 (roadmap decision D5).

**Status: research.**
No hardware is designed, bought or ordered.
This repository holds the research and the plan.
Its decisions are the maintainers', who are chosen at the founding meeting ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).

## What this project will be

- A study of the ways to get a device made: with an existing phone maker, through a contract manufacturer, or as a design of the project's own around a cellular module.
- Then cheap bench work: an Android build on a development board, then on a cellular module's evaluation kit.
- Later, if the maintainers decide so, a prototype device built in small numbers, and possibly a product after it (decision D5).

A LoRa radio for off-grid mesh messaging, over Meshtastic, MeshCore or a similar network, is planned as a core part of the device ([docs/LORA.md](docs/LORA.md)).

It will not follow the plan of the FoxieOS operating system.
[docs/DESIGN.md](docs/DESIGN.md) explains why.

## The findings in brief

- A phone designed from the chip up is out of reach for a small team.
- Whoever sells a device becomes its manufacturer, with radio certification, patent licences and the EU's duty to supply updates and spare parts for years.
  A prototype that isn't sold stays clear of most of that ⚠ (roadmap check C12).
- A partnership with a phone maker and a phone made by a contract manufacturer are routes to a product; decision D5 settles whether the project pursues one.
  For a prototype, a design around a cellular module, after bench work on a development board, is the route that fits.
- No phone has a LoRa mesh radio on its own board yet; the ones sold attach a node over Bluetooth, so built-in LoRa would set the device apart.
- The first steps are cheap: a list of hardware requirements, then bench work on a development board and a module kit.

## Where to start

1. [docs/FEASIBILITY.md](docs/FEASIBILITY.md): the research: the routes to a device, the software work, the rules, earlier phone projects and the risks, with sources.
2. [docs/ROADMAP.md](docs/ROADMAP.md): open decisions and the next task.
3. [docs/DESIGN.md](docs/DESIGN.md): the case for a prototype and for a product (decision D5), how a device would come about, who holds which keys, and why the project is set up this way.
4. [docs/BOARDS.md](docs/BOARDS.md): the development boards for the bench work, focused on RISC-V and compared with Arm boards, with a proposed choice.
5. [docs/LORA.md](docs/LORA.md): the LoRa mesh radio: Meshtastic, MeshCore and Reticulum, how to build the radio in, and its certification.

## Repository layout

- `docs/`: the documents listed above.
- `.github/`: code owners, issue forms, the pull-request template, the DCO workflow, the Dependabot configuration and the label list (`labels.sh`).
- `.pre-commit-config.yaml`: the checks that run on every commit ([CONTRIBUTING.md](CONTRIBUTING.md#before-you-start)).

The requirements and bench notes join `docs/` as the roadmap tasks are done.
Android source trees and build output are kept outside this repository.

## Relation to FoxieOS

This project is separate from the [FoxieOS](https://github.com/alopex-org/foxieos) operating system, and doesn't follow its plan or device criteria.
FoxieOS depends on this project for a custom device, and the dependency runs one way: this project doesn't depend on FoxieOS, and FoxieOS adapts to its choices.
FoxieOS decides whether to support a device from this project, and on what terms, in its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
Ask questions on the [Alopex Discord](https://discord.gg/REPLACE_WITH_INVITE); issues and pull requests remain the record.
AI coding agents also follow [AGENTS.md](AGENTS.md).
Report security problems as described in [SECURITY.md](SECURITY.md), not in public issues.

## License

Apache License 2.0; see [LICENSE](LICENSE).
The license grants no rights to the FoxieOS name or logo.

Android is a trademark of Google LLC.
This project is not affiliated with Google, the LineageOS project or any company named in these documents.
