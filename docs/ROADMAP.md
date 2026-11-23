# Alopex roadmap

This page lists what is decided, what is still open, and the work in the order it should happen.
Background: [FEASIBILITY.md](FEASIBILITY.md) for the research, [DESIGN.md](DESIGN.md) for how the project is set up.
Technical words are explained in the [glossary](GLOSSARY.md).

## Where things stand

- **Done:** task T0, the research and this repository, on 2026-11-20.
- **Decided:** the project is separate from FoxieOS, and lives in the `alopex-org` GitHub organization ([DESIGN.md](DESIGN.md#key-decisions)).
  The device has a built-in LoRa mesh radio ([LORA.md](LORA.md)).
- **Proposed 2026-11-23:** the device is a cyber-deck, Wi-Fi only, built around a Raspberry Pi Compute Module 5 and running FoxieOS, a Linux system, instead of a phone for an Android-based system ([CYBERDECK.md](CYBERDECK.md), [DESIGN.md](DESIGN.md#a-cyber-deck-as-the-device)).
  Decisions D1, D2 and D6 below carry it as their recommendation, and two new decisions, D7 and D8, follow from its design.
- **Founding meeting, 2026-11-24:** the members choose the maintainers, who decide the project's foundations together ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).
  One interim maintainer decided everything marked decided here, so the meeting confirms or changes it.
  The meeting also takes decision D5: a prototype only, or a product.
- **Next:** task T1, the hardware requirements.
  It needs no decision and no money.

## How to read this page

- **Decisions (D1–D8)** are questions the maintainers answer.
  Each one lists the options and a recommendation.
- **Tasks (T0–T9)** are the pieces of work, in order.
  Each one says what it needs first, what to do, when it is finished, and what to share afterwards.
- **Checks (C1–C17)** are facts to confirm before the task that relies on them.
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

1. **Requirements:** what the cyber-deck must offer (T1).
2. **Bench work:** the electronics on a Raspberry Pi board, the LoRa radio, and the case and sliding screen as a mock-up (T2, T6, T7, T8).
3. **A prototype:** decisions D1–D3, D7 and D8, taken on what the first two phases show, then a board of the project's own (T9) and a few devices built by hand.
   Whether a product follows is decision D5.

## Decisions

| ID | Question | Status | Needed by |
|---|---|---|---|
| [D1](#d1-route-to-a-prototype) | How is the prototype built: around a cellular module, or around a compute module? | Open | T9 |
| [D2](#d2-cellular-or-wi-fi-only) | Is the first device a mobile phone, or Wi-Fi only? | Open | D1 |
| [D3](#d3-sharing-prototypes) | Do prototypes stay with the maintainers, or reach other enthusiasts, and how? | Open | D1 |
| [D4](#d4-lora-mesh-network) | Which LoRa mesh network does the device come with: Meshtastic, MeshCore or both? | Open | T6 |
| [D5](#d5-prototype-or-product) | Does the project stop at a prototype, or aim at a product it sells? | Open: founding meeting | D1, D3, T4, T5 |
| [D6](#d6-operating-system-of-the-first-prototype) | Does the first prototype run Android, or a Linux system (FoxieOS)? | Open | D1, T7 |
| [D7](#d7-signal-gauges) | Are the signal gauges real needles or small screens? | Open | T8 |
| [D8](#d8-case) | How is the case made? | Open | T8 |

### D1: route to a prototype

How the prototype is built.
Open; needed before a prototype is built.

- **Options:** the routes in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device) that suit a prototype:
  - a main board of the project's own, around a cellular module;
  - a compute module or development board in a case of the project's own, for a Wi-Fi-only prototype.
    [CYBERDECK.md](CYBERDECK.md) works this option out as a cyber-deck around a Raspberry Pi Compute Module 5 (proposed).
- Working with a phone maker, and having an ODM build a phone, are routes to a product, and become options only if decision D5 chooses one ([DESIGN.md](DESIGN.md#prototype-or-product)).
- **Recommendation:** the cyber-deck around a Compute Module 5, on a carrier board of the project's own, once tasks T7 and T8 show that its parts and mechanics work.
  A cellular module comes back only if decision D2 chooses a mobile phone for a later device.
  Never a phone designed directly with a chip maker.

### D2: cellular or Wi-Fi only

Whether the first device connects to mobile networks.
Open; needed by D1.

- A **Wi-Fi-only device**, such as a tablet, needs no cellular module, no approval from mobile networks and no mobile-network patent licences.
- A **mobile phone** is what most people mean by a phone, and costs more at every step.
- **Recommendation:** Wi-Fi only for the first device, as the proposed [cyber-deck](CYBERDECK.md) is.
  A mobile network can be weighed again for a later device, with task T3.

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

Which mesh network the LoRa radio runs.
Open; needed by T6.

- **Options** ([LORA.md](LORA.md#the-mesh-networks)):
  - **Meshtastic:** the largest network, under the GPL-3.0 licence; messages spread to every neighbour, which needs no planning but uses more airtime.
  - **MeshCore:** under the MIT licence; messages travel through fixed repeaters, which works better at scale where repeaters exist.
  - **Both:** hardware that runs either network's software, with one as the default and the other installable by the user.
  - **Reticulum:** the most general, but its licence keeps it out of Debian and F-Droid.
- **Recommendation:** both, with Meshtastic as the default because more people use it, if check C10 confirms that one LoRa design runs both.

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

Whether the first prototype runs Android or a Linux system.
Open; needed by D1 and T7.

The project was set up to build hardware for an operating system based on Android.
The proposed [cyber-deck](CYBERDECK.md#operating-system) runs [FoxieOS](https://github.com/alopex-org/foxieos), now proposed as a Linux system for it.

- **Options:**
  - **Android,** as the project was set up for.
    On a Raspberry Pi only a community build exists, with its security rules (SELinux) off and no encryption of user data ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
  - **A Linux system, FoxieOS:** `meshtasticd`, disk encryption and the proposed messaging apps run on Linux today.
    FoxieOS is a separate project, and adapts to this one's hardware.
- **Recommendation:** FoxieOS, as proposed with the cyber-deck; it changes what the project is for, so the maintainers confirm it together.
  Task T7 works under either option, since it tests the hardware.

### D7: signal gauges

Whether the two round gauges on top of the cyber-deck, for the strength (RSSI) and clarity (SNR) of the LoRa signal, are real needles or small screens.
Open; needed by T8.

- **Options** ([CYBERDECK.md](CYBERDECK.md#signal-gauges)):
  - moving-coil meters with real needles, as the renders look;
  - small round screens that draw the needles;
  - printed dials with no gauges behind them, the signal shown on the main screen instead.
- **Recommendation:** small round screens for the first prototype, which survive drops and can be changed in software; try one moving-coil meter on the bench in task T7 to compare.

### D8: case

How the cyber-deck's case is made.
Open; needed by T8.

- **Options:**
  - 3D-printed, which is cheap to change between versions;
  - machined aluminium, closer to the renders and stronger, but costly in small numbers (unsourced);
  - 3D-printed for the mock-up and the first devices, metal later.
- **Recommendation:** 3D-printed for task T8 and the first devices; decide on metal once the shape stops changing.

## Tasks

Work in this order, unless a task's needs allow another.

### T0: research and repository

Done 2026-11-20: this repository, with the research in [FEASIBILITY.md](FEASIBILITY.md).

### T1: hardware requirements

The list of what the cyber-deck must offer.
**Code.** Can start now.

- Write `docs/REQUIREMENTS.md`: what the device must offer, each requirement with its reason and source.
- Cover at least:
  - secure boot that the owner controls, and what the builder and the operating system each hold ([DESIGN.md](DESIGN.md#each-party-keeps-its-own-keys));
  - how long the compute module is made and supported (the CM5 until at least January 2036);
  - repair access, and batteries the user swaps one at a time without switching the device off ([CYBERDECK.md](CYBERDECK.md#batteries));
  - hardware switches for the Wi-Fi, GNSS receiver, LoRa transmitter and microphone ([CYBERDECK.md](CYBERDECK.md#hardware-switches));
  - a LoRa radio on the device's board for 868 MHz, with its antenna ([LORA.md](LORA.md));
  - the screen, keyboard, knobs and gauges, and how long the slide must last.
- Note which of the conditions in FoxieOS's decision D9 each requirement meets.

**Finished when** the list exists, every requirement gives its reason and source, and the maintainer has reviewed it.
**Share** the open questions the list raises.

### T2: development board bring-up

Getting the cyber-deck's compute module running on the bench.
**Hands-on.** Needs task T1, and the maintainer to buy the boards.

- A Raspberry Pi Compute Module 5 on Raspberry Pi's IO board ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)), running Raspberry Pi OS until FoxieOS has an image for it.
- Connect a touchscreen and check the touch, the screen turning a quarter, and the brightness control.
- Check the pins the cyber-deck needs: SPI for the LoRa radio, I2C or UART for the GNSS receiver, and spare pins for the knobs and switches.
- Practise secure-boot fusing only on a board bought for that purpose, with the maintainer's go-ahead for each step (check C17 first).
- Record the work in `docs/bench/cm5.md`: what worked, what didn't, and the current drawn when idle and under load.

**Finished when** the module starts with the screen and the pins above working, and the record is committed.
**Share** the record and the measurements.

### T3: cellular module evaluation kit

On hold until decision D2 chooses a mobile network for a later device; the cyber-deck is Wi-Fi only.
When it resumes:
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

Trying the LoRa radio design on the bench.
**Hands-on.** Needs tasks T1 and T2, decision D4 and checks C10 and C11, and the maintainer to buy the LoRa boards.

- Connect an SX1262 LoRa board to the task T2 board's SPI pins, run `meshtasticd`, and send messages to another Meshtastic device on 868 MHz, with the antenna always connected.
- Then connect a small board with an SX1262, such as an nRF52840 or ESP32-S3 board that Meshtastic and MeshCore support, by UART or USB, and do the same with each network.
- Measure the current the whole device draws while it passes on messages, in each design, with the compute module idle.
- Record the work in `docs/bench/lora.md`.

**Finished when** messages pass in both designs, or the record says why not.
**Share** the results, the current measured in each design, and which the record recommends for the cyber-deck.

### T7: cyber-deck bench build

Wiring the proposed [cyber-deck](CYBERDECK.md)'s electronics together on the bench, to see whether they work before a board of the project's own is designed.
**Hands-on.** Needs tasks T2 and T6 and checks C13, C14 and C16, and the maintainer to buy the parts.
Decision D6 sets which operating system it runs; Linux is enough to test the hardware.

- Add a USB Wi-Fi adapter and a GNSS receiver, and share the device's position over the mesh.
- Wire one hardware switch for each part, and check with a meter that a switched-off part draws no current, including through its data lines.
- Wire two 18650 bays through a power-path controller, pull each cell in turn while the board runs, and measure the current drawn when idle, when sending over LoRa and when using Wi-Fi.
- Wire two rotary knobs, a keyboard grid read by a small microcontroller, and one signal gauge of each kind (decision D7).
- Record the work in `docs/bench/cyberdeck.md`, with the parts used, a wiring diagram and the measurements.

**Finished when** messages and positions pass over LoRa, every switch cuts its part fully, and pulling either battery doesn't restart the board, or the record says why not.
**Share** the measurements, the battery life they imply, and what would change on a board of the project's own.

### T8: case and slide mock-up

Building the case and the sliding screen without electronics, to see whether the shape works in the hand.
**Hands-on.** Needs task T1 and decisions D7 and D8; can run alongside task T7.

- Model the case from the concept renders, with the screen, keyboard, battery bays, antenna, knobs, gauges and handles at their real sizes.
- Print it, fit a dummy screen on rails, and slide it at least a few hundred times with a flat cable of the kind the screen would use (check C15).
- Weigh it with two cells in, and let members who didn't design it hold it, type on it and swap a battery.
- Place the hardware switches.

**Finished when** the mock-up slides, locks in both positions, takes both cells, and members can use it with one hand upright and two hands sideways.
**Share** the model files, photos, the weight, the cable's state after the slides, and what members found awkward.

### T9: carrier board

Designing the cyber-deck's own board around the Compute Module 5.
**Code and hands-on.** Needs tasks T7 and T8, decision D1, and the maintainer's approval to order boards.

- Start from Raspberry Pi's published IO-board design, and the uConsole's published files where their licence allows ([CYBERDECK.md](CYBERDECK.md#cyber-decks-that-already-exist)).
- Put the LoRa radio, GNSS receiver, power path for two cells, charger, switches, keyboard controller and gauge drivers on it, shaped to the mock-up's case.
- Order a few boards, and repeat task T7's measurements on them.

**Finished when** the board runs the bench build's tests in the mock-up's case.
**Share** the design files, the measurements, and the cost of one board.

## Order of the critical work

The longest chains of work, where each step waits for the one before:

- T1 → T2 → T6 → T7;
- at the same time, T1 → D7 and D8 → T8;
- T7 and T8 → D1 → T9;
- check C12 → D3, and D5 → D1 and D3.

Task T3 waits on decision D2; tasks T4 and T5 on decision D5.

## Not planned

- **A phone designed directly with a chip maker** ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).
- **Work on a particular operating system.**
  Supporting the device is each operating-system project's own work; for FoxieOS, it is decided in its decision D9.
- **A phone, for now.**
  Decision D2 keeps the question open for a later device; the research stays in [FEASIBILITY.md](FEASIBILITY.md).

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
9. **C9, board details** (→ only if a RISC-V or other Arm board is bought).
   Before buying such a board, confirm for the boards in [BOARDS.md](BOARDS.md):
   - their current prices and availability, and whether anyone can buy the Alibaba A210 EVB;
   - whether SpacemiT and Alibaba document secure boot for the K3 and the A210, and whether that documentation is public;
   - what works in RISE's Android 17 release beyond what it states: audio, video, the camera, Android's security rules (SELinux) switched on, and a secure area (TEE);
   - whether Google has a RISC-V GKI version or a newer statement than its 2025 status, and where the SpacemiT K1's Android 16 BSP comes from;
   - whether downloading NXP's code-signing tool (CST) needs an account, and whether the licence of NXP's closed source package lets the project publish what it builds;
   - whether BeaglePlay's AM625 chip is a GP or an HS-FS version, and how TI provides its key-writing tool;
   - which Android version BayLibre's AOSP kit for the MediaTek Genio boards is on.
10. **C10, LoRa hardware and band rules** (→ D4, T6).
    Confirm that Meshtastic and MeshCore both support the same nRF52840 or ESP32-S3 boards with an SX1262, and which certified LoRa modules would fit the device's board.
    Read the current ETSI EN 300 220 for the 868 MHz sub-band edges, power and duty-cycle limits, and FCC Part 15 for 915 MHz.
11. **C11, mesh apps and licences** (→ D4, T6).
    Whether the Meshtastic and MeshCore Android apps connect over a USB cable as well as Bluetooth, the licences of the MeshCore apps, whether MeshCore has closed parts, and the exact terms of the Reticulum licence.
12. **C12, prototypes and the market rules** (→ D3, D5).
    Whether building prototypes for the maintainers' own use, publishing the design files, or handing devices to other enthusiasts for free or at cost counts as putting them on the EU market under the Radio Equipment Directive, the ecodesign and battery rules and the Cyber Resilience Act.
    Start from the European Commission's Blue Guide on EU product rules, and confirm the result with a lawyer before any device leaves the maintainers' hands.
13. **C13, cyber-deck power** (→ T7).
    Read the power-supply section of Raspberry Pi's hardware documentation for the Pi 5's and the CM5's exact supply needs and USB current limits, and whether they can sleep.
    Then pick a converter from an 18650 cell to 5 V that meets them.
14. **C14, cyber-deck switches and position** (→ T7).
    How to cut a part fully, including its data lines, so it isn't powered through them, for the SPI LoRa radio, a USB adapter, a GNSS receiver and a microphone.
    Whether `meshtasticd` on Linux can read a GNSS receiver and share its position.
15. **C15, the sliding screen's cable** (→ T8).
    Which flat cables, or flexible circuits, screens of the chosen size use, how many bends they are rated for, and how sliding phones with a keyboard routed theirs.
16. **C16, two-cell power path** (→ T7).
    A power-path controller that runs the device from either of two 18650 cells and lets one be pulled without a restart, a charger for each cell, and protection against a cell put in backwards.
17. **C17, the secure-boot key on a CM5** (→ T2).
    From Raspberry Pi's security documentation: what exactly the key written into the chip signs, whether a second key can ever be added, and what an owner can still change on a fused board.
