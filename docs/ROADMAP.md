# Alopex roadmap

This page lists what is decided, what is still open, and the work in the order it should happen.
Background: [FEASIBILITY.md](FEASIBILITY.md) for the research, [DESIGN.md](DESIGN.md) for how the project is set up.
Technical words are explained in the [glossary](GLOSSARY.md).

## Where things stand

- **Done:** task T0, the research and this repository, on 2026-11-20.
- **Decided:** the project is separate from FoxieOS, and lives in the `alopex-org` GitHub organization ([DESIGN.md](DESIGN.md#key-decisions)).
- **Proposed 2026-11-24:** the device is a cyber-deck, a portable computer of the project's own ([CYBERDECK.md](CYBERDECK.md)).
  Nothing else about it is decided: its purpose, form, parts and software are open.
  A built-in LoRa radio, recorded as decided on 2026-11-21 for a phone, is open again (decision D4).
- **Founding meeting, 2026-11-24:** the members choose the maintainers, who decide the project's foundations together ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).
  One interim maintainer decided everything marked decided here, so the meeting confirms or changes it.
  The meeting also takes decision D5: a prototype only, or a product.
- **Earlier proposal:** a Raspberry Pi handheld as the first prototype ([HANDHELD.md](HANDHELD.md)); it is now one option for the cyber-deck, not a plan.
- **Next:** task T1, the cyber-deck's requirements.
  It needs no decision and no money.

## How to read this page

- **Decisions (D1–D6)** are questions the maintainers answer.
  Each one lists the options and a recommendation.
- **Tasks (T0–T7)** are the pieces of work, in order.
  Each one says what it needs first, what to do, when it is finished, and what to share afterwards.
- **Checks (C1–C14)** are facts to confirm before the task that relies on them.
  A ⚠ in the other docs usually points to one of them.
- **On GitHub,** each decision, task and check also has an issue, and each phase below is a [milestone](https://github.com/alopex-org/alopex/milestones).
  This page is the plan; the issues track progress and discussion ([CONTRIBUTING.md](../CONTRIBUTING.md#issues-and-labels)).
- **Who does each task:**
  - **Code:** a change to files, made in a pull request.
    Anyone can do it.
  - **Hands-on:** work on a board, a module or a device.
    The maintainer does it, or approves each step.
  - **Maintainer only:** contacting companies, agreements, purchases, money and keys.
    Others may draft the documents for these steps, but only the maintainer sends or signs them.

## Phases

1. **Requirements:** what the cyber-deck is for and what it must have (T1).
2. **Bench work:** trying candidate hardware on development boards (T2), and on a cellular module's evaluation kit if the cyber-deck is to be cellular (T3).
3. **A prototype:** decisions D1–D3, taken on what the first two phases show, then a prototype built in small numbers.
   Whether a product follows is decision D5.

## Decisions

| ID | Question | Status | Needed by |
|---|---|---|---|
| [D1](#d1-route-to-a-prototype) | How is the cyber-deck built, and around what main board? | Open | A prototype |
| [D2](#d2-cellular-or-wi-fi-only) | Does the cyber-deck connect to mobile networks, or not? | Open | D1 |
| [D3](#d3-sharing-prototypes) | Do prototypes stay with the maintainers, or reach other enthusiasts, and how? | Open | D1 |
| [D4](#d4-lora-mesh-network) | Does the cyber-deck have a LoRa mesh radio, and if so, which network? | Open | T6 |
| [D5](#d5-prototype-or-product) | Does the project stop at a prototype, or aim at a product it sells? | Open: founding meeting | D1, D3, T4, T5 |
| [D6](#d6-operating-system-of-the-first-prototype) | What operating system does the cyber-deck run? | Open | D1 |

### D1: route to a prototype

How the cyber-deck is built, and around what main board.
Open; needed before a prototype is built.

- **Options,** none of them preferred yet:
  - a ready-made board, such as a single-board computer, in a case of the project's own;
  - a computer module on a board of the project's own (a carrier board);
  - a main board of the project's own around a cellular module, if decision D2 chooses a cellular device ([FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device));
  - a microcontroller board, for a simpler device.
  [BOARDS.md](BOARDS.md) compares boards researched for the earlier phone plan, and [HANDHELD.md](HANDHELD.md) works out one option, a Raspberry Pi handheld; task T1's requirements may point to others.
- Working with a phone maker, and having an ODM build a phone, are routes to a product, and become options only if decision D5 chooses one ([DESIGN.md](DESIGN.md#prototype-or-product)).
- **Recommendation:** decide after task T1 and the bench work in task T2.
  Never a device designed directly with a chip maker.

### D2: cellular or Wi-Fi only

Whether the cyber-deck connects to mobile networks.
Open; needed by D1.

- A **Wi-Fi-only device**, such as a tablet, needs no cellular module, no approval from mobile networks and no mobile-network patent licences.
- A **cellular device,** like a mobile phone, works wherever there is a mobile network, and costs more at every step.
- **Recommendation:** decide on what task T1's requirements ask for.

### D3: sharing prototypes

Who gets the prototypes, and how.
Open; needed by D1.

Unless decision D5 chooses a product, the project sells nothing.
But whoever puts a device on the market carries the certification, patent and EU duties ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).
⚠ Whether handing a prototype to someone counts as putting it on the market is not confirmed (check C12).

- **Options:**
  - prototypes stay with the maintainers, who build and keep them;
  - the design files are published, and other enthusiasts build their own;
  - the project builds a few extra devices and hands them to other enthusiasts.
- **Recommendation:** the first two together, and the third only if check C12 shows it brings no manufacturer's duties.

### D4: LoRa mesh network

Whether the cyber-deck has a LoRa mesh radio, and if so, which network it runs.
Open; needed by T6.

An earlier version of this roadmap recorded a built-in LoRa radio as decided on 2026-11-21, for a phone; with the move to a cyber-deck, it is open again.

- **Options** ([LORA.md](LORA.md#the-mesh-networks)):
  - **No LoRa radio.**
  - **Meshtastic:** the largest network, under the GPL-3.0 licence; messages spread to every neighbour, which needs no planning but uses more airtime.
  - **MeshCore:** under the MIT licence; messages travel through fixed repeaters, which works better at scale where repeaters exist.
  - **Both:** hardware that runs either network's software, with one as the default and the other installable by the user.
  - **Reticulum:** the most general, but its licence keeps it out of Debian and F-Droid.
- **Recommendation:** decide whether after task T1.
  If the cyber-deck has one, the earlier research suggested both networks, with Meshtastic as the default because more people use it, if check C10 confirms that one LoRa design runs both.

### D5: prototype or product

Whether the project stops at a prototype or aims at a product it sells.
Open; for the maintainers' founding meeting on 2026-11-24, and needed by D1 and D3.

An earlier version of this roadmap recorded "a prototype, not a product" as decided on 2026-11-21.
That was written down before the team had agreed on it, so it is open again ([DESIGN.md](DESIGN.md#prototype-or-product)).

- **Options:**
  - a prototype only, for the maintainers and other enthusiasts, with nothing sold;
  - a prototype first, then a product, once the prototype proves the design;
  - a product from the start, by working with a phone maker or having an ODM build a phone (tasks T4 and T5).
- A product means a company of the project's own or a partner, funding, certification, patent licences and the EU's update and spare-part duties ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).
- **Recommendation:** none; the maintainers decide this together.
  Tasks T1–T3 serve every option, so they go ahead in the meantime.

### D6: operating system of the first prototype

What operating system the cyber-deck runs.
Open; needed by D1.

The project was set up to build hardware for an operating system based on Android.
[FoxieOS](https://github.com/alopex-org/foxieos), the organization's operating-system project, is proposed to be made for the cyber-deck instead; what FoxieOS is built on is its own open decision.

- **Options:**
  - **FoxieOS,** whatever it is built on.
  - **An existing operating system as it is,** such as a Linux distribution, or Android where the chosen board has a complete build ([BOARDS.md](BOARDS.md#comparison)).
  - **A microcontroller's firmware,** such as a mesh network's own, if decision D1 chooses a microcontroller board.
- **Recommendation:** none; it changes what the project is for, so the maintainers decide it together.
  The bench work in tasks T2 and T7 can use any system that runs, since it tests the hardware.

## Tasks

Work in this order, unless a task's needs allow another.

### T0: research and repository

Done 2026-11-20: this repository, with the research in [FEASIBILITY.md](FEASIBILITY.md).

### T1: hardware requirements

The list of what the cyber-deck must offer.
**Code.** Can start now.

- Write `docs/REQUIREMENTS.md` as a draft for the maintainers: what the cyber-deck is for and what it must have, each requirement with its reason and source.
  Where the members disagree, list the options instead of choosing one.
- Cover at least the questions in [CYBERDECK.md](CYBERDECK.md#what-is-undecided):
  - what the cyber-deck is for, and who uses it;
  - its form and size, its screen, and how it is typed on and controlled;
  - its main board, and how long its software gets fixes;
  - its radios: Wi-Fi, mobile networks, Bluetooth, satellite positioning, LoRa;
  - its power: battery, charging and battery life;
  - privacy and security, such as hardware switches and secure boot; if it has secure boot, who holds the key ([DESIGN.md](DESIGN.md#each-party-keeps-its-own-keys));
  - repair, and how the case is made.
- The earlier research can help: GrapheneOS's published device requirements (check C1), and the parts worked out in [HANDHELD.md](HANDHELD.md) and [LORA.md](LORA.md).
- Note which of the conditions in FoxieOS's decision D9 each requirement meets.

**Finished when** the list exists, every requirement gives its reason and source, and the maintainers have reviewed it.
**Share** the open questions the list raises.

### T2: development board bring-up

Trying candidate boards for the cyber-deck on the bench.
**Hands-on.** Needs task T1 and check C9, and the maintainer to buy the boards.

- Pick two or three boards that task T1's requirements point to.
  [BOARDS.md](BOARDS.md) compares the boards researched for the earlier phone plan, mainly RISC-V boards; others may fit the cyber-deck better.
- Start an operating system on each.
  Decision D6 sets what the cyber-deck runs; for the bench, any system that runs on the board is enough to test it.
  A build can take hours, so keep the build log.
- If the board has secure boot, try it with a dev key, never a key that will sign anything published, and practise fusing only on a board bought for that purpose, with the maintainer's go-ahead for each step.
- Record the work in `docs/bench/<board>.md`: how long it took, the kernel version and software the board's maker provides, and what got in the way.

**Finished when** each board starts a system and its record is committed.
**Share** a summary of the build logs, the start-up results and the records.

### T3: cellular module evaluation kit

Trying a cellular module on its evaluation kit.
On hold unless decision D2 chooses a cellular device.
**Hands-on.** Needs task T2 and checks C4 and C5, and the maintainer to buy the kit and sign up for any supplier website.

- Try one cellular module that comes with an Android BSP, on its evaluation kit.
- Record in `docs/bench/<module>.md`:
  - the Android version and kernel it comes with, and how far behind the current release they are;
  - what setting up secure boot involves;
  - which of the module's certifications would carry over to a finished device.

**Finished when** a written assessment says whether a design around a module can work technically.
**Share** the assessment.

### T4: partner survey

On hold until decision D5: working with a phone maker is a route to a product ([DESIGN.md](DESIGN.md#prototype-or-product)).

### T5: ODM quotes

On hold until decision D5: having an ODM build a phone is a route to a product ([DESIGN.md](DESIGN.md#prototype-or-product)).

### T6: LoRa bench work

Trying a LoRa radio design on the bench.
On hold unless decision D4 gives the cyber-deck a LoRa radio.
**Hands-on.** Needs task T1, decision D4 and checks C10 and C11, and the maintainer to buy a LoRa development board.
Can run alongside task T2.

- Connect a small board with an SX1262 LoRa chip, such as an nRF52840 or ESP32-S3 board that Meshtastic and MeshCore support, to the task T2 board by UART or USB.
- Install Meshtastic and MeshCore on it in turn, and send messages to another device from the task T2 board, through each network's app, over the cable.
- Measure how much current the LoRa board draws while passing on messages with the main board asleep.
- Record the work in `docs/bench/lora.md`.

**Finished when** messages pass over the cable with both networks' software, or the record says why not.
**Share** the results, the current measured, and anything the apps couldn't do over a cable.

### T7: handheld test build

Building the earlier [handheld](HANDHELD.md) proposal on the bench, to see whether its parts work together before decision D1.
Optional: only if the maintainers want to try that option.
**Hands-on.** Needs task T1 and checks C13 and C14, and the maintainer to buy the parts.
Can run alongside task T2; Linux is enough to test the hardware, whatever decision D6 chooses.

- Connect an SX1262 LoRa board to a Raspberry Pi 5 over SPI, run `meshtasticd`, and send messages to another Meshtastic device on 868 MHz, with the antenna always connected.
- Add a USB Wi-Fi adapter and a GNSS receiver, and share the device's position over the mesh.
- Wire one hardware switch for each part, and check with a meter that a switched-off part draws no current, including through its data lines.
- Run the Pi from an 18650 cell through a converter and an ideal-diode power path with a backup cell, swap the cell while it runs, and measure the current drawn when idle, when sending over LoRa and when using Wi-Fi.
- Record the work in `docs/bench/handheld.md`, with the parts used, a wiring diagram and the measurements.

**Finished when** messages and positions pass over LoRa, every switch cuts its part fully, and a battery swap doesn't restart the device, or the record says why not.
**Share** the measurements, the battery life they imply, and what would change for a case of the project's own.

## Order of the critical work

The longest chains of work, where each step waits for the one before:

- T1 → T2, then T3 if decision D2 chooses a cellular device;
- at the same time, T1 → D4 → T6, if the cyber-deck has a LoRa radio;
- if the maintainers want it, T1 → C13 and C14 → T7;
- check C12 → D3, and D5 → D1 and D3.

They come together in D2, D3, D4, D6 and then D1.

## Not planned

- **A device designed directly with a chip maker** ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).
- **Work on a particular operating system.**
  Supporting a device is each operating-system project's own work; for FoxieOS, it is decided in its decision D9.
  Decision D6 decides what the cyber-deck runs.

## Checks

Each check is a short task to confirm a fact.
Do it before the task that relies on it (shown by →), then update the docs that carry the ⚠.

1. **C1, GrapheneOS and Motorola** (→ T1).
   Read GrapheneOS's published hardware requirements on grapheneos.org, and confirm there whether the Motorola Signature 27 is supported.
2. **C2, EU ecodesign details** (→ C12).
   Read Regulation (EU) 2023/1670 and its 2025/2006 amendment for the exact duties on updates, spare parts and battery durability.
3. **C3, replaceable batteries** (→ C12).
   Whether smartphones fall under Delegated Regulation (EU) 2026/1770, or under the durability exemption in Article 11 of the Batteries Regulation.
4. **C4, module software** (→ T3).
   The current Android version of the Quectel SG560D and similar modules, and the terms for getting their BSP.
5. **C5, Qualcomm's signing tools and software** (→ T3).
   What a licence for Qualcomm's signing tools (SecTools) involves, and whether a small buyer can get one.
   How Qualcomm and the board makers hand out the Android BSP for QCS6490 boards, and on what terms.
   Whether Thundercomm publishes an Android image for the RUBIK Pi 3, and the board's price.
6. **C6, costs** (→ D1, D2).
   Current prices of the modules, boards and memory a prototype needs.
7. **C7, EU cybersecurity dates** (→ C12).
   Whether the repeal of the radio-equipment cybersecurity rule (RED delegated act 2022/30) was adopted, and whether the Cyber Resilience Act's dates changed.
8. **C8, small makers** (background).
   Whether the Liberux NEXX shipped, and whether Pine64 restarted production.
9. **C9, board details** (→ T2).
   Before buying a board, confirm for the boards proposed in [BOARDS.md](BOARDS.md):
   - their current prices and availability, and whether anyone can buy the Alibaba A210 EVB;
   - whether SpacemiT and Alibaba document secure boot for the K3 and the A210, and whether that documentation is public;
   - what works in RISE's Android 17 release beyond what it states: audio, video, the camera, Android's security rules (SELinux) switched on, and a secure area (TEE);
   - whether Google has a RISC-V GKI version or a newer statement than its 2025 status, and where the SpacemiT K1's Android 16 BSP comes from;
   - whether downloading NXP's code-signing tool (CST) needs an account, and whether the licence of NXP's closed source package lets the project publish what it builds;
   - whether BeaglePlay's AM625 chip is a GP or an HS-FS version, and how TI provides its key-writing tool;
   - which Android version BayLibre's AOSP kit for the MediaTek Genio boards is on.
10. **C10, LoRa hardware and band rules** (→ D4, T6).
    Confirm that Meshtastic and MeshCore both support the same nRF52840 or ESP32-S3 boards with an SX1262, and which certified LoRa modules would fit a phone's board.
    Read the current ETSI EN 300 220 for the 868 MHz sub-band edges, power and duty-cycle limits, and FCC Part 15 for 915 MHz.
11. **C11, mesh apps and licences** (→ D4, T6).
    Whether the Meshtastic and MeshCore Android apps connect over a USB cable as well as Bluetooth, the licences of the MeshCore apps, whether MeshCore has closed parts, and the exact terms of the Reticulum licence.
12. **C12, prototypes and the market rules** (→ D3, D5).
    Whether building prototypes for the maintainers' own use, publishing the design files, or handing devices to other enthusiasts for free or at cost counts as putting them on the EU market under the Radio Equipment Directive, the ecodesign and battery rules and the Cyber Resilience Act.
    Start from the European Commission's Blue Guide on EU product rules, and confirm the result with a lawyer before any device leaves the maintainers' hands.
13. **C13, handheld power** (→ T7).
    Read the power-supply section of Raspberry Pi's hardware documentation for the Pi 5's exact supply needs and USB current limits, and whether it can sleep.
    Then pick a converter from an 18650 cell to 5 V that meets them, and an ideal-diode power-path controller for the backup cell.
14. **C14, handheld switches and position** (→ T7).
    How to cut a part fully, including its data lines, so it isn't powered through them, for the SPI LoRa radio, a USB adapter, a GNSS receiver and a microphone.
    Whether `meshtasticd` on Linux can read a GNSS receiver and share its position.
