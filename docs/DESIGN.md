# FoxieOS hardware design

**Status: research.**
This describes how the project is set up and how a device would come about; no hardware is designed yet.
The research and sources behind it are in [FEASIBILITY.md](FEASIBILITY.md).

## Purpose

FoxieOS hardware finds out how a small team could build a prototype phone, or a similar device, for an Android-based operating system, and then works toward one in cheap steps.
Whether that stays a prototype, built in small numbers and not sold, or leads to a product is open: the maintainers decide it at their founding meeting on 2026-11-24 ([Prototype or product](#prototype-or-product)).

A LoRa radio for off-grid mesh messaging is a core feature of any device it works toward ([LoRa mesh radio](#lora-mesh-radio-as-a-core-feature)).

It does **not**:

- follow the plan or device criteria of the FoxieOS operating system ([Related repositories](#related-repositories));
- design a phone from the chip up with a chip vendor;
- take on a manufacturer's legal duties before decision D5 says it aims at a product; how prototypes are shared is roadmap decision D3.

## How a device comes about

Every route to a device sold as a product involves the same parties.
What changes from route to route is who plays each part.
A prototype that isn't sold places nothing on the market; if decision D5 chooses a product, the chain shows who would play each part.

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
Manufacturer: a partner, or a company of the project's own (decision D5)
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
For an ODM phone or a module-based product, the seller would be.
For a prototype that isn't sold, the project builds the device and holds its secure-boot key, but takes on no manufacturer's duties ⚠ (roadmap check C12).
The routes are compared in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device), and the terms are explained in its [Terms](FEASIBILITY.md#terms) section.

## Key decisions

Decided items carry their date.
The others are proposed: they are the plan's recommendation until the maintainers decide them through the roadmap item they name.
Everything decided before the founding meeting on 2026-11-24 was decided by one interim maintainer, and the meeting confirms or changes it ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).

### A separate project

Decided 2026-11-20.

- **What:** this project doesn't follow the FoxieOS plan or its device criteria.
  FoxieOS decides on its side whether, and on what terms, it would support a device from here (FoxieOS roadmap decision D9).
- **Why:** the routes, costs and legal duties of making a device are the same whichever operating system runs on it.
  FoxieOS's device criteria ask for official LineageOS support, which no new device has, so holding this research to them would rule out everything but existing phones.
- **Rejected:** a hardware section inside the FoxieOS repository.

### Prototype or product

Open (roadmap decision D5), for the maintainers' founding meeting on 2026-11-24.
An earlier version of this file recorded "a prototype, not a product" as decided on 2026-11-21.
It was recorded before the team had agreed on it, so it goes back to the maintainers.

- **A prototype only:** the project builds devices for its maintainers and other enthusiasts, in small numbers, and sells nothing.
  It avoids certification, patent licences and years of EU update and spare-part duties ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)), and keeps the work to what the team can learn and build.
- **A product:** the project, through a company of its own or a partner, sells devices.
  It reaches people beyond the team and can pay for the work, but needs a company, funding, certification, and the manufacturer's duties for years after the last sale ([FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device)).
- **A prototype first, then a product:** the bench work and a prototype prove the design before the team commits to the costs of a product.
- Tasks T1–T3 are the same under every option, so they go ahead in the meantime.

### Hosting on GitHub

Decided 2026-11-20, following FoxieOS's decision D3.

- **What:** the repository is `alopex-org/foxieos-hardware`, in the same GitHub organization as FoxieOS.
- **Why:** it keeps the FoxieOS repositories together, under one set of owners.
- **Rejected:** a separate organization.

### LoRa mesh radio as a core feature

Decided 2026-11-21; the network is proposed (roadmap decision D4).

- **What:** the device has a LoRa radio on its own board, for messaging over a mesh network such as Meshtastic or MeshCore with no cellular network or Wi-Fi.
  The proposed design is a microcontroller with its own LoRa chip, connected to the main processor over UART or USB, running the mesh network's own firmware ([LORA.md](LORA.md#integrating-the-radio)).
- **Why:** off-grid messaging is the device's main reason to exist next to existing phones, and none of them has the radio on its own board.
  A separate microcontroller keeps the mesh running while the phone sleeps and can run more than one network's firmware.
- **Rejected:**
  - a LoRa node attached over Bluetooth, which existing products already offer;
  - the LoRa chip driven directly by the main processor, which stops the mesh whenever Android suspends.

### Requirements first, then bench work, then a route

Proposed (roadmap decision D1).

- **What:** write the hardware requirements (task T1), and learn bring-up on a development board and a cellular module's evaluation kit (T2, T3).
  Only then choose how the prototype is built.
- **Why:** every route starts from a list of requirements.
  The bench work is cheap, and shows whether the team can carry a BSP forward.
  Building a prototype, by contrast, commits money and time.
- **Rejected:**
  - choosing a route first;
  - designing a phone directly with a chip vendor, which needs a vendor agreement, large volumes and funding far beyond a small team ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).

### Each party keeps its own keys

Proposed (task T1 writes it into the requirements).

- **What:** whoever builds the device holds the secure-boot key whose hash is fused into each chip; for the prototype, that is the project.
  Each OS project signs its own builds and relocks the bootloader with its own verified-boot (AVB) key, as Pixels allow with `avb_custom_key`.
  Neither holds the other's keys.
- **Why:** a fused key can't be replaced, so it belongs with the party that answers for the device for its whole life: the builder, and for a product sold in the EU, the manufacturer.
  A custom AVB key lets more than one operating system run with the bootloader locked, and FoxieOS's decision D9 assumes it.
- **Rejected:**
  - an OS project holding the fused key, which would tie every device to that OS and make the OS project answer for the device's root of trust;
  - a device that can't be relocked with a custom key, which leaves every other operating system running with the bootloader unlocked.

## Constraints

- **Selling brings a manufacturer's duties.**
  Whoever places a device on the market certifies it and pays the cellular patent licences.
  In the EU it must also supply OS updates for at least five years after the last unit is sold, and spare parts for seven ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).
  A prototype that isn't sold avoids these; ⚠ whether handing a prototype to another enthusiast counts as placing it on the market is not confirmed (roadmap check C12).
- **The chip vendor sets the support period.**
  Closed firmware for the modem, the TEE and the GPU gets fixes only while the vendor ships them ([FEASIBILITY.md](FEASIBILITY.md#the-bsp-sets-the-support-period)).
- **Fusing is permanent.**
  Blown secure-boot fuses can't be restored, so each fusing step needs the maintainer's go-ahead ([FEASIBILITY.md](FEASIBILITY.md#root-of-trust)).
- **Parts in small numbers.**
  Chip vendors and ODMs favour large orders, and memory prices rose sharply in 2026 ([FEASIBILITY.md](FEASIBILITY.md#odm-phone)).
  The prototype is built from modules and boards that can be bought one at a time.
- **LoRa band rules.**
  The LoRa radio needs its own short-range-device certification, and in Europe must keep to each sub-band's duty-cycle limit ([LORA.md](LORA.md#certification-and-band-rules)).
- **Bench hardware isn't a phone.**
  The development boards in the research have no cellular modem, and none of them has a phone's cameras, battery or certification ([FEASIBILITY.md](FEASIBILITY.md#development-board)).

## Related repositories

- [foxieos](https://github.com/alopex-org/foxieos): the FoxieOS operating system, a planned Android distribution based on LineageOS.
  FoxieOS depends on this project for a custom device, and the dependency runs one way: this project doesn't depend on FoxieOS, and FoxieOS adapts to its choices.
  Its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project) decides whether it would support a device from this project.
  The conditions it weighs there, such as a GKI kernel built from source and relocking with FoxieOS's own AVB key, are FoxieOS's own, not requirements on this project.
  Task T1 notes which of them a design would meet.

A change that needs a matching change in FoxieOS gets a pull request in each repository, each linking the other.
Because the dependency runs one way, a change here can call for a change in FoxieOS, but a change in FoxieOS never asks this project to adapt.

## Operations (planned)

- **Research:** sources are rechecked, and their dates updated, before each decision that rests on them.
- **Bench hardware:** the maintainer buys boards and kits; fusing is practised only on a board bought for that purpose.
- **Keys:** before any device is fused, the maintainer sets up an offline, backed-up home for the secure-boot key.

## Open questions

The open decisions, the tasks and the claims still to check are in [ROADMAP.md](ROADMAP.md).
