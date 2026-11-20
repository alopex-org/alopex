# FoxieOS hardware

Research into how a small team could get a phone, or a similar device, made for an Android-based operating system.

**Status: research.**
No hardware is designed, bought or ordered.
This repository holds the research and the plan; the decisions in it are the maintainer's.

## What this project will be

- A study of the ways to get a device made: with an existing phone maker, through a contract manufacturer, or as a design of the project's own around a cellular module.
- Then cheap bench work: an Android build on a development board, then on a cellular module's evaluation kit.
- Later, if the maintainer decides so and there is funding, a device.

A LoRa radio for off-grid mesh messaging, over Meshtastic, MeshCore or a similar network, is planned as a core part of the device ([docs/LORA.md](docs/LORA.md)).

It will not design a phone from the chip up with a chip vendor, and it doesn't follow the plan of the FoxieOS operating system.
[docs/DESIGN.md](docs/DESIGN.md) explains why.

## The findings in brief

- A phone designed from the chip up is out of reach for a small team.
- Whoever sells a device becomes its manufacturer, with radio certification, patent licences and the EU's duty to supply updates and spare parts for years.
- Three routes are realistic: a partnership with a phone maker, a phone made by a contract manufacturer under the project's name, or a device designed around a cellular module.
- No phone has a LoRa mesh radio on its own board yet; the ones sold attach a node over Bluetooth, so built-in LoRa would set the device apart.
- The first steps are cheap: a list of hardware requirements, then bench work on a development board and a module kit.

## Where to start

1. [docs/FEASIBILITY.md](docs/FEASIBILITY.md): the research: the routes to a device, the software work, the rules, earlier phone projects and the risks, with sources.
2. [docs/ROADMAP.md](docs/ROADMAP.md): open decisions and the next task.
3. [docs/DESIGN.md](docs/DESIGN.md): how a device would come about, who holds which keys, and why the project is set up this way.
4. [docs/BOARDS.md](docs/BOARDS.md): the development boards for the bench work, focused on RISC-V and compared with Arm boards, with a proposed choice.
5. [docs/LORA.md](docs/LORA.md): the LoRa mesh radio: Meshtastic, MeshCore and Reticulum, how to build the radio in, and its certification.

## Repository layout

- `docs/`: the documents listed above.
- `.github/`: code owners, issue forms and the pull-request template.
- `.pre-commit-config.yaml`: the checks that run on every commit ([CONTRIBUTING.md](CONTRIBUTING.md#before-you-start)).

The requirements, bench notes and partner survey join `docs/` as the roadmap tasks are done.
Android source trees and build output are kept outside this repository.

## Relation to FoxieOS

This project is separate from the [FoxieOS](https://github.com/alopex-org/foxieos) operating system, and doesn't follow its plan or device criteria.
FoxieOS decides whether to support a device from this project, and on what terms, in its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
AI coding agents also follow [AGENTS.md](AGENTS.md).
Report security problems as described in [SECURITY.md](SECURITY.md), not in public issues.

## License

Apache License 2.0; see [LICENSE](LICENSE).
The license grants no rights to the FoxieOS name or logo.

Android is a trademark of Google LLC.
This project is not affiliated with Google, the LineageOS project or any company named in these documents.
