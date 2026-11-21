# FoxieOS hardware roadmap

What is decided, what is still open, and the work in the order it should happen.
Background: [FEASIBILITY.md](FEASIBILITY.md) for the research, [DESIGN.md](DESIGN.md) for how the project is set up.

## Where things stand

- **Done:** task T0, the research and this repository, on 2026-11-20.
- **Decided:** the project is separate from FoxieOS, and lives in the `alopex-org` GitHub organization ([DESIGN.md](DESIGN.md#key-decisions)).
  The project builds a prototype for enthusiasts, not a product, and sells nothing ([DESIGN.md](DESIGN.md#a-prototype-not-a-product)).
  The device has a built-in LoRa mesh radio ([LORA.md](LORA.md)).
- **Next:** task T1, the hardware requirements.
  It needs no decision and no money.

## How to read this file

- **Decisions (D1–D4)** are the maintainer's to make.
  Each one lists the options and a recommendation.
- **Tasks (T0–T6)** are the work, in order.
  Each one says what it needs, what to do, when it is done, and what to report.
- **Checks (C1–C12)** are claims to confirm before the task that depends on them.
  A ⚠ in the other docs usually points to one of them.
- Each task says who does it:
  - **Code:** a change to files, made in a pull request.
    Anyone can do it, including a coding agent.
  - **Hands-on:** work on a board, a module or a device.
    The maintainer runs it, or approves each step.
  - **Maintainer only:** contacting companies, agreements, purchases, money and keys.
    Coding agents may draft documents for these steps, but never send or sign them.

## Phases

1. **Requirements:** what a device must offer (T1).
2. **Bench work:** an Android build on a development board, then on a cellular module's evaluation kit (T2, T3).
3. **A prototype:** decisions D1–D3, taken on the evidence from the first two phases, then a prototype built in small numbers for enthusiasts.

## Decisions

| ID | Question | Status | Needed by |
|---|---|---|---|
| [D1](#d1-route-to-a-prototype) | How is the prototype built: around a cellular module, or around a development board? | Open | A prototype |
| [D2](#d2-cellular-or-wi-fi-only) | Is the first device a cellular phone, or Wi-Fi only? | Open | D1 |
| [D3](#d3-sharing-prototypes) | Do prototypes stay with the maintainers, or reach other enthusiasts, and how? | Open | D1 |
| [D4](#d4-lora-mesh-network) | Which LoRa mesh network does the device ship: Meshtastic, MeshCore or both? | Open | T6 |

### D1: route to a prototype

Open; needed before a prototype is built.

- **Options:** the routes in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device) that don't lead to a product:
  - a main board of the project's own around a cellular module;
  - a development board in a case of the project's own, for a Wi-Fi-only prototype.
- A partnership and an ODM phone are routes to a product, so they aren't options ([DESIGN.md](DESIGN.md#a-prototype-not-a-product)).
- **Recommendation:** decide after tasks T1–T3.
  - Around a cellular module, if T3 finds it technically viable.
  - Otherwise around a development board.
  - Never a phone designed directly with a chip vendor.

### D2: cellular or Wi-Fi only

Open; needed by D1.

- A **Wi-Fi-only device**, such as a tablet, needs no cellular module, carrier approval or cellular patent licences.
- A **cellular phone** is what most people mean by a phone, and costs more at every step.
- **Recommendation:** decide on the evidence from T2 and T3.
  A Wi-Fi-only device is the cheaper first prototype.

### D3: sharing prototypes

Open; needed by D1.

The project sells nothing, but whoever places a device on the market carries the certification, patent and EU duties ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).
⚠ Whether handing a prototype to someone counts as placing it on the market is not confirmed (check C12).

- **Options:**
  - prototypes stay with the maintainers, who build and keep them;
  - the design files are published, and other enthusiasts build their own;
  - the project builds a few extra units and hands them to other enthusiasts.
- **Recommendation:** the first two together, with the third only if check C12 shows it brings no manufacturer's duties.

### D4: LoRa mesh network

Open; needed by T6.

- **Options** ([LORA.md](LORA.md#the-mesh-networks)):
  - **Meshtastic:** the largest network, GPL-3.0, with flooding that needs no planning but uses more airtime.
  - **MeshCore:** MIT, with routing through repeaters that scales better where they exist.
  - **Both:** hardware either firmware runs on, with one as the default and the other flashable by the user.
  - **Reticulum:** the most general, but its licence keeps it out of Debian and F-Droid.
- **Recommendation:** both, with Meshtastic as the default for its larger user base, if check C10 confirms that one LoRa design runs both firmwares.

## Tasks

Work in order unless the dependencies allow otherwise.

### T0: research and repository

Done 2026-11-20: this repository, with the research in [FEASIBILITY.md](FEASIBILITY.md).

### T1: hardware requirements

**Code.** Can start now.

- Write `docs/REQUIREMENTS.md`: what a device must offer, each requirement with its reason and source.
  GrapheneOS's published device requirements are a model (C1).
- Cover at least:
  - secure boot with the manufacturer's own key, and relocking with a custom AVB key, documented by the maker ([DESIGN.md](DESIGN.md#each-party-keeps-its-own-keys));
  - the support period for the modem, TEE and GPU firmware, in years from the chip's launch;
  - a kernel on a supported GKI branch;
  - bootloader unlocking and relocking that the project controls;
  - repair access and a battery the user can replace;
  - privacy features, such as hardware switches for the microphone, cameras, modem and LoRa transmitter;
  - a LoRa radio on the device's board for 868 MHz and 915 MHz, with the mesh running while the phone sleeps ([LORA.md](LORA.md)).
- Note which of the conditions in FoxieOS's decision D9 each requirement meets.

**Done when** the list exists, every requirement gives its reason and source, and the maintainer has reviewed it.
**Report** the open questions the list raises.

### T2: development board bring-up

**Hands-on.** Needs T1 and check C9, and the maintainer to buy the boards.

- Pick the boards from [BOARDS.md](BOARDS.md), which compares the candidates with a focus on RISC-V.
  It proposes the SpacemiT K3 Pico-ITX for the Android bring-up, and an NXP i.MX 95 board alongside for verified-boot and secure-boot practice.
- Build Android for it in the background, logging to `logs/<date>-<job>.log`, and boot it.
- Try verified boot with a dev key, never a key that will sign anything published.
- Practise secure-boot fusing only on a board bought for that purpose, with the maintainer's go-ahead for each step.
- Record the work in `docs/bench/<board>.md`: the time it took, the BSP's Android and kernel versions, and what blocked progress.

**Done when** the board boots an Android build made by the project, and the record is committed.
**Report** a summary of the build log, the boot result and the record.

### T3: cellular module evaluation kit

**Hands-on.** Needs T2 and checks C4 and C5, and the maintainer to buy the kit and sign up for any vendor portal.

- Evaluate one cellular module with an Android BSP on its evaluation kit.
- Record in `docs/bench/<module>.md`:
  - the Android version and kernel it ships, and how far they are from a current release;
  - what secure-boot provisioning involves;
  - which of the module's certifications would carry over to a finished device.

**Done when** a written assessment says whether a module-based design is technically viable.
**Report** the assessment.

### T4: partner survey

Dropped 2026-11-21: a partnership with a phone maker is a route to a product ([DESIGN.md](DESIGN.md#a-prototype-not-a-product)).

### T5: ODM quotes

Dropped 2026-11-21: an ODM phone is a route to a product ([DESIGN.md](DESIGN.md#a-prototype-not-a-product)).

### T6: LoRa bench work

**Hands-on.** Needs T1, D4 and checks C10 and C11, and the maintainer to buy a LoRa development board. Can run alongside T2.

- Connect a microcontroller board with an SX1262, such as an nRF52840 or ESP32-S3 board that Meshtastic and MeshCore support, to the T2 board over UART or USB.
- Flash Meshtastic and MeshCore firmware on it in turn, and message another node from the Android build through each network's app over the wired link.
- Measure the board's current while relaying with the Android side asleep.
- Record the work in `docs/bench/lora.md`.

**Done when** messages pass over the wired link with both firmwares, or the record says why not.
**Report** the results, the current measured and anything the apps lacked over a wired link.

## Critical path

T1 → T2 → T3, and in parallel T1 → D4 → T6, with check C12 → D3.
The lines end in D2, D3 and then D1.

## Not planned

- **A phone designed directly with a chip vendor** ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).
- **Selling devices:** no production runs, pre-orders, crowdfunding or company of the project's own ([DESIGN.md](DESIGN.md#a-prototype-not-a-product)).
- **A partnership with a phone maker, or an ODM phone,** which are routes to a product.
- **Work on a particular operating system.**
  Supporting a device is each OS project's own work; for FoxieOS, it is decided in its decision D9.

## Checks

Each check is a short task.
Do it before the task that depends on it, then update the docs that carry the ⚠.

1. **C1, GrapheneOS and Motorola** (→ T1).
   Read GrapheneOS's published hardware requirements on grapheneos.org, and confirm there whether the Motorola Signature 27 is supported.
2. **C2, EU ecodesign details** (→ C12).
   Read Regulation (EU) 2023/1670 and its 2025/2006 amendment for the exact update, spare-part and battery-durability duties.
3. **C3, battery removability** (→ C12).
   Whether smartphones fall under Delegated Regulation (EU) 2026/1770, or under the durability exemption in Article 11 of the Batteries Regulation.
4. **C4, module BSPs** (→ T3).
   The current Android version of the Quectel SG560D and similar modules, and the terms for getting the BSP.
5. **C5, Qualcomm's signing tools and BSP** (→ T3).
   What a licence for Qualcomm's SecTools involves, and whether a small buyer can get one.
   How Qualcomm and the board makers distribute the Android BSP for QCS6490 boards, and on what terms.
   Whether Thundercomm publishes an Android image for the RUBIK Pi 3, and the board's price.
6. **C6, costs** (→ D1, D2).
   Current prices of the modules, boards and memory a prototype needs.
7. **C7, EU cybersecurity dates** (→ C12).
   Whether the repeal of RED delegated act 2022/30 was adopted, and whether the Cyber Resilience Act dates changed.
8. **C8, small makers** (background).
   Whether the Liberux NEXX shipped, and whether Pine64 resumed production.
9. **C9, board details** (→ T2).
   Before buying a board, confirm for the boards proposed in [BOARDS.md](BOARDS.md):
   - their current prices and availability, and whether anyone can buy the Alibaba A210 EVB;
   - whether SpacemiT and Alibaba document secure boot for the K3 and the A210, and whether that documentation is public;
   - what works in RISE's Android 17 release beyond what it states: audio, video, the camera, SELinux enforcing mode and a TEE;
   - whether Google has a RISC-V GKI branch or a later statement than its 2025 status, and the source of the SpacemiT K1's Android 16 BSP;
   - whether NXP's code-signing tool (CST) download needs an account, and whether the licence of NXP's proprietary source package lets the project publish what it builds;
   - whether BeaglePlay's AM625 is a GP or an HS-FS part, and how TI provides its keywriter.
   - which Android version BayLibre's AOSP SDK for the MediaTek Genio boards is on.
10. **C10, LoRa hardware and band rules** (→ D4, T6).
    Confirm that Meshtastic and MeshCore both support the same nRF52840 or ESP32-S3 boards with an SX1262, and which certified LoRa modules would fit a phone's board.
    Read the current ETSI EN 300 220 for the 868 MHz sub-band edges, power and duty-cycle limits, and FCC Part 15 for 915 MHz.
11. **C11, mesh apps and licences** (→ D4, T6).
    Whether the Meshtastic and MeshCore Android apps connect over USB serial as well as Bluetooth, the licences of the MeshCore apps, whether MeshCore has closed parts, and the exact terms of the Reticulum licence.
12. **C12, prototypes and the market rules** (→ D3).
    Whether building prototypes for the maintainers' own use, publishing the design files, or handing units to other enthusiasts free or at cost counts as placing them on the EU market under the Radio Equipment Directive, the ecodesign and battery rules and the Cyber Resilience Act.
    Start from the European Commission's Blue Guide on the implementation of EU product rules, and confirm the result with a lawyer before any unit leaves the maintainers' hands.
