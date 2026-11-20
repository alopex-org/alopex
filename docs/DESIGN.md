# FoxieOS hardware design

**Status: research.**
This describes how the project is set up and how a device would come about; no hardware is designed yet.
The research and sources behind it are in [FEASIBILITY.md](FEASIBILITY.md).

## Purpose

FoxieOS hardware finds out how a small team could get a phone, or a similar device, made for an Android-based operating system, and then works toward one in cheap steps.

It does **not**:

- follow the plan or device criteria of the FoxieOS operating system ([Related repositories](#related-repositories));
- design a phone from the chip up with a chip vendor;
- take on a manufacturer's legal duties before the maintainer has decided who the manufacturer is (roadmap decision D3).

## How a device comes about

Every route to a device involves the same parties.
What changes from route to route is who plays each part.

```
Chip vendor, for example Qualcomm or MediaTek
  - the chip, its board support package (BSP) and firmware updates
  - secure-boot signing tools
        │
        ▼
Module maker or ODM, depending on the route
  - a cellular module, or a finished phone design
  - the certifications that module or design already has
        │
        ▼
Manufacturer: a partner, or a company of the project's own (decision D3)
  - places the device on the market under its name
  - certifies the finished device and pays the patent licences
  - EU duties: OS updates and spare parts for years
  - holds the secure-boot key whose hash is fused into each chip
        │
        ▼
The device
        ▲
        │  OS builds, signed with the OS project's own verified-boot (AVB) key
OS project, such as FoxieOS
```

In a partnership, the partner is the manufacturer.
For an ODM phone or a module-based design, the project's own company would be.
The routes are compared in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device), and the terms are explained in its [Terms](FEASIBILITY.md#terms) section.

## Key decisions

Decided items carry their date.
The others are proposed: they are the plan's recommendation until the maintainer decides them through the roadmap item they name.

### A separate project

Decided 2026-11-20.

- **What:** this project doesn't follow the FoxieOS plan or its device criteria.
  FoxieOS decides on its side whether, and on what terms, it would support a device from here (FoxieOS roadmap decision D9).
- **Why:** the routes, costs and legal duties of making a device are the same whichever operating system runs on it.
  FoxieOS's device criteria ask for official LineageOS support, which no new device has, so holding this research to them would rule out everything but existing phones.
- **Rejected:** a hardware section inside the FoxieOS repository.

### Hosting on GitHub

Decided 2026-11-20, following FoxieOS's decision D3.

- **What:** the repository is `alopex-org/foxieos-hardware`, in the same GitHub organization as FoxieOS.
- **Why:** it keeps the FoxieOS repositories together, under one set of owners.
- **Rejected:** a separate organization.

### Requirements first, then bench work, then a route

Proposed (roadmap decision D1).

- **What:** write the hardware requirements (task T1), learn bring-up on a development board and a cellular module's evaluation kit (T2, T3), and survey possible partners (T4).
  Only then choose how a device gets made.
- **Why:** every route starts from a list of requirements.
  The bench work is cheap, and shows whether the team can carry a BSP forward.
  A route, by contrast, commits money and legal duties for years.
- **Rejected:**
  - choosing a route first;
  - designing a phone directly with a chip vendor, which needs a vendor agreement, large volumes and funding far beyond a small team ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).

### Each party keeps its own keys

Proposed (task T1 writes it into the requirements).

- **What:** the manufacturer holds the secure-boot key whose hash is fused into each chip.
  Each OS project signs its own builds and relocks the bootloader with its own verified-boot (AVB) key, as Pixels allow with `avb_custom_key`.
  Neither holds the other's keys.
- **Why:** a fused key can't be replaced, so it belongs with the party that answers for the device for its whole life; in the EU that is the manufacturer.
  A custom AVB key lets more than one operating system run with the bootloader locked, and FoxieOS's decision D9 assumes it.
- **Rejected:**
  - an OS project holding the fused key, which would tie every device to that OS and make the OS project answer for the device's root of trust;
  - a device that can't be relocked with a custom key, which leaves every other operating system running with the bootloader unlocked.

## Constraints

- **The manufacturer carries the duties.**
  Whoever places the device on the market certifies it and pays the cellular patent licences.
  In the EU it must also supply OS updates for at least five years after the last unit is sold, and spare parts for seven ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).
- **The chip vendor sets the support period.**
  Closed firmware for the modem, the TEE and the GPU gets fixes only while the vendor ships them ([FEASIBILITY.md](FEASIBILITY.md#the-bsp-sets-the-support-period)).
- **Fusing is permanent.**
  Blown secure-boot fuses can't be restored, so each fusing step needs the maintainer's go-ahead ([FEASIBILITY.md](FEASIBILITY.md#root-of-trust)).
- **Volumes and supply.**
  ODMs and chip vendors want minimum orders, and memory prices rose sharply in 2026 ([FEASIBILITY.md](FEASIBILITY.md#odm-phone)).
- **Bench hardware isn't a phone.**
  The development boards in the research have no cellular modem, and none of them has a phone's cameras, battery or certification ([FEASIBILITY.md](FEASIBILITY.md#development-board)).

## Related repositories

- [foxieos](https://github.com/alopex-org/foxieos): the FoxieOS operating system, a planned Android distribution based on LineageOS.
  Its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project) decides whether it would support a device from this project.
  The conditions it weighs there, such as a GKI kernel built from source and relocking with FoxieOS's own AVB key, are FoxieOS's own, not requirements on this project.
  Task T1 notes which of them a design would meet.

A change that needs a matching change in FoxieOS gets a pull request in each repository, each linking the other.

## Operations (planned)

- **Research:** sources are rechecked, and their dates updated, before each decision that rests on them.
- **Bench hardware:** the maintainer buys boards and kits; fusing is practised only on a board bought for that purpose.
- **Keys:** before any device is fused, the maintainer sets up an offline, backed-up home for the secure-boot key.

## Open questions

The open decisions, the tasks and the claims still to check are in [ROADMAP.md](ROADMAP.md).
