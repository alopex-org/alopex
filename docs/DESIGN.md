# Alopex design

**Status: research.**
This page describes how the project is set up and how a device would come about; no hardware is designed yet.
The research and sources behind it are in [FEASIBILITY.md](FEASIBILITY.md), and technical words are explained in the [glossary](GLOSSARY.md).

## In short

- The project works toward a cyber-deck, a portable computer of its own, in cheap steps (proposed for the maintainers to confirm).
- Its primary purpose is to be user-serviceable; it has LoRa and Wi-Fi, is meant to be pocket-sized if possible, and runs a Linux distribution for now.
- A LoRa radio for messaging without a mobile network is a core feature.
- Its main board, screen and controls, power, case and other radios are undecided ([CYBERDECK.md](CYBERDECK.md)).
- Whether the project stops at a prototype or aims at a product is for the maintainers to decide (decision D5).
- The first steps are the same either way: a list of requirements, then bench work on development boards.
- The earlier research into a phone and a Raspberry Pi handheld stays as background and options, not as plans.
- If the device has secure boot, whoever builds it keeps its permanent chip key, and each operating system keeps its own signing key (proposed).

## Purpose

The project works toward a cyber-deck: a portable computer of its own ([A cyber-deck as the device](#a-cyber-deck-as-the-device)).
Its primary purpose is to be **user-serviceable**: a portable computer its owner can open, repair and change.
It has LoRa and Wi-Fi, is meant to be pocket-sized if possible, and runs a Linux distribution for now (roadmap decision D6).
Its main board, screen and controls, power, case and other radios are still open.

A LoRa radio for messaging without a mobile network, over a mesh of other devices, is a core feature of any device the project works toward ([LoRa mesh radio](#lora-mesh-radio-as-a-core-feature)).
Whether it stays a prototype, built in small numbers and not sold, or leads to a product is open: the maintainers decide it at their founding meeting on 2026-11-24 ([Prototype or product](#prototype-or-product)).

The project started out researching a phone for an operating system based on Android.
That research, with the work on a Raspberry Pi handheld, stays as background for the cyber-deck's decisions.

The project does **not**:

- follow the plan of FoxieOS, the operating-system project ([Related repositories](#related-repositories));
- design a device from the chip up together with a chip maker;
- take on a manufacturer's legal duties before decision D5 says it aims at a product; how prototypes are shared is roadmap decision D3.

## How a device comes about

Every route to a device sold as a product involves the same parties; what changes from route to route is who plays each part.
A prototype that isn't sold is never "placed on the market", so the chain below matters only if decision D5 chooses a product.
It was written for a phone; for the cyber-deck, the parts about modules and mobile networks apply only if decision D2 chooses a cellular device.

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
        │  operating-system updates, signed with the OS project's own key
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

### A cyber-deck as the device

Proposed 2026-11-24, for the founding meeting to confirm.

- **What:** the device the project works toward is a cyber-deck, a portable computer of the project's own ([CYBERDECK.md](CYBERDECK.md)):
  - **primary purpose:** user-serviceable, so its owner can open it, repair it and replace its parts;
  - **radios:** LoRa, decided earlier ([LoRa mesh radio](#lora-mesh-radio-as-a-core-feature)), and Wi-Fi;
  - **size:** pocket-sized if possible;
  - **software:** a Linux distribution for now (decision D6); which one is FoxieOS's decision.

  Its main board, screen and controls, power, case and other radios are open, through task T1 and decisions D1–D4.
- **Why:** the direction proposed for the maintainers; the meeting records its reasons when it decides.
- **Turned down:** a phone as the device, the project's earlier aim; its research stays as background ([FEASIBILITY.md](FEASIBILITY.md)).

### A separate project

Decided 2026-11-20.

- **What:** this project doesn't follow the FoxieOS plan or its rules for choosing phones.
  FoxieOS decides on its side whether, and on what terms, it would support a device from here (FoxieOS roadmap decision D9).
- **Why:** the routes, costs and legal duties of making a device are the same whichever operating system runs on it.
  FoxieOS then accepted only phones that LineageOS already supported, which no new device is, so holding this research to FoxieOS's rules would have ruled out everything except existing phones.
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

Decided 2026-11-21, and kept for the cyber-deck; which network to use is proposed (roadmap decision D4).

- **What:** the device has a LoRa radio on its own circuit board, for messaging over a mesh network such as Meshtastic or MeshCore, with no mobile network or Wi-Fi.
  The proposed design is a small separate processor (a microcontroller) with its own LoRa chip, connected to the main processor by a cable-like link (UART or USB), running the mesh network's own software ([LORA.md](LORA.md#integrating-the-radio)).
- **Why:** messaging without a network is the device's main reason to exist next to existing phones, and none of them has the radio built in.
  A separate small processor keeps the mesh running while the phone sleeps, and can run more than one network's software.
- **Turned down:**
  - a separate LoRa radio connected over Bluetooth, which products already on sale offer;
  - the LoRa chip run directly by the main processor, which stops the mesh whenever Android goes to sleep.

### Requirements first, then bench work, then a route

Proposed (roadmap decision D1).

- **What:** write the cyber-deck's requirements (task T1), and try candidate hardware on development boards (T2), and on a cellular module's evaluation kit only if decision D2 chooses a cellular device (T3).
  Only then choose how the prototype is built.
- **Why:** every route starts from a list of requirements.
  The bench work is cheap, and shows whether the team can keep a board's software up to date.
  Building a prototype, by contrast, commits money and time.
- **Turned down:**
  - choosing a route first;
  - designing a phone directly with a chip maker, which needs a contract with them, large orders and far more money than a small team has ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).

### An earlier proposal: a Raspberry Pi handheld

<!-- Keeps links to this section's earlier title, "A Raspberry Pi handheld as the first prototype", working. -->
<a id="a-raspberry-pi-handheld-as-the-first-prototype"></a>

Proposed 2026-11-23 as the first prototype; with the move to a cyber-deck, it is one option among others, not a plan (roadmap decisions D1, D2 and D6; task T7 can try it on the bench).

- **What:** a rugged handheld around a Raspberry Pi, Wi-Fi only through a removable USB adapter, with a LoRa radio and external antenna, a GNSS receiver, hardware switches that cut power to the Wi-Fi, LoRa, GNSS and microphone, and a battery that can be swapped while it runs ([HANDHELD.md](HANDHELD.md)).
  It is proposed to run a small Linux system built for privacy, such as Alpine Linux.
- **Why:** every part can be bought one at a time, it needs no cellular module, certification of a modem or mobile-network patent licences, and it puts the LoRa radio and the privacy switches in people's hands early.
- **Open points:**
  - it is larger than the pocket size now aimed for;
  - the LoRa chip on the Pi's own pins differs from the separate small processor proposed above, which saves battery on a device carried every day;
  - Meshtastic already encrypts LoRa messages, so the proposal's own encryption script is left out ([HANDHELD.md](HANDHELD.md#the-proposed-software)).
- **Turned down:** nothing yet; the alternative is the module-based route after tasks T2 and T3.

### Each party keeps its own keys

Proposed (task T1 writes it into the requirements); it applies if the device has secure boot.

- **What:** whoever builds the device holds the secure-boot key, whose fingerprint is burned into each chip; for the prototype, that is the project.
  Each operating-system project signs its own updates with its own key.
  Neither holds the other's keys.
  How an owner or an operating system can add a key of its own depends on the main board (decision D1).
  The earlier phone plan relied on Android's verified boot (AVB), where Pixels let the owner install a key with `avb_custom_key`.
- **Why:** a key burned into the chip can never be replaced, so it belongs with the party that answers for the device for its whole life: the builder, and for a product sold in the EU, the manufacturer.
  A key the owner can add lets more than one operating system run with secure boot on.
  Who holds the secure-boot key is also part of FoxieOS's decision D9.
- **Turned down:**
  - an operating-system project holding the chip key, which would tie every device to that operating system and make it answer for the device's security;
  - a device that accepts no key from its owner, which leaves every other operating system running without secure boot.

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
- **Bench hardware isn't a finished device.**
  The development boards in the research have no mobile-network modem, and none has a finished device's case, battery or certification ([FEASIBILITY.md](FEASIBILITY.md#development-board)).

## Related repositories

- [foxieos](https://github.com/alopex-org/foxieos): FoxieOS, the operating-system project for the cyber-deck; what it is built on is undecided.
  FoxieOS depends on this project for a device of its own, and only in that direction: this project doesn't depend on FoxieOS, and FoxieOS adapts to its choices.
  Its roadmap decision [D9](https://github.com/alopex-org/foxieos/blob/main/docs/ROADMAP.md#d9-devices-from-the-hardware-project) decides whether it would support a device from this project.
  The conditions it weighs there are FoxieOS's own, not requirements on this project.
  Task T1 notes which of them a design would meet.

A change that needs a matching change in FoxieOS gets a pull request in each repository, each linking the other.
Because the dependency runs one way, a change here can call for a change in FoxieOS, but a change in FoxieOS never asks this project to adapt.

## Running the project (planned)

- **Research:** sources are checked again, and their dates updated, before each decision that rests on them.
- **Bench hardware:** the maintainer buys boards and kits; fusing is practised only on a board bought for that purpose.
- **Keys:** before any device is fused, the maintainer sets up an offline, backed-up home for the secure-boot key.

## Open questions

The open decisions, the work still to do and the facts still to check are in [ROADMAP.md](ROADMAP.md).
