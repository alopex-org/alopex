# Alopex

Alopex is the hardware project of the Alopex student organization, in the `alopex` repository.
It researches how a small team could build its own phone, or a similar device, for an operating system based on Android.
Whether the project stops at a prototype or aims at a product it sells is open: the maintainers decide it at their founding meeting on 2026-11-24 (roadmap decision D5).

**Status: research.**
No hardware is designed, bought or ordered.
This repository holds the research and the plan.
Its decisions belong to the maintainers, who are chosen at the founding meeting ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).

Unfamiliar words are explained in two glossaries: [hardware, radios and rules](docs/GLOSSARY.md), and [GitHub and how we work](https://github.com/alopex-org/.github/blob/main/GLOSSARY.md).

## What this project will be

- **First, a study** of the ways to get a device made: with an existing phone maker, through a factory that builds phones for other brands, or as a design of the project's own around a ready-made cellular module.
- **Then cheap bench work:** getting Android running on a development board, then on a cellular module's evaluation kit.
- **Later, if the maintainers decide so,** a prototype device built in small numbers, and possibly a product after it (decision D5).

A LoRa radio, for sending messages without a mobile network over Meshtastic, MeshCore or a similar mesh network, is planned as a core part of the device ([docs/LORA.md](docs/LORA.md)).

The project won't follow the plan of the FoxieOS operating system.
[docs/DESIGN.md](docs/DESIGN.md) explains why.

## The findings in brief

- A phone designed from the chip up is out of reach for a small team.
- Whoever sells a device becomes its manufacturer, with radio certification, patent licences and the EU's duty to supply updates and spare parts for years.
  A prototype that isn't sold stays clear of most of that ⚠ (roadmap check C12).
- Working with an existing phone maker, or having a factory build a phone, are routes to a product; decision D5 settles whether the project pursues one.
  For a prototype, the route that fits is a design around a cellular module, after bench work on a development board.
- No phone has a LoRa mesh radio on its own circuit board yet; the ones on sale attach a separate radio over Bluetooth, so a built-in one would set the device apart.
- The first steps cost little: a list of hardware requirements, then bench work on a development board and a module kit.

## Where to start

1. [docs/FEASIBILITY.md](docs/FEASIBILITY.md): the research, with sources: the routes to a device, the software work, the rules, earlier phone projects and the risks.
2. [docs/ROADMAP.md](docs/ROADMAP.md): the open decisions and the next piece of work.
3. [docs/DESIGN.md](docs/DESIGN.md): the case for a prototype and for a product (decision D5), how a device would come about, who holds which keys, and why the project is set up this way.
4. [docs/BOARDS.md](docs/BOARDS.md): the development boards for the bench work, mainly RISC-V boards compared with Arm boards, with a proposed choice.
5. [docs/LORA.md](docs/LORA.md): the LoRa mesh radio: the Meshtastic, MeshCore and Reticulum networks, how to build the radio in, and its certification.

## What's in this repository

- `docs/`: the documents listed above, and the [glossary](docs/GLOSSARY.md).
- `.github/`: GitHub settings: who reviews what, issue forms, the pull-request template, the automatic sign-off check, Dependabot, and the list of labels (`labels.sh`).
- `.pre-commit-config.yaml`: the checks that run on your computer before every commit ([CONTRIBUTING.md](CONTRIBUTING.md#before-you-start)).

The requirements and the notes from bench work will join `docs/` as the roadmap's tasks are done.
Android source code and build output are kept outside this repository.

## Relation to FoxieOS

This project is separate from the [FoxieOS](https://github.com/alopex-org/foxieos) operating system, and doesn't follow its plan or its rules for choosing phones.
FoxieOS depends on this project for a device of its own, and only in that direction: this project doesn't depend on FoxieOS, and FoxieOS adapts to its choices.
FoxieOS decides whether to support a device from this project, and on what terms, in its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
Members talk the work over on the Alopex Discord, which has no public invite for now; issues and pull requests remain the record.
Report security problems as [SECURITY.md](SECURITY.md) describes, never in a public issue.
AI coding agents also follow [AGENTS.md](AGENTS.md).

## License

Apache License 2.0; see [LICENSE](LICENSE).
The license gives no rights to the FoxieOS name or logo.

Android is a trademark of Google LLC.
This project is not affiliated with Google, the LineageOS project or any company named in these documents.
