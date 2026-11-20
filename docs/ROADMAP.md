# FoxieOS hardware roadmap

What is decided, what is still open, and the work in the order it should happen.
Background: [FEASIBILITY.md](FEASIBILITY.md) for the research, [DESIGN.md](DESIGN.md) for how the project is set up.

## Where things stand

- **Done:** task T0, the research and this repository, on 2026-11-20.
- **Decided:** the project is separate from FoxieOS, and lives in the `alopex-org` GitHub organization ([DESIGN.md](DESIGN.md#key-decisions)).
- **Next:** task T1, the hardware requirements.
  It needs no decision and no money.

## How to read this file

- **Decisions (D1–D3)** are the maintainer's to make.
  Each one lists the options and a recommendation.
- **Tasks (T0–T5)** are the work, in order.
  Each one says what it needs, what to do, when it is done, and what to report.
- **Checks (C1–C9)** are claims to confirm before the task that depends on them.
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
3. **Partners and quotes:** a survey of phone makers, and quotes from ODMs (T4, T5).
4. **A route to a product:** decisions D1–D3, taken on the evidence from the first three phases.

## Decisions

| ID | Question | Status | Needed by |
|---|---|---|---|
| [D1](#d1-route-to-a-product) | How does a device get made: partnership, ODM phone or module-based design? | Open | A product |
| [D2](#d2-cellular-or-wi-fi-only) | Is the first device a cellular phone, or Wi-Fi only? | Open | D1 |
| [D3](#d3-manufacturer) | Who is the manufacturer: a partner, or a company of the project's own? | Open | T5, D1 |

### D1: route to a product

Open; needed before any product.

- **Options:** the routes in [FEASIBILITY.md](FEASIBILITY.md#routes-to-a-device).
- **Recommendation:** decide after tasks T1–T4.
  - A partnership, if a phone maker accepts the requirements.
  - Otherwise an ODM phone, if D3 gives a manufacturer and there is funding for a minimum order.
  - A module-based design only with funding for certification and the EU duties.
  - Never a phone designed directly with a chip vendor.

### D2: cellular or Wi-Fi only

Open; needed by D1.

- A **Wi-Fi-only device**, such as a tablet, avoids cellular certification, carrier approval and cellular patent licences.
  The EU ecodesign rules still apply to slate tablets ([FEASIBILITY.md](FEASIBILITY.md#eu-ecodesign-rules)).
- A **cellular phone** is what most people mean by a phone, and costs more at every step.
- **Recommendation:** decide on the evidence from T2 and T3.
  A Wi-Fi-only device is the cheaper first product.

### D3: manufacturer

Open; needed by T5 and D1.

Whoever places the device on the market carries the certification, patent and EU duties ([FEASIBILITY.md](FEASIBILITY.md#certification-patents-and-eu-rules)).

- **Options:**
  - a partner, which is the manufacturer in a partnership;
  - a company of the project's own, which needs funding for a minimum order and the means to supply updates and spare parts for the periods the EU requires.
- **Recommendation:** a partner, unless T4 finds none willing.

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
  - the support period for the modem, TEE and GPU firmware, in years from launch, against the EU's five years after the last unit is sold (C2);
  - a kernel on a supported GKI branch;
  - bootloader unlocking that keeps the warranty;
  - spare parts, repair access and a battery the user can replace, as the EU rules require (C2, C3);
  - privacy features, such as hardware switches for the microphone, cameras and modem.
- Note which of the conditions in FoxieOS's decision D9 each requirement meets.

**Done when** the list exists, every requirement gives its reason and source, and the maintainer has reviewed it.
**Report** the open questions the list raises.

### T2: development board bring-up

**Hands-on.** Needs T1 and check C9, and the maintainer to buy the board.

- Pick one board from [BOARDS.md](BOARDS.md), which compares the candidates and proposes an NXP i.MX 95 board, with BeaglePlay as the cheaper alternative.
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

**Code** for the survey; **maintainer only** for any contact. Needs T1.

- Survey phone makers that already work with other operating systems against the T1 list, from public sources: Fairphone, SHIFT, Motorola, Volla and any newer ones.
- Record in `docs/PARTNERS.md` what each offers, and what it asks of an OS or hardware partner, with sources and the date checked.
- The maintainer decides whether to contact any of them.

**Done when** the survey is committed.
**Report** which makers look open to a partnership, and why.

### T5: ODM quotes

**Maintainer only.** Needs T1 and D3.

- Ask two or three ODMs for quotes against the contract terms in [FEASIBILITY.md](FEASIBILITY.md#odm-phone): BSP source, control of the keys, the firmware support period and spare parts.
- Keep confidential terms out of this repository; record only summaries the maintainer agrees to.

**Done when** the ODM route has real cost ranges in place of the marketplace figures in FEASIBILITY.md.
**Report** the cost ranges, without confidential details.

## Critical path

T1 → T2 → T3, and in parallel T1 → T4 → D3 → T5.
Both lines end in D2 and then D1.

A willing partner found in T4 can make T5 unnecessary.

## Not planned

- **A phone designed directly with a chip vendor** ([FEASIBILITY.md](FEASIBILITY.md#chip-vendor-design)).
- **Production or pre-orders** before D1–D3 are decided.
- **Work on a particular operating system.**
  Supporting a device is each OS project's own work; for FoxieOS, it is decided in its decision D9.

## Checks

Each check is a short task.
Do it before the task that depends on it, then update the docs that carry the ⚠.

1. **C1, GrapheneOS and Motorola** (→ T1, T4).
   Read GrapheneOS's published hardware requirements on grapheneos.org, and confirm there whether the Motorola Signature 27 is supported.
2. **C2, EU ecodesign details** (→ T1).
   Read Regulation (EU) 2023/1670 and its 2025/2006 amendment for the exact update, spare-part and battery-durability duties.
3. **C3, battery removability** (→ T1).
   Whether smartphones fall under Delegated Regulation (EU) 2026/1770, or under the durability exemption in Article 11 of the Batteries Regulation.
4. **C4, module BSPs** (→ T3).
   The current Android version of the Quectel SG560D and similar modules, and the terms for getting the BSP.
5. **C5, Qualcomm's signing tools and BSP** (→ T3).
   What a licence for Qualcomm's SecTools involves, and whether a small buyer can get one.
   How Qualcomm and the board makers distribute the Android BSP for QCS6490 boards, and on what terms.
6. **C6, costs** (→ D1).
   Current certification quotes from an accredited lab (FCC, CE, PTCRB, GCF and SAR), and current memory prices.
7. **C7, EU cybersecurity dates** (→ D3).
   Whether the repeal of RED delegated act 2022/30 was adopted, and whether the Cyber Resilience Act dates changed.
8. **C8, small makers** (→ T4).
   Whether the Liberux NEXX shipped, and whether Pine64 resumed production.
9. **C9, board details** (→ T2).
   Before buying a board, confirm for the boards proposed in [BOARDS.md](BOARDS.md):
   - their current prices and availability;
   - where NXP documents AHAB secure boot for the i.MX 95, and whether NXP's source download needs an account;
   - whether BeaglePlay's AM625 is an HS-FS part that can be fused, and how TI provides its keywriter;
   - which GPU driver TI's Android build uses.
