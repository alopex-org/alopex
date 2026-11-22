# FoxieOS hardware roadmap

This page lists what is decided, what is still open, and the work in the order it should happen.
Background: [FEASIBILITY.md](FEASIBILITY.md) for the research, [DESIGN.md](DESIGN.md) for how the project is set up.
Technical words are explained in the [glossary](GLOSSARY.md).

## Where things stand

- **Done:** task T0, the research and this repository, on 2026-11-20.
- **Decided:** the project is separate from FoxieOS, and lives in the `alopex-org` GitHub organization ([DESIGN.md](DESIGN.md#key-decisions)).
  The device has a built-in LoRa mesh radio ([LORA.md](LORA.md)).
- **Founding meeting, 2026-11-24:** the members choose the maintainers, who decide the project's foundations together ([governance](https://github.com/alopex-org/.github/blob/main/GOVERNANCE.md#founding-maintainers)).
  One interim maintainer decided everything marked decided here, so the meeting confirms or changes it.
  The meeting also takes decision D5: a prototype only, or a product.
- **Next:** task T1, the hardware requirements.
  It needs no decision and no money.

## How to read this page

- **Decisions (D1–D5)** are questions the maintainers answer.
  Each one lists the options and a recommendation.
- **Tasks (T0–T6)** are the pieces of work, in order.
  Each one says what it needs first, what to do, when it is finished, and what to share afterwards.
- **Checks (C1–C12)** are facts to confirm before the task that relies on them.
  A ⚠ in the other docs usually points to one of them.
- **On GitHub,** each decision, task and check also has an issue, and each phase below is a [milestone](https://github.com/alopex-org/foxieos-hardware/milestones).
  This page is the plan; the issues track progress and discussion ([CONTRIBUTING.md](../CONTRIBUTING.md#issues-and-labels)).
- **Who does each task:**
  - **Code:** a change to files, made in a pull request.
    Anyone can do it.
  - **Hands-on:** work on a board, a module or a device.
    The maintainer does it, or approves each step.
  - **Maintainer only:** contacting companies, agreements, purchases, money and keys.
    Others may draft the documents for these steps, but only the maintainer sends or signs them.

## Phases

1. **Requirements:** what a device must offer (T1).
2. **Bench work:** getting Android running on a development board, then on a cellular module's evaluation kit (T2, T3).
3. **A prototype:** decisions D1–D3, taken on what the first two phases show, then a prototype built in small numbers.
   Whether a product follows is decision D5.

## Decisions

| ID | Question | Status | Needed by |
|---|---|---|---|
| [D1](#d1-route-to-a-prototype) | How is the prototype built: around a cellular module, or around a development board? | Open | A prototype |
| [D2](#d2-cellular-or-wi-fi-only) | Is the first device a mobile phone, or Wi-Fi only? | Open | D1 |
| [D3](#d3-sharing-prototypes) | Do prototypes stay with the maintainers, or reach other enthusiasts, and how? | Open | D1 |
| [D4](#d4-lora-mesh-network) | Which LoRa mesh network does the device come with: Meshtastic, MeshCore or both? | Open | T6 |
| [D5](#d5-prototype-or-product) | Does the project stop at a prototype, or aim at a product it sells? | Open: founding meeting | D1, D3, T4, T5 |

### D1: route to a prototype

How the prototype is built.
Open; needed before a prototype is built.

- **Options:** the routes in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device) that suit a prototype:
  - a main board of the project's own, around a cellular module;
  - a development board in a case of the project's own, for a Wi-Fi-only prototype.
- Working with a phone maker, and having an ODM build a phone, are routes to a product, and become options only if decision D5 chooses one ([DESIGN.md](DESIGN.md#prototype-or-product)).
- **Recommendation:** decide after tasks T1–T3.
  - Around a cellular module, if task T3 finds that it can work.
  - Otherwise around a development board.
  - Never a phone designed directly with a chip maker.

### D2: cellular or Wi-Fi only

Whether the first device connects to mobile networks.
Open; needed by D1.

- A **Wi-Fi-only device**, such as a tablet, needs no cellular module, no approval from mobile networks and no mobile-network patent licences.
- A **mobile phone** is what most people mean by a phone, and costs more at every step.
- **Recommendation:** decide on what tasks T2 and T3 show.
  A Wi-Fi-only device is the cheaper first prototype.

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

## Tasks

Work in this order, unless a task's needs allow another.

### T0: research and repository

Done 2026-11-20: this repository, with the research in [FEASIBILITY.md](FEASIBILITY.md).

### T1: hardware requirements

The list of what a device must offer.
**Code.** Can start now.

- Write `docs/REQUIREMENTS.md`: what a device must offer, each requirement with its reason and source.
  GrapheneOS's published device requirements are a model (check C1).
- Cover at least:
  - secure boot with the builder's own key, and relocking with an owner-installed AVB key, documented by the maker ([DESIGN.md](DESIGN.md#each-party-keeps-its-own-keys));
  - how many years the modem, secure-area (TEE) and graphics firmware get fixes, counted from the chip's launch;
  - a kernel on a GKI version that still gets updates;
  - bootloader unlocking and relocking that the project controls;
  - repair access and a battery the user can replace;
  - privacy features, such as hardware switches for the microphone, cameras, modem and LoRa transmitter;
  - a LoRa radio on the device's board for 868 MHz and 915 MHz, with the mesh running while the phone sleeps ([LORA.md](LORA.md)).
- Note which of the conditions in FoxieOS's decision D9 each requirement meets.

**Finished when** the list exists, every requirement gives its reason and source, and the maintainer has reviewed it.
**Share** the open questions the list raises.

### T2: development board bring-up

Getting Android running on a development board.
**Hands-on.** Needs task T1 and check C9, and the maintainer to buy the boards.

- Pick the boards from [BOARDS.md](BOARDS.md), which compares the candidates, mainly RISC-V boards.
  It proposes the SpacemiT K3 Pico-ITX for getting Android running, and an NXP i.MX 95 board alongside it to practise verified boot and secure boot.
- Build Android for it and start it.
  A build takes hours, so keep the build log.
- Try verified boot with a dev key, never a key that will sign anything published.
- Practise secure-boot fusing only on a board bought for that purpose, with the maintainer's go-ahead for each step.
- Record the work in `docs/bench/<board>.md`: how long it took, the Android and kernel versions of the chip maker's software (BSP), and what got in the way.

**Finished when** the board starts an Android build made by the project, and the record is committed.
**Share** a summary of the build log, the start-up result and the record.

### T3: cellular module evaluation kit

Trying a cellular module on its evaluation kit.
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
**Hands-on.** Needs task T1, decision D4 and checks C10 and C11, and the maintainer to buy a LoRa development board.
Can run alongside task T2.

- Connect a small board with an SX1262 LoRa chip, such as an nRF52840 or ESP32-S3 board that Meshtastic and MeshCore support, to the task T2 board by UART or USB.
- Install Meshtastic and MeshCore on it in turn, and send messages to another device from the Android build, through each network's app, over the cable.
- Measure how much current the LoRa board draws while passing on messages with the Android side asleep.
- Record the work in `docs/bench/lora.md`.

**Finished when** messages pass over the cable with both networks' software, or the record says why not.
**Share** the results, the current measured, and anything the apps couldn't do over a cable.

## Order of the critical work

The longest chains of work, where each step waits for the one before:

- T1 → T2 → T3;
- at the same time, T1 → D4 → T6;
- check C12 → D3, and D5 → D1 and D3.

They come together in D2, D3 and then D1.

## Not planned

- **A phone designed directly with a chip maker** ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).
- **Work on a particular operating system.**
  Supporting a device is each operating-system project's own work; for FoxieOS, it is decided in its decision D9.

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
