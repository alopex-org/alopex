# Alopex design

**Status: research.**
This page describes how the project is set up and how a device would come about; no hardware is designed yet.
The research and sources behind it are in [FEASIBILITY.md](FEASIBILITY.md), and technical words are explained in the [glossary](GLOSSARY.md).

## In short

- The project designs a cyber-deck, a rugged hand-held computer with a slide-out keyboard, and works toward it in cheap steps ([CYBERDECK.md](CYBERDECK.md)).
- Whether it stops at a prototype or aims at a product is for the maintainers to decide (decision D5).
- A LoRa radio for messaging without a mobile network is a core feature.
- The first steps are the same either way: a list of requirements, then the electronics on the bench and the case as a mock-up.
- The cyber-deck is built around a Raspberry Pi Compute Module 5 and runs FoxieOS, a Linux system (decision D6).
- Whoever holds the key written into the chip decides what the device starts; who that is, is still open.

## Purpose

The project designs a cyber-deck for private messaging with and without a network, and works toward it in cheap steps ([CYBERDECK.md](CYBERDECK.md)).
It set out to build a phone, or a similar device, for an operating system based on Android; the move to a cyber-deck running Linux is proposed for the maintainers to confirm ([A cyber-deck as the device](#a-cyber-deck-as-the-device)).
Whether the device stays a prototype, built in small numbers and not sold, or leads to a product is open: the maintainers decide it at their founding meeting on 2026-11-24 ([Prototype or product](#prototype-or-product)).

A LoRa radio for messaging without a mobile network, over a mesh of other devices, is a core feature of any device the project works toward ([LoRa mesh radio](#lora-mesh-radio-as-a-core-feature)).

The project does **not**:

- follow the plan of the FoxieOS operating system, or its rules for devices ([Related repositories](#related-repositories));
- design a phone from the chip up together with a chip maker, or build a phone at all for now (decision D2);
- take on a manufacturer's legal duties before decision D5 says it aims at a product; how prototypes are shared is roadmap decision D3.

## How a device comes about

Every route to a device sold as a product involves the same parties; what changes from route to route is who plays each part.
A prototype that isn't sold is never "placed on the market", so the chain below matters only if decision D5 chooses a product.
The chain is drawn for a phone; for the Wi-Fi-only cyber-deck, the chip maker is Raspberry Pi, the module is the Compute Module 5, and there is no mobile network to certify.

```
Chip maker, for example Qualcomm or MediaTek
  - the chip, its software package (BSP) and firmware updates
  - the tools for signing firmware so the chip will start it
        │
        ▼
Module maker or ODM, depending on the route
  - a ready-made cellular module, or a finished phone design
  - the certifications that module or design already has
        │
        ▼
Manufacturer: a partner, or a company of the project's own (decision D5)
  - sells the device under its own name
  - certifies the finished device and pays the patent licences
  - EU duties: system updates and spare parts for years
  - holds the permanent chip key, whose fingerprint is burned into each chip
        │
        ▼
The device
        ▲
        │  operating-system updates, signed with the OS project's own key (AVB)
Operating-system project, such as FoxieOS
```

- In a partnership, the partner is the manufacturer.
- For an ODM phone or a product built around a module, the seller would be.
- For a prototype that isn't sold, the project builds the device and holds its chip key, but takes on no manufacturer's duties ⚠ (roadmap check C12).

The routes are compared in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device).

## Key decisions

Decided items carry their date.
The others are proposals: they are the plan's recommendation until the maintainers decide them through the roadmap item they name.
Everything decided before the founding meeting on 2026-11-24 was decided by one interim maintainer, and the meeting confirms or changes it ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).

Each decision says what was chosen, why, and what was turned down.

### A separate project

Decided 2026-11-20.

- **What:** this project doesn't follow the FoxieOS plan or its rules for devices.
  FoxieOS decides on its side whether, and on what terms, it would support a device from here (FoxieOS roadmap decision D9).
- **Why:** the routes, costs and legal duties of making a device are the same whichever operating system runs on it, and the hardware's choices shouldn't wait on an operating system's plans.
  FoxieOS, now proposed as the cyber-deck's operating system, adapts to this project's choices.
- **Turned down:** a hardware section inside the FoxieOS repository.

### Prototype or product

<!-- Keeps links to this section's earlier title, "A prototype, not a product", working. -->
<a id="a-prototype-not-a-product"></a>

Open (roadmap decision D5), for the maintainers' founding meeting on 2026-11-24.
An earlier version of this page recorded "a prototype, not a product" as decided on 2026-11-21.
That was written down before the team had agreed on it, so it goes back to the maintainers.

The options:

- **A prototype only:** the project builds devices for its maintainers and other enthusiasts, in small numbers, and sells nothing.
  It avoids certification, patent licences and years of EU update and spare-part duties ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)), and keeps the work to what the team can learn and build.
- **A product:** the project, through a company of its own or a partner, sells devices.
  It reaches people beyond the team and can pay for the work, but needs a company, funding, certification, and the manufacturer's duties for years after the last sale ([FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device)).
- **A prototype first, then a product:** bench work and a prototype prove the design before the team commits to the costs of a product.

Tasks T1–T3 are the same under every option, so they go ahead in the meantime.

### Hosting on GitHub

Decided 2026-11-20, following FoxieOS's decision D3.

- **What:** the repository is `alopex-org/alopex` (named `foxieos-hardware` until 2026-11-23), in the same GitHub organization as FoxieOS.
- **Why:** it keeps the organization's repositories together, with the same owners.
- **Turned down:** a separate organization.

### LoRa mesh radio as a core feature

Decided 2026-11-21; which network to use is proposed (roadmap decision D4).

- **What:** the device has a LoRa radio on its own circuit board, for messaging over a mesh network such as Meshtastic or MeshCore, with no mobile network or Wi-Fi.
  Two designs are compared on the bench (task T6): the LoRa chip on the main processor's SPI pins, run by Meshtastic's Linux service, as the cyber-deck proposes; or a small separate processor (a microcontroller) with its own LoRa chip, connected by UART or USB ([LORA.md](LORA.md#integrating-the-radio)).
- **Why:** messaging without a network is the device's main reason to exist, and no phone has the radio built in.
  The chip on the SPI pins is the simplest; a separate small processor keeps the mesh running while the main processor sleeps, and can run more than one network's software.
- **Turned down:** a separate LoRa radio connected over Bluetooth, which products already on sale offer.

### Requirements first, then bench work, then a route

Proposed (roadmap decision D1).

- **What:** write the hardware requirements (task T1), wire the cyber-deck's electronics to a Raspberry Pi board on the bench (T7), and build the case and the sliding screen as a mock-up (T8).
  Only then design the board and the case of the project's own.
- **Why:** every route starts from a list of requirements.
  The bench work is cheap, and shows what works before money goes into a custom board and case.
- **Turned down:**
  - choosing a route first;
  - designing a phone directly with a chip maker, which needs a contract with them, large orders and far more money than a small team has ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).

### A cyber-deck as the device

Proposed 2026-11-23 (roadmap decisions D1, D2 and D6), for the founding meeting to confirm.

- **What:** the project's device is a cyber-deck: an upright hand-held with a touchscreen that slides over a physical keyboard, a LoRa radio with a telescopic antenna, signal gauges, knobs, hardware switches and two batteries swapped one at a time ([CYBERDECK.md](CYBERDECK.md)).
  It is built around a Raspberry Pi Compute Module 5, is Wi-Fi only, and runs FoxieOS, a Linux system.
  It grows out of the Raspberry Pi handheld proposed earlier, and replaces the phone the project set out to build.
- **Why:**
  - every part can be bought one at a time, and the device needs no cellular module, no modem certification and no mobile-network patent licences;
  - it puts the LoRa radio and the privacy switches in people's hands early;
  - the software it needs runs on Linux today, where Android on a Raspberry Pi has its security rules off and no encryption ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5));
  - hobbyists and small companies already build similar devices, so there is prior work to learn from ([CYBERDECK.md](CYBERDECK.md#cyber-decks-that-already-exist)).
- **Open points:**
  - how the signal gauges and the case are made (decisions D7 and D8);
  - whether the sliding screen and the double battery bay can be built at a hand-held size (task T8);
  - Meshtastic already encrypts LoRa messages, so no encryption of the project's own is added.
- **Turned down:**
  - a phone as the first device, for now: it needs a cellular module, certification and patent licences (decision D2 keeps the question open for a later device);
  - Android as the first device's system, until a board the device uses supports it with its security rules on.

### Each party keeps its own keys

Proposed (task T1 writes it into the requirements).

- **What:** whoever builds the device holds the secure-boot key, whose fingerprint is burned into each chip; for the prototype, that is the project.
  Each operating-system project signs its own updates and relocks the bootloader with its own verified-boot (AVB) key, as Pixels allow with `avb_custom_key`.
  Neither holds the other's keys.
- **Why:** a key burned into the chip can never be replaced, so it belongs with the party that answers for the device for its whole life: the builder, and for a product sold in the EU, the manufacturer.
  An owner-installed AVB key lets more than one operating system run with the bootloader locked, and FoxieOS's decision D9 assumes it.
- **Turned down:**
  - an operating-system project holding the chip key, which would tie every device to that operating system and make it answer for the device's security;
  - a device that can't be relocked with an owner's key, which leaves every other operating system running with the bootloader unlocked.
- **Open point for the cyber-deck:** a Raspberry Pi has no separate owner key like a phone's AVB key.
  The one key whose fingerprint is written into the chip also signs what the board starts, so whoever holds it decides what the device will ever run ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
  The proposal is to ship devices without secure boot turned on, so each owner can turn it on with a key of their own; FoxieOS weighs the same question in its decision D9.
  ⚠ What the key signs, and what an owner can still change on a fused board, needs checking first (check C17).

## Limits the project has to live with

- **Selling brings a manufacturer's duties.**
  Whoever puts a device on the market certifies it and pays the mobile-network patent licences.
  In the EU they must also supply system updates for at least five years after the last device is sold, and spare parts for seven ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).
  A prototype that isn't sold avoids these; ⚠ whether handing a prototype to another enthusiast counts as putting it on the market is not confirmed (roadmap check C12).
- **The chip maker decides how long the device gets fixes.**
  Closed firmware for the modem, the secure area (TEE) and the graphics chip gets fixes only while the chip maker ships them ([FEASIBILITY.md](FEASIBILITY.md#the-bsp-sets-the-support-period)).
- **Fusing is permanent.**
  Once the secure-boot fuses in a chip are set, they can't be reset, so each fusing step needs the maintainer's go-ahead ([FEASIBILITY.md](FEASIBILITY.md#root-of-trust)).
- **Parts in small numbers are hard to get.**
  Chip makers and ODMs prefer large orders, and memory prices rose sharply in 2026 ([FEASIBILITY.md](FEASIBILITY.md#odm-phone)).
  The prototype is built from modules and boards that can be bought one at a time.
- **LoRa has its own band rules.**
  The LoRa radio needs its own certification for short-range devices, and in Europe must keep to each sub-band's limit on how long it may transmit ([LORA.md](LORA.md#certification-and-band-rules)).
- **A moving screen is a weak point.**
  The sliding screen's cable bends at every slide, and the rails take every knock the device does (unsourced; task T8).
- **The device is thick.**
  Two 18650 cells are 18 mm across, before the board, the keyboard and the screen ([CYBERDECK.md](CYBERDECK.md#case-and-size)).

## Related repositories

- [foxieos](https://github.com/alopex-org/foxieos): the FoxieOS operating system, now proposed as a Linux system for the cyber-deck.
  FoxieOS depends on this project, and only in that direction: this project doesn't depend on FoxieOS, and FoxieOS adapts to its choices.
  Its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project) sets the terms on which it supports a device from this project.
  The conditions it weighs there, such as a kernel built from source and a secure-boot key under the owner's control, are FoxieOS's own, not requirements on this project.
  Task T1 notes which of them a design would meet.

A change that needs a matching change in FoxieOS gets a pull request in each repository, each linking the other.
Because the dependency runs one way, a change here can call for a change in FoxieOS, but a change in FoxieOS never asks this project to adapt.

## Running the project (planned)

- **Research:** sources are checked again, and their dates updated, before each decision that rests on them.
- **Bench hardware:** the maintainer buys boards, parts and kits; fusing is practised only on a board bought for that purpose.
- **Keys:** before any device is fused, the maintainer sets up an offline, backed-up home for the secure-boot key.

## Open questions

The open decisions, the work still to do and the facts still to check are in [ROADMAP.md](ROADMAP.md).
