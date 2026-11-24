# Alopex

Alopex is the hardware project of the Alopex student organization, in the `alopex` repository.
It works toward a cyber-deck: a portable computer of the project's own ([docs/CYBERDECK.md](docs/CYBERDECK.md)).
Its primary purpose is to be **user-serviceable**: its owner can open it, repair it and replace its parts.
It has LoRa, for messaging without a mobile network ([docs/LORA.md](docs/LORA.md)), and Wi-Fi; it is meant to be pocket-sized if possible, and runs a Linux distribution for now.
Its main board, screen and controls, power, case and other radios are undecided.
The members confirmed the move to a cyber-deck at their founding meeting on 2026-11-24; the project started out researching a phone for an operating system based on Android, and that research stays as background.
The meeting also decided that the project builds a prototype first, then a product it sells (roadmap decision D5).

**Status: research.**
No hardware is designed, bought or ordered.
This repository holds the research and the plan.
Its decisions belong to the maintainers, whom the members chose at the founding meeting ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#the-founding-meeting)).

Unfamiliar words are explained in two glossaries: [hardware, radios and rules](docs/GLOSSARY.md), and [GitHub and how we work](https://github.com/alopex-org/.github/blob/main/GLOSSARY.md).

## What this project will be

- **First, the requirements:** what being user-serviceable and pocket-sized means in practice, and what else the cyber-deck must have (roadmap task T1).
- **Then cheap bench work:** trying candidate hardware on development boards.
- **Then a prototype** built in small numbers, and a product after it, once the prototype proves the design (decision D5).

A LoRa radio, for sending messages without a mobile network over Meshtastic, MeshCore or a similar mesh network, is a core part of the device (decided 2026-11-21; [docs/LORA.md](docs/LORA.md)).

Earlier work also proposed a Raspberry Pi handheld ([docs/HANDHELD.md](docs/HANDHELD.md)); it is larger than pocket-sized, and is one option to learn from.

The project won't follow the plan of the FoxieOS operating system.
[docs/DESIGN.md](docs/DESIGN.md) explains why.

## The earlier findings in brief

From the research into a phone; they apply to the cyber-deck wherever it would share a part, a route or a rule with a phone.

- A phone designed from the chip up is out of reach for a small team.
- Whoever sells a device becomes its manufacturer, with radio certification, patent licences and the EU's duty to supply updates and spare parts for years.
  A prototype that isn't sold stays clear of most of that ⚠ (roadmap check C12).
- Working with an existing phone maker, or having a factory build a phone, are routes to a product; decision D5 puts a product after the prototype.
  For a prototype, the route that fits is a design around a cellular module, after bench work on a development board.
- No phone has a LoRa mesh radio on its own circuit board yet; the ones on sale attach a separate radio over Bluetooth, so a built-in one would set the device apart.
- The first steps cost little: a list of hardware requirements, then bench work on a development board and a module kit.

## Where to start

1. [docs/CYBERDECK.md](docs/CYBERDECK.md): what a cyber-deck is, the ones that already exist, and what is undecided about this one.
2. [docs/FEASIBILITY.md](docs/FEASIBILITY.md): the earlier research, with sources: the routes to a device, the software work, the rules, earlier phone projects and the risks.
3. [docs/ROADMAP.md](docs/ROADMAP.md): the open decisions and the next piece of work.
4. [docs/DESIGN.md](docs/DESIGN.md): the case for a prototype and for a product (decision D5), how a device would come about, who holds which keys, and why the project is set up this way.
5. [docs/SHORTLIST.md](docs/SHORTLIST.md): the boards most in view for the cyber-deck's main board (Raspberry Pi 5 and Zero 2 W, Orange Pi 5 and 6, LattePanda's x86 boards), compared; none is chosen.
6. [docs/CARRIERS.md](docs/CARRIERS.md): carrier boards for Raspberry Pi's Compute Module 5, and what a carrier of the project's own would take; none is chosen.
7. [docs/MU-CARRIERS.md](docs/MU-CARRIERS.md): carrier boards for the LattePanda Mu, the x86 compute module, and what a carrier of the project's own would take; none is chosen.
8. [docs/BOARDS.md](docs/BOARDS.md): the development boards for the bench work, mainly RISC-V boards compared with Arm boards, with a proposed choice.
9. [docs/LORA.md](docs/LORA.md): the LoRa mesh radio: the Meshtastic, MeshCore and Reticulum networks, how to build the radio in, and its certification.
10. [docs/HANDHELD.md](docs/HANDHELD.md): an earlier proposal for a Raspberry Pi handheld, now one option among others.

## What's in this repository

- `docs/`: the documents listed above, and the [glossary](docs/GLOSSARY.md).
- `.github/`: GitHub settings: who reviews what, issue forms, the pull-request template, the automatic sign-off check, Dependabot, and the list of labels (`labels.sh`).
- `.pre-commit-config.yaml`: the checks that run on your computer before every commit ([CONTRIBUTING.md](CONTRIBUTING.md#before-you-start)).

The requirements and the notes from bench work will join `docs/` as the roadmap's tasks are done.
Source code of operating systems and build output are kept outside this repository.

## Relation to FoxieOS

This project is separate from [FoxieOS](https://github.com/alopex-org/foxieos), the operating-system project for the cyber-deck, and doesn't follow its plan.
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
