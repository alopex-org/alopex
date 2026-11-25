# Alopex feasibility study

This is the research behind the plan.
It asks whether a small team can build a prototype phone, or a similar device, for an operating system based on Android, which way it could go about it, and what that takes.
The project builds a prototype first, then a product ([DESIGN.md](DESIGN.md#prototype-or-product), roadmap decision D5), so this page covers the routes to both.
The plan that follows from it is in [ROADMAP.md](ROADMAP.md) and [DESIGN.md](DESIGN.md).
Technical words are explained in the [glossary](GLOSSARY.md).

**Since 2026-11-24** the project works toward a cyber-deck, confirmed at the founding meeting: user-serviceable, with LoRa and Wi-Fi, pocket-sized if possible, and running a Linux distribution for now; its main board and other parts are undecided ([CYBERDECK.md](CYBERDECK.md)).
This research was done for a phone; it applies to the cyber-deck wherever the cyber-deck would share a part, a route or a rule with a phone.

**How to read it:**

- Sources were checked on 2026-11-20.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists every source with what it supports.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it.
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.
- Costs are rough sizes ("tens of thousands"), not quotes.
- Nothing here is legal advice.
  A lawyer must confirm the rules before any prototype leaves the maintainers' hands, and a lawyer and an accredited test lab before any device is sold.

## Summary

| Goal | Possible? |
|---|---|
| A phone designed from the chip up by a small team | No |
| A phone made together with an existing phone maker | Yes, if a maker agrees; this is a product (decision D5) |
| An Android build on a development board | Yes, cheaply |
| A phone made by an ODM and sold under the project's name | Only with a company and funding; this is a product (decision D5) |
| A prototype of the project's own design, built around a cellular module | Yes, in small numbers |
| System updates for as long as the EU requires of a product | Only with the chip maker's support |

The main findings:

- **Whoever sells the device is its manufacturer.**
  That party keeps the software for the hardware up to date, certifies the radios and pays the mobile-network patent licences.
  In the EU it must also supply system updates for at least five years after the last device is sold, and spare parts for seven.
  These duties shape every route to a product more than the engineering does, and are the main reason to consider a prototype that isn't sold (decision D5).
  ⚠ Whether handing a prototype to others counts as selling it in this sense is not confirmed (roadmap check C12).
- **The chip maker decides how long the device gets fixes.**
  Closed firmware for the modem, the secure area (TEE) and the graphics chip (GPU) gets security fixes only while the chip maker ships them.
- **The operating systems that got hardware of their own did it through partners.**
  /e/OS, iodéOS and GrapheneOS didn't design phones themselves ([Partnership](#partnership-with-a-phone-maker)).
  Most small companies that built their own phones shipped late, stopped or closed ([Earlier phone projects](#earlier-phone-projects)).

The recommendation:

1. Write down the hardware requirements first (roadmap task T1).
2. Learn to get Android running cheaply: on a development board, then on a cellular module's evaluation kit (tasks T2 and T3).
3. Only then choose how the prototype is built (decisions D1–D3).
4. Don't design a phone directly with a chip maker.
5. Take on a manufacturer's duties only when the project moves from the prototype to a product (decision D5).

## Terms

The technical terms used here (AVB, BSP, evaluation kit, GKI, ODM, NRE, RISC-V, SAR, secure boot, SEP, TEE and more) are explained in the [glossary](GLOSSARY.md).

## Routes to a device

The ways the project could get a device, from doing no hardware at all to designing a phone around a chip.

| Route | What the project does | Upfront cost | Verdict |
|---|---|---|---|
| [Existing phones](#existing-phones) | Nothing in hardware | One phone per developer | The baseline |
| [Partnership](#partnership-with-a-phone-maker) | Brings requirements and an OS to a phone maker | Engineering time | A product (decision D5) |
| [Development board](#development-board) | Ports Android to a board | Under a hundred to over a thousand dollars per board | First step; can carry a Wi-Fi-only prototype |
| [ODM phone](#odm-phone) | Has a phone made, and sells it | Tens to hundreds of thousands | A product (decision D5) |
| [Module-based design](#module-based-design) | Designs a device around a cellular module | Prototypes cost far less than a certified product | The prototype's route |
| [Chip-vendor design](#chip-vendor-design) | Designs a phone around a chip bought from the vendor | Millions | No |

Each section below explains the cost.

### Existing phones

The operating system runs on phones that other companies make and sell; the project makes no hardware.

- The phone maker decides the firmware, the support period and whether the bootloader can be relocked with a custom key.
- Pixels can be relocked with a custom key and get seven years of updates.
  Many other phones can't be relocked, or their makers don't say (unsourced).
- Some makers have closed bootloader unlocking: Samsung's One UI 8 removed the option, and Xiaomi restricts it under HyperOS.

This route needs no hardware project, so every other route has to offer something it can't.

Sources: [AOSP device state][aosp-device-state], [Pixel update policy][pixel-updates], [SamMobile][sammobile-oneui8], [Android Authority on Xiaomi][aa-xiaomi].

### Partnership with a phone maker

A company that already makes phones sells one with the project's operating system already installed, or builds a model to the project's requirements.
The partner stays the manufacturer, with the duties described under [Certification, patents and EU rules](#certification-patents-and-eu-rules).

What has been done before:

- **Fairphone and Murena.**
  Fairphone officially lets owners unlock the bootloader, and keeps the warranty afterwards.
  Murena sells the Fairphone (Gen. 6) with /e/OS already installed, and is its US distributor; it is sold there only with /e/OS.
- **SHIFT, Murena and NovaCustom.**
  Murena sells SHIFT's SHIFTphone 8 with /e/OS and a hardware switch for the camera and microphone.
  NovaCustom sells a SHIFTphone 8.1 with iodéOS, a choice that privacy and security reviewers raised concerns about.
  One phone design carries two operating systems, each sold by a different partner.
- **Motorola and GrapheneOS.**
  Motorola announced a long-term partnership with GrapheneOS at MWC on 2026-03-02.
  GrapheneOS set the hardware requirements, among them seven years of updates, memory tagging, use of a secure element and a top-end Snapdragon chip.
  ⚠ Secondary reports say the Motorola Signature 27, announced in September 2026, is the first supported phone; GrapheneOS hadn't published an official build at the time.
- **Volla and its makers.**
  Volla sells phones that partners build: Gigaset made the earlier models, and the Quintus comes from a maker Volla doesn't name.

What partners seem to look for, judging from these cases:

- an operating system that already ships and has users;
- clear hardware requirements: GrapheneOS's list set the specification for Motorola's phones;
- a security process the partner can rely on (unsourced);
- a niche the partner doesn't already serve with /e/OS, iodéOS, CalyxOS or GrapheneOS (unsourced).

**Cost:** mostly engineering time; possibly a share of revenue or of support costs, depending on the deal (unsourced).

**Verdict:** the best and least risky route to a product; decision D5 puts a product after the prototype.

Sources: [iFixit on the Fairphone 6][ifixit-fp6], [Fairphone support][fp-support], [Fairphone /e/OS][fp-eos], [Android Central][ac-murena-fp6], [Murena][murena-shift], [Privacy Guides][pg-shift], [9to5Google on Motorola][9to5-moto], [The Register on Motorola][reg-moto], [Notebookcheck][nbc-moto], [Android Authority on GrapheneOS's plans][aa-moto-plans], [Android Authority on the Signature 27][aa-sig27], [Gigaset blog][gigaset-volla], [Sailfish OS forum][sfos-quintus].

### Development board

A small computer board, or a chip maker's reference board, that runs Android.
It is a place to learn how to get Android running on new hardware, or the base of a device without a modem, such as a kiosk or a tablet.
[BOARDS.md](BOARDS.md) compares the boards in detail and proposes one for task T2.

| Board | Chip | Android | Notes |
|---|---|---|---|
| SpacemiT K3 Pico-ITX, Alibaba A210 EVB | SpacemiT K3, Alibaba A210 (RISC-V) | 17, developer release | RISE's release, built by BayLibre; not ready for products |
| NXP i.MX 8M Plus and i.MX 95 boards | i.MX 8M Plus, i.MX 95 | 17, on kernel 6.18 | NXP's own release |
| BeaglePlay | TI AM625 | 16, on kernel 6.12 | TI's release; certified open hardware |
| Raspberry Pi 5 | BCM2712 | 17, community build | One developer's build, not for commercial use |
| DragonBoard 845c, Qualcomm RB5, Khadas VIM3 | Various | From the board maker | AOSP's reference boards, not supported or tested in AOSP |
| Qualcomm QCS6490 boards | QCS6490 | 12 | Thundercomm's kit; Qualcomm documents Linux for its RB3 Gen 2 |
| Radxa Rock 5B | RK3588 | 12 | |
| Other RK3588 boards | RK3588 | 14, on kernel 6.1 | For example Advantech's BSP |

- **The project would write and maintain the device's files** (its device tree) on top of the board maker's software package (BSP).
  On Arm, only NXP's BSP is on the current Android release; the others are one or more releases behind.
  On RISC-V, Android 17 runs as a developer release on a kernel outside Google's shared kernel (GKI), which dropped RISC-V in 2024.
- **None of these boards has a mobile-network modem.**
- **Cost:** from under a hundred to over a thousand dollars per board, plus the work of getting Android onto it.

**Verdict:** a good first step, and enough for a Wi-Fi-only prototype.
A board teaches device-file, kernel and verified-boot work cheaply (unsourced), and a spare board can be fused for practice.
It covers none of a phone's own parts: the modem, cameras, battery and their certification.

Sources: [BOARDS.md](BOARDS.md#sources), [RISE Android 17 announcement][rise-android17], [Android Authority on RISC-V][aa-riscv], [AOSP reference boards][aosp-boards], [Qualcomm: Android on Dragonwing][qc-android-dw], [Qualcomm kernel docs][qc-kernel], [Thundercomm C6490 Development Kit][thundercomm-c6490], [Radxa support matrix][radxa-matrix], [Advantech RK3588 Android 14][advantech-rk3588], [NXP RN00201][nxp-rn00201], [TI Android 11.00.01 release notes][ti-android-1101], [OSHWA certificate for BeaglePlay][oshwa-beagleplay], [KonstaKANG AOSP 17][konstakang-aosp17], [Raspberry Pi Compute Module 5][rpi-cm5], [Raspberry Pi security architecture][rpi-security].

### ODM phone

An ODM, a factory that makes phones for other brands, builds an existing or slightly changed phone design, which the project sells under its own name with its own software.

What the project does:

- negotiates the contract, the minimum order and the price;
- gets its operating system running on the ODM's software package (BSP) and kernel, which usually cover one Android version (unsourced);
- arranges the certifications that the ODM's existing approvals don't cover;
- becomes the manufacturer in the EU, with every duty that brings.

What the contract should give the project (unsourced; these follow from the manufacturer's duties and the [software work](#software-work)):

- the kernel source code, which the GPL requires anyway, and the source code of the device's BSP;
- control of the secure-boot and verified-boot keys, or at least a documented way to relock with the project's own key;
- firmware and security updates for the modem, secure area (TEE) and graphics chip for as long as the project must supply system updates;
- the right to keep supplying spare parts for seven years after sales end.

**Cost:** ⚠ the only published figures come from marketplace buying guides, which sell to the same buyers:

- minimum orders from about 1,000 devices for white-label phones, about 5,000 for partly custom work and 10,000 or more for full ODM projects; large ODMs reportedly want 50,000 or more;
- one-off engineering (NRE) from about $15,000 to $350,000;
- prices per phone from about $85 for a basic 4G white-label phone to over $300 for a 5G phone developed together.

Memory prices rose sharply in 2026 because of demand from AI data centres, so these figures are probably low.

**Verdict:** possible only with a company, money for a minimum order, and buyers.
Even then, the ODM's update process decides the real support period.
It leads to a product, so it belongs after the prototype (decision D5).

Sources: [Alibaba smartphone ODM guide][alibaba-odm], [Alibaba guide to launching a phone brand][alibaba-brand], [IDC][idc-memory], [The Register on memory prices][reg-memory].

### Module-based design

The project designs its own main board and case around a "smart module": a small ready-made board with a processor, memory, storage and a mobile-network modem, sold with an Android software package (BSP).

Example: Quectel's SG560D uses the Qualcomm QCM6490 or QCS6490, the chip family of the Fairphone 5, with 5G and Wi-Fi 6E.
⚠ Quectel lists Android 12 on its product page and Android 12 or 13 in its specification.
How a customer gets the BSP, and on what terms, isn't public.

What the project does:

- designs the main board, the display and battery connections, the antennas and the case;
- brings the module's Android 12 or 13 BSP forward to a current Android release, or waits for the module maker to;
- certifies the finished device; the module's own approvals cover part of it, not all ([Radio and network certification](#radio-and-network-certification));
- carries every manufacturer duty, as for an ODM phone.

**Cost:** a certified product, with its hardware design, certification and moulds for a case, reaches the hundreds of thousands (unsourced estimate, built from the certification figures and the ODM engineering costs in this document).
A few hand-built prototypes cost far less, since they skip the certification and moulds a product needs (unsourced).

**Verdict:** the route for the prototype.
Start with the module's evaluation kit (task T3), then a main board of the project's own, built in small numbers.
Selling it as a product would need money for certification and the EU duties; under decision D5, the project takes them on only when it moves to a product.
A Wi-Fi-only device, such as a tablet, needs no cellular module or mobile-network patent licences.

Sources: [Quectel SG560D][quectel-sg560d], [CNX Software on the SG560D][cnx-sg560d], [TrustedReviews][tr-fp5], [CNX Software on the Fairphone 5][cnx-fp5].

### Chip-vendor design

The project designs a phone around a Qualcomm or MediaTek chip that it buys from the chip maker directly.
That needs:

- a business agreement with the chip maker for the chip, the BSP and the secure-boot signing tools; Qualcomm makes its signing-tool guides available only to licensed users;
- order sizes that interest a chip maker (unsourced);
- everything the ODM and module routes need.

**Verdict:** out of reach for a small project.
A better-funded company of experienced phone engineers shipped one phone this way and closed ([OSOM](#osom)).

Sources: [Qualcomm: sign and flash the images][qc-sign].

## Software work

Hardware made by or for the project brings software work that a phone bought in a shop doesn't.
This applies whatever operating system ends up on the device.

### Someone has to maintain the device

No Android distribution looks after a new device until someone does the work.
Before it can ship, someone writes and maintains:

- **the device tree:** `device/<vendor>/<codename>` and the matching `vendor/` files, which describe the hardware to Android's build;
- **the kernel:** the chip maker's kernel, brought forward to each new Android release, or kept on a Google shared-kernel (GKI) version with the chip maker's add-ons;
- **the forward port:** each new Android release, and each release of the distribution built on it, needs the device brought forward again.

A distribution takes on a device only under its own rules.
LineageOS, for example, requires among other things a maintainer who owns the device, Android's security rules (SELinux) switched on, and a kernel built from source code.

Sources: [AOSP GKI][aosp-gki], [LineageOS charter][lineage-charter].

### The BSP sets the support period

The chip maker's software package (BSP) includes closed firmware for the modem, the secure area (TEE), the graphics chip and the camera.
Anyone can fix the open layers above it; the closed firmware gets security fixes only while the chip maker ships them (unsourced).

What chip makers offer:

- **Qualcomm's top and new mid-range chips:** since February 2025, up to eight years of Android and security updates for the Snapdragon 8 Elite and new 8- and 7-series chips, but only for phone makers that sign up.
  It builds on Google's Longevity GRF programme, which lets a chip's software serve seven Android versions instead of three.
- **Qualcomm QCM6490, an industrial chip:** the Fairphone 5 uses it to promise updates until 2031.
  Qualcomm's own support for the chip was reported to end in 2028, with Fairphone taking over after that.
- **Cellular modules:** a module comes with one Android version and may move to a later one; the Quectel SG560D lists Android 12 or 13.
  A current Android release means bringing the BSP forward by several versions.
- **Rockchip and NXP:** Android BSPs exist (Android 14 on kernel 6.1 for the RK3588; Android 17 on kernel 6.18 for the i.MX 8M Plus and i.MX 95), but these chips have no modem.
  A module maker expects to support each i.MX BSP version for about two years.
  NXP lists the i.MX 95 in its longevity programme until 2041, which covers making the chip, not supporting the BSP ([BOARDS.md](BOARDS.md#nxp-imx-8m-plus-and-imx-95)).

Kernels matter too.
Each GKI version has an end-of-support date, and the `android12-5.10` and `android13-5.10` versions lose support from Android 17 QPR1.
A chip whose BSP is stuck on an old kernel shortens the device's life, however good its hardware is.

For a product, the EU requires system updates for at least five years after the last device is sold ([EU ecodesign rules](#eu-ecodesign-rules)).
The chip's support period has to cover that duty before a chip is chosen.

Sources: [Qualcomm on extended support][qc-longevity], [Android Authority on extended support][aa-longevity], [Android Authority on Longevity GRF][aa-grf], [TrustedReviews][tr-fp5], [CNX Software on the Fairphone 5][cnx-fp5], [Quectel SG560D][quectel-sg560d], [Advantech RK3588 Android 14][advantech-rk3588], [NXP RN00201][nxp-rn00201], [Variscite Android lifecycle][variscite-lifecycle], [NXP product longevity][nxp-longevity], [Android common kernels][aosp-common-kernels].

### Root of trust

How a device decides which software to trust, starting inside the chip.

Secure boot starts in the chip.
The manufacturer burns the fingerprint (hash) of its secure-boot key into the chip's one-time fuses; on Qualcomm chips these are the QFPROM fuses.
Secure boot is on once the fuses are set ("blown"), and that can't be undone.
From then on the chip starts only firmware signed with that key.

Android Verified Boot (AVB) builds on top: the bootloader checks the operating system against an AVB key.
On Pixels, the owner can load their own AVB key (`avb_custom_key`) and relock the bootloader, so an operating system signed by someone else still starts with the bootloader locked.

What this means for the project:

- **Two keys, two holders.**
  The manufacturer holds the key burned into the chip; each operating system signs with its own AVB key ([DESIGN.md](DESIGN.md#each-party-keeps-its-own-keys)).
- **The chip key is permanent.**
  It can't be replaced.
  Losing it breaks the firmware updates of every device fused with it; leaking it lets anyone sign firmware for them.
  It needs a safe home before the first device is fused: offline, backed up, and with access controlled.
- **Fusing can't be undone,** so each fusing step needs a maintainer's go-ahead.
- **Signing tools:** Qualcomm signs firmware with SecTools V2.
  ⚠ Its guides are available only to licensed users; what the licence involves is check C5.

Sources: [Qualcomm: set the QFPROM fuses][qc-fuses], [Qualcomm: sign and flash the images][qc-sign], [AOSP device state][aosp-device-state].

### Apps and Google services

- Google's apps can't be included without a licence for Google Mobile Services.
- Play Integrity's *device* level needs a locked bootloader, an operating system certified for the device, and a start-up confirmed by the security hardware as unmodified.
  Its *strong* level also needs security updates from the last year.
- A device or operating system that Google hasn't certified gets at most the *basic* level, so banking apps and Google Wallet's tap-to-pay may not work on it.

Sources: [microG wiki][microg-spoofing], [Play Integrity verdict changes][play-integrity].

## Certification, patents and EU rules

Everything in this section applies to whoever puts the device on the market: the manufacturer, or the brand that sells it under its own name (unsourced).
In a partnership, that is the partner.
While the project sells nothing, these duties would reach it only if handing prototypes to others counts as putting them on the market ⚠ (roadmap check C12).
Rules on using a radio transmitter still apply to every prototype that is switched on (unsourced).

### Radio and network certification

A phone needs radio approval in each market, and network certification before mobile networks accept it:

| Market | Radio approval | Network certification |
|---|---|---|
| United States | FCC equipment authorisation | PTCRB, for North American networks |
| Europe | CE marking under the Radio Equipment Directive (RED) | GCF, for European networks |

- **Body exposure (SAR)** is measured on the finished device; the result depends on its antennas and case, so a certified module doesn't cover it (unsourced).
- **A certified module helps, but doesn't finish the job.**
  A product that uses a module exactly as its FCC approval allows can rely on the module's FCC ID, with no further FCC testing of the mobile-network radio.
  PTCRB also lets a product build on a certified module, but its lab decides which parts of the product must be tested again.

**Cost:** ⚠ published figures are old and vary widely: about $10,000–$50,000 for PTCRB on a finished device, $2,000–$10,000 for FCC testing, and up to $70,000 for LTE in an older estimate.
A phone with several radios, bands and markets costs more than the small connected devices these figures describe.
Ask an accredited lab for quotes (check C6).

Sources: [dev.to certification guide][devto-cert], [ECN][ecn-carrier], [Taoglas][taoglas-cert], [PTCRB][ptcrb-10steps], [Cetecom][cetecom-ptcrb], [Circuit Cellar][cc-cert], [Hologram community][hologram-cert].

### Cellular patent licences

A phone that connects to LTE or 5G networks uses standard-essential patents (SEPs).
Their owners expect a licence on fair, reasonable and non-discriminatory (FRAND) terms.

| Licensor | Published rate per phone |
|---|---|
| Qualcomm | 3.25% of the net selling price, for a 5G phone, mobile-network-only licence |
| Ericsson | $5.00, or as low as $2.50 in exceptional cases (2024 analysis) |
| Nokia | About €3 for a 5G phone (announced 2018) |

- Estimates of the total across all patent owners range from a few percent to about 11% of the phone's price.
- ⚠ Whether a module's price includes any licence for the finished phone is a contract question; assume it doesn't (unsourced).
- A Wi-Fi-only device avoids mobile-network SEPs, though Wi-Fi and video formats have patent pools of their own (unsourced).

Sources: [Qualcomm 5G licensing][qc-5g-licensing], [WiseHarbor via ip-finance][wiseharbor], [TechRadar][techradar-nokia], [Stout][stout-sep].

### EU ecodesign rules

Regulation (EU) 2023/1670 applies to smartphones, other mobile phones, cordless phones and tablets put on the EU market from 2025-06-20.
Among its requirements:

- **System updates** for at least five years after the last device of a model is put on the market.
- **Spare parts,** such as batteries, cameras and displays, for seven years after sales end, delivered within 5–10 working days.
- **Repair access:** professional repairers get fair access to the software and firmware needed for repairs.
- **An energy label** with a repairability class, under the matching labelling regulation.

Regulation (EU) 2025/2006 corrected and changed the rules in December 2025 (check C2).

**For a product:** a device sold for two years commits its manufacturer to system updates for at least seven years from launch, and to spare parts for nine.
That matches the support periods of Pixels and Fairphones, which those companies pay for from far larger sales.

Sources: [European Commission][ec-ecodesign], [EUR-Lex 2023/1670][eurlex-1670], [EUR-Lex 2025/2006][eurlex-2006], [heise][heise-ecodesign], [iFixit on ecodesign][ifixit-ecodesign].

### EU battery rules

From 2027-02-18, Article 11 of the Batteries Regulation (EU) 2023/1542 requires batteries in portable products to be removable and replaceable by the user.

- Delegated Regulation (EU) 2026/1770, published 2026-10-22, lets some products have batteries that only independent professionals replace.
- ⚠ Whether smartphones fall under that exception, or under the existing exemption for batteries that meet strict durability criteria, isn't confirmed from the regulation's text (check C3).

Sources: [UL][ul-battery], [EUR-Lex battery guidance][eurlex-battery-guidance].

### EU cybersecurity rules

- **RED delegated act 2022/30:** since 2025-08-01, radio equipment that connects to the internet, phones included, must meet requirements for protecting networks, personal data and against fraud.
  The standards EN 18031-1, -2 and -3 give one way to show this.
  ⚠ A European Commission draft of 2026-02-16 proposes repealing the act from 2027-12-11, when the Cyber Resilience Act takes over; whether it was adopted isn't confirmed (check C7).
- **Cyber Resilience Act, Regulation (EU) 2024/2847:** from 2026-09-11, manufacturers must report security holes that are being exploited, and severe incidents, through the reporting platform of ENISA, the EU's cybersecurity agency.
  Most other duties, among them a machine-readable list of every software part (a software bill of materials), apply from 2027-12-11.
  ⚠ One source mentions planned changes; check the EU's Official Journal before relying on the dates (check C7).

**For a product:** the manufacturer carries these duties for the whole device, firmware included, and needs a process for reporting exploited security holes before the first device is sold.

Sources: [BSI][bsi-red], [UK government factsheet][gov-uk-red], [Council document][consilium-red-repeal], [Travers Smith][ts-cra], [Hogan Lovells][hl-cra], [Cloud Security Alliance][csa-cra].

### Trademarks

- "Android" may be used only to describe something, never as the product's name, with the line "Android is a trademark of Google LLC".
- A device sold under a brand needs a trademark search for that brand in each market first (unsourced).

Sources: [Android brand guidelines][android-brand].

## Earlier phone projects

Small companies that built their own phones, and what happened to them.
Most of these reports are press coverage or the companies' own posts, not independent reviews.

| Project | Approach | What happened |
|---|---|---|
| [Purism Librem 5](#purism-librem-5) | Own design | Shipped years late |
| [Pine64 PinePhone Pro](#pine64-pinephone-pro) | Own design | Discontinued in 2025 |
| [Liberux NEXX](#liberux-nexx) | Own design, crowdfunded | ⚠ Shipping not confirmed |
| [FuriLabs FLX1s](#furilabs-flx1s) | Built on an older chip | On sale at $550 |
| [OSOM](#osom) | Experienced team, outside funding | Closed in 2024 |

### Purism Librem 5

- Built on NXP's i.MX 8M Quad.
- A fault in that chip, which drained the battery, moved the first batch from January to April 2019.
- In 2022 Purism named the supply of processors as one of its biggest obstacles, during worldwide chip shortages.
  It invested heavily in parts and other supplies to keep enough stock.

Sources: [Purism][purism-where], [Notebookcheck on the Librem 5][nbc-librem].

### Pine64 PinePhone Pro

- Discontinued in August 2025 because it didn't sell well enough.
- ⚠ In August 2026 Pine64 reportedly stopped making all its Linux devices, because of shortages of memory and storage chips (DRAM and eMMC), until at least mid-2027 (check C8).

Sources: [Pine64][pine64-aug2025], [The Register on the PinePhone Pro][reg-pinephone], [Tom's Hardware][toms-pine64], [Linux Magazine][linuxmag-pine64].

### Liberux NEXX

- A Linux phone on the Rockchip RK3588S, crowdfunded on Indiegogo from mid-2025, aiming for about $1.6 million and to ship by July 2026.
- At launch it was still a concept, shown on a development board that carried the main parts.
- ⚠ Whether it reached its goal or shipped wasn't found (check C8).

Sources: [CNX Software on the NEXX][cnx-nexx], [Notebookcheck on the NEXX][nbc-nexx].

### FuriLabs FLX1s

- A Debian-based phone at $550, on a MediaTek Dimensity 900 chip from about 2021.
- Hardware switches cut power to the microphone, the cameras and the modem.

Sources: [It's FOSS][itsfoss-flx1s], [Liliputing][lili-flx1s].

### OSOM

- Started by former Essential staff after Essential closed, and made the Solana Saga phone together with Solana.
- Reported in September 2024 to be shutting down.
  Android Authority reports several causes:
  - Solana reportedly didn't choose OSOM again for the Saga's successor;
  - attempts to switch to an AI-powered camera and to sell the company to HP didn't work out;
  - it failed to raise more money;
  - a former executive sued over the company's spending, which the founder denies.

Sources: [Android Authority on OSOM][aa-osom], [9to5Google on OSOM][9to5-osom].

### What the cases have in common

- **Hardware takes years.**
  The self-built phones above shipped late, stopped, or haven't been confirmed as shipped.
- **Supply decides.**
  The Librem 5 waited for its processor, and Pine64 stopped for lack of memory chips.
  Memory prices for phones rose sharply in 2026 because of demand from AI data centres.
- **Old chips are normal.**
  The FLX1s uses a chip from about 2021, and the modules and most development boards in this study come with Android software one or more versions old.
- **The operating systems that got hardware did it through partners.**
  /e/OS, iodéOS and GrapheneOS didn't design phones ([Partnership](#partnership-with-a-phone-maker)).

Sources: [IDC][idc-memory], [The Register on memory prices][reg-memory].

## Risks

| Risk | Impact | What reduces it |
|---|---|---|
| The chip maker stops support before the EU's update period ends | High | Choose chips with long published support; put the period in the contract |
| The chip key is lost or leaked | Critical | An offline, backed-up key that only the maintainers handle; a go-ahead for each fusing step |
| Shortages of memory or chips | High | Keep stock of key parts, as Purism did; avoid parts that only one company makes |
| Certification costs more than estimated | Medium to high | Lab quotes before committing (check C6) |
| Handing out prototypes makes the project a manufacturer | High | Sell nothing; check C12 before any device leaves the maintainers (decision D3) |
| A practice board is made unusable by fusing | Low | Fuse only boards bought for that purpose |

## Sources

All checked on 2026-11-20.

### Android and Google

- [AOSP device state][aosp-device-state]: relocking with a custom verified-boot key on Pixels.
- [Pixel update policy][pixel-updates]: seven years of updates for recent Pixels.
- [AOSP GKI][aosp-gki]: the Generic Kernel Image and vendor modules.
- [Android common kernels][aosp-common-kernels]: GKI branch end-of-life dates; the 5.10 branches losing support from Android 17 QPR1.
- [AOSP reference boards][aosp-boards]: the three reference boards, not supported or tested in AOSP, with BSPs from the board makers.
- [Play Integrity verdict changes][play-integrity]: what the basic, device and strong verdicts require.
- [microG wiki][microg-spoofing]: Google apps need a Google Mobile Services licence.
- [Android brand guidelines][android-brand]: "Android" only as a descriptor, with the trademark attribution.
- [LineageOS charter][lineage-charter]: what LineageOS requires before it takes on a device.

### Bootloader unlocking

- [SamMobile][sammobile-oneui8]: One UI 8 removed the bootloader unlock option.
- [Android Authority on Xiaomi][aa-xiaomi]: HyperOS's restrictions on unlocking.

### Chips, boards and modules

- [Qualcomm on extended support][qc-longevity] and [Android Authority on extended support][aa-longevity]: up to eight years of updates for manufacturers that opt in.
- [Android Authority on Longevity GRF][aa-grf]: vendor software reused for seven Android versions.
- [Qualcomm: Android on Dragonwing][qc-android-dw]: Android listed for the QCS6490.
- [Qualcomm kernel docs][qc-kernel]: Qualcomm Linux on Linux 6.18 for the RB3 Gen 2.
- [Radxa support matrix][radxa-matrix]: Android 12 for the Rock 5B.
- [Advantech RK3588 Android 14][advantech-rk3588]: Android 14 on kernel 6.1 for the RK3588.
- [NXP RN00201][nxp-rn00201]: Android 17 on kernel 6.18 for the i.MX 8M Plus and i.MX 95.
- [NXP product longevity][nxp-longevity]: the i.MX 95 listed until 2041.
- [Variscite Android lifecycle][variscite-lifecycle]: about two years of support for each BSP version.
- [TI Android 11.00.01 release notes][ti-android-1101]: Android 16 on kernel 6.12 for BeaglePlay.
- [OSHWA certificate for BeaglePlay][oshwa-beagleplay]: BeaglePlay certified as open hardware.
- [RISE Android 17 announcement][rise-android17]: Android 17 on the SpacemiT K3 Pico-ITX and Alibaba A210 EVB, as a developer release (checked 2026-11-21).
- [Android Authority on RISC-V][aa-riscv]: RISC-V removed from Android's common kernel and GKI in 2024 (checked 2026-11-21).
- [KonstaKANG AOSP 17][konstakang-aosp17]: the community Android 17 build for the Raspberry Pi 5, not for commercial use.
- [Raspberry Pi Compute Module 5][rpi-cm5]: a board from under a hundred dollars.
- [Raspberry Pi security architecture][rpi-security]: fusing a customer key into a Raspberry Pi.
- [Thundercomm C6490 Development Kit][thundercomm-c6490]: Android 12 for a QCS6490 board, over a thousand dollars.
- [Quectel SG560D][quectel-sg560d] and [CNX Software on the SG560D][cnx-sg560d]: the module's chip, radios and ⚠ Android version.
- [Qualcomm: set the QFPROM fuses][qc-fuses]: secure boot enabled by blowing fuses, which can't be undone.
- [Qualcomm: sign and flash the images][qc-sign]: signing with SecTools V2; its guides only for licensed users.

### Phone makers and partnerships

- [iFixit on the Fairphone 6][ifixit-fp6] and [Fairphone support][fp-support]: official unlocking, with the warranty kept.
- [Fairphone /e/OS][fp-eos]: Fairphones sold with /e/OS.
- [Android Central][ac-murena-fp6]: Murena as the US distributor of the Fairphone (Gen. 6), sold there only with /e/OS.
- [TrustedReviews][tr-fp5] and [CNX Software on the Fairphone 5][cnx-fp5]: the QCM6490, updates until 2031, Qualcomm's support until 2028.
- [Murena][murena-shift]: the SHIFTphone 8 with /e/OS and its hardware switch.
- [Privacy Guides][pg-shift]: NovaCustom's SHIFTphone with iodéOS, and the concerns about it.
- [9to5Google on Motorola][9to5-moto] and [The Register on Motorola][reg-moto]: the Motorola–GrapheneOS partnership.
- [Notebookcheck][nbc-moto] and [Android Authority on GrapheneOS's plans][aa-moto-plans]: GrapheneOS's hardware requirements for Motorola.
- [Android Authority on the Signature 27][aa-sig27]: ⚠ the first supported Motorola phone.
- [Gigaset blog][gigaset-volla] and [Sailfish OS forum][sfos-quintus]: who builds Volla's phones.

### ODM costs and the memory market

- [Alibaba smartphone ODM guide][alibaba-odm] and [Alibaba guide to launching a phone brand][alibaba-brand]: ⚠ minimum orders, NRE and unit prices.
- [IDC][idc-memory] and [The Register on memory prices][reg-memory]: the 2026 memory shortage and price rises.

### Earlier phone projects

- [Purism][purism-where]: the Librem 5's i.MX 8M Quad, CPU supply as a roadblock, and investing in stock.
- [Notebookcheck on the Librem 5][nbc-librem]: the silicon bug that moved the first batch to April 2019.
- [Pine64][pine64-aug2025] and [The Register on the PinePhone Pro][reg-pinephone]: the PinePhone Pro discontinued.
- [Tom's Hardware][toms-pine64] and [Linux Magazine][linuxmag-pine64]: ⚠ Pine64 halting its Linux devices.
- [CNX Software on the NEXX][cnx-nexx] and [Notebookcheck on the NEXX][nbc-nexx]: the NEXX's chip, campaign and target date.
- [It's FOSS][itsfoss-flx1s] and [Liliputing][lili-flx1s]: the FLX1s's chip, price and switches.
- [Android Authority on OSOM][aa-osom]: OSOM's origins, its shutdown and the reported causes.
- [9to5Google on OSOM][9to5-osom]: the shutdown report and the lawsuit.

### Certification and patents

- [dev.to certification guide][devto-cert]: FCC, CE, PTCRB and GCF, with ⚠ cost figures.
- [ECN][ecn-carrier] and [Taoglas][taoglas-cert]: reusing a module's FCC approval.
- [PTCRB][ptcrb-10steps] and [Cetecom][cetecom-ptcrb]: building PTCRB certification on a certified module.
- [Circuit Cellar][cc-cert] and [Hologram community][hologram-cert]: ⚠ older cost figures.
- [Qualcomm 5G licensing][qc-5g-licensing]: Qualcomm's handset royalty.
- [WiseHarbor via ip-finance][wiseharbor]: Ericsson's rates and an aggregate estimate.
- [TechRadar][techradar-nokia]: Nokia's 5G rate.
- [Stout][stout-sep]: aggregate SEP royalty estimates.

### EU rules

- [European Commission][ec-ecodesign], [EUR-Lex 2023/1670][eurlex-1670], [heise][heise-ecodesign] and [iFixit on ecodesign][ifixit-ecodesign]: the ecodesign rules for phones and tablets.
- [EUR-Lex 2025/2006][eurlex-2006]: the 2025 correction and amendment.
- [UL][ul-battery] and [EUR-Lex battery guidance][eurlex-battery-guidance]: battery removability and the 2026 derogation.
- [BSI][bsi-red] and [UK government factsheet][gov-uk-red]: RED delegated act 2022/30 and EN 18031.
- [Council document][consilium-red-repeal]: ⚠ the proposed repeal of the RED delegated act.
- [Travers Smith][ts-cra], [Hogan Lovells][hl-cra] and [Cloud Security Alliance][csa-cra]: the Cyber Resilience Act's dates.

[aosp-device-state]: https://source.android.com/docs/security/features/verifiedboot/device-state
[pixel-updates]: https://support.google.com/nexus/answer/4457705?hl=en
[aosp-gki]: https://source.android.com/docs/core/architecture/kernel/generic-kernel-image
[aosp-common-kernels]: https://source.android.com/docs/core/architecture/kernel/android-common
[aosp-boards]: https://source.android.com/docs/setup/devices
[play-integrity]: https://developer.android.com/google/play/integrity/improvements
[microg-spoofing]: https://www.github.com/microg/GmsCore/wiki/Signature-Spoofing
[android-brand]: https://developer.android.com/distribute/tools/promote/brand
[lineage-charter]: https://github.com/LineageOS/charter/blob/main/device-support-requirements.md
[sammobile-oneui8]: https://www.sammobile.com/news/say-goodbye-to-your-custom-roms-as-one-ui-8-kills-bootloader-unlock/
[aa-xiaomi]: https://androidauthority.com/xiaomi-hyperos-bootloader-unlock-3383687
[qc-longevity]: https://www.qualcomm.com/news/onq/2025/02/qualcomm-extends-support-for-updates-on-android-devices-with-snapdragon-8-elite
[aa-longevity]: https://www.androidauthority.com/qualcomm-extended-software-update-program-3529365/
[aa-grf]: https://www.androidauthority.com/longevity-grf-explained-3493006/
[qc-android-dw]: https://www.qualcomm.com/developer/software/android-on-dragonwing
[qc-kernel]: https://dragonwingdocs.qualcomm.com/System/Kernel
[radxa-matrix]: https://docs.radxa.com/en/software-support-matrix/rockchip
[advantech-rk3588]: https://docs.aim-linux.advantech.com/docs/bsp/rockchip/Android/Android14/RK3588/
[nxp-rn00201]: https://www.nxp.com/docs/en/release-note/RN00201.pdf
[nxp-longevity]: https://www.nxp.com/products/product-information/product-longevity:PRDCT_LONGEVITY_HM
[variscite-lifecycle]: https://dev.variscite.com/software-and-security/software-lifecycle/android-lifecycle/
[ti-android-1101]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_01/docs/devices/AM62X/android/Release_Specific_Release_Notes.html
[oshwa-beagleplay]: https://certification.oshwa.org/us002174.html
[rise-android17]: https://riseproject.dev/2026/10/20/android-17-available-on-rva23-with-rise/
[aa-riscv]: https://www.androidauthority.com/android-drop-risc-v-kernel-3438330/
[konstakang-aosp17]: https://konstakang.com/devices/rpi5/AOSP17
[rpi-cm5]: https://www.raspberrypi.com/products/compute-module-5/
[rpi-security]: https://www.raspberrypi.com/documentation/security/security-architecture.html
[thundercomm-c6490]: https://www.thundercomm.com/product/c6490-development-kit
[quectel-sg560d]: https://www.quectel.com/product/5g-sg560d-smart-module-series/
[cnx-sg560d]: https://www.cnx-software.com/2022/06/24/quectel-sg560d-5g-wifi-6e-module-runs-android-12-targets-aiot-applications/
[qc-fuses]: https://dragonwingdocs.qualcomm.com/System/Security/set-the-qfprom-fuses
[qc-sign]: https://dragonwingdocs.qualcomm.com/System/Security/sign-and-flash-the-images
[ifixit-fp6]: https://de.ifixit.com/News/111634/why-the-fairphone-6-should-be-your-next-phone
[fp-support]: https://support.fairphone.com/hc/articles/9979154556817
[fp-eos]: https://www.fairphone.com/fairphone-e-operating-system
[ac-murena-fp6]: https://www.androidcentral.com/phones/murena-fairphone-gen-6-announced-and-it-is-yet-again-sustainable-and-easily-repairable
[tr-fp5]: https://www.trustedreviews.com/news/fairphone-5-software-promise-leaves-apple-samsung-in-dust-4363352
[cnx-fp5]: https://www.cnx-software.com/2023/08/31/fairphone-5-smartphone-comes-with-8-years-of-software-updates-with-qualcomm-qcm6490-industrial-iot-processor/
[murena-shift]: https://murena.com/make-the-privacy-shift-happen-with-the-new-murena-shiftphone-8-and-its-hardware-kill-switch
[pg-shift]: https://www.privacyguides.org/news/2025/11/20/novacustom-announces-shiftphone-with-iodeos-security-community-concerned/
[9to5-moto]: https://9to5google.com/2026/03/01/motorola-confirms-grapheneos-partnership-for-a-future-smartphone-porting-features/
[reg-moto]: https://www.theregister.com/2026/03/02/motorola_grapheneos/
[nbc-moto]: https://www.notebookcheck.net/GrapheneOS-reveals-full-Motorola-plans-7-year-updates-Razr-support-more.1375825.0.html
[aa-moto-plans]: https://www.androidauthority.com/grapheneos-motorola-phone-software-support-plans-foldables-3701921/
[aa-sig27]: https://www.androidauthority.com/grapheneos-motorola-signature-27-support-3714885/
[gigaset-volla]: https://blog.gigaset.com/en/?p=20515
[sfos-quintus]: https://forum.sailfishos.org/t/volla-phone-quintus/21383
[alibaba-odm]: https://smartbuy.alibaba.com/buyingguides/smartphone-odm
[alibaba-brand]: https://electronics.alibaba.com/buyingguides/how-to-launch-your-own-phone-brand-in-2026
[idc-memory]: https://www.idc.com/resource-center/blog/global-memory-shortage-crisis-market-analysis-and-the-potential-impact-on-the-smartphone-and-pc-markets-in-2026/
[reg-memory]: https://www.theregister.com/2025/12/16/smartphones_memory_ai/
[purism-where]: https://puri.sm/posts/where-is-my-librem-5/
[nbc-librem]: https://www.notebookcheck.net/Purism-plans-to-ship-first-batch-of-Librem-5-Linux-smartphones-in-April-2019.328804.0.html
[pine64-aug2025]: https://pine64.org/2025/08/14/august_2025_short_update/
[reg-pinephone]: https://www.theregister.com/2025/08/19/pinephone_pro_riscv/
[toms-pine64]: https://www.tomshardware.com/pc-components/dram/pine64-halts-all-linux-device-production-until-at-least-mid-2027-as-memory-shortage-bites
[linuxmag-pine64]: https://www.linux-magazine.com/Online/News/Pine64-Halts-Production-of-Linux-Devices
[cnx-nexx]: https://www.cnx-software.com/2025/06/03/liberux-nexx-linux-smartphone-rockchip-rk3588s-32gb-ram-6-34-inch-oled/
[nbc-nexx]: https://www.notebookcheck.net/Liberux-Nexx-New-Linux-smartphone-with-32GB-RAM-2-TB-storage-and-5G.950866.0.html
[itsfoss-flx1s]: https://itsfoss.com/news/furi-labs-flx1s/
[lili-flx1s]: https://liliputing.com/flx1s-is-a-new-linux-phone-thats-mostly-a-downgrade-from-the-flx1/
[aa-osom]: https://www.androidauthority.com/osom-shut-down-3478302/
[9to5-osom]: https://9to5google.com/2024/09/04/essential-osom-shut-down-report
[devto-cert]: https://dev.to/applekoiot/a-developers-guide-to-fcc-ce-ptcrb-and-gcf-certifications-for-iot-devices-4999
[ecn-carrier]: https://www.ecnmag.com/articles/2012/07/cellular-carrier-certification-requirements
[taoglas-cert]: https://www.taoglas.com/wp-content/uploads/pdf/Certification-Requirements-for-a-GSM-Device-in-North-AmericaAPN-14-8-003.A.pdf
[ptcrb-10steps]: https://www.ptcrb.com/wp-content/uploads/2021/12/10_Steps_to_PTCRB_Cert_for_Cell_Enabled_IoT_Devices-V2.pdf
[cetecom-ptcrb]: https://cetecomadvanced.com/en/certification/ptcrb-certification
[cc-cert]: https://circuitcellar.com/research-design-hub/the-internet-of-things-cell-modem-certification/
[hologram-cert]: https://community.hologram.io/t/cheapest-module/2018
[qc-5g-licensing]: https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm-5g-handset-licensing-program.pdf
[wiseharbor]: https://groups.google.com/g/ip-finance/c/0A0JYJUTWqk
[techradar-nokia]: https://www.techradar.com/news/nokia-expects-to-make-euro3-from-every-5g-smartphone
[stout-sep]: https://www.stout.com/-/media/pdf/2022_stout-sep-privateer-report.pdf
[ec-ecodesign]: https://single-market-economy.ec.europa.eu/news/new-eu-rules-durable-energy-efficient-and-repairable-smartphones-and-tablets-start-applying-2025-06-20_en
[eurlex-1670]: https://eur-lex.europa.eu/eli/reg/2023/1670/oj/eng
[eurlex-2006]: https://eur-lex.europa.eu/eli/reg/2025/2006/oj/eng
[heise-ecodesign]: https://heise.de/-10447853
[ifixit-ecodesign]: https://www.ifixit.com/News/111220/ecodesign-for-smartphones-now-in-effect
[ul-battery]: https://www.ul.com/news/eu-expands-portable-battery-removability-derogations
[eurlex-battery-guidance]: https://eur-lex.europa.eu/eli/C/2025/214/oj/eng
[bsi-red]: https://www.bsigroup.com/siteassets/pdf/en/products-and-services/bsi_radio_equipment_directive-cybersecurity_faq_flyer_a4_241014.pdf
[gov-uk-red]: https://www.gov.uk/government/publications/radio-equipment-regulations-2017/regulation-eu-202230-factsheet
[consilium-red-repeal]: https://data.consilium.europa.eu/doc/document/ST-6429-2026-INIT/en/pdf
[ts-cra]: https://www.traverssmith.com/knowledge/knowledge-container/the-eu-cyber-resilience-acts-vulnerability-and-incident-reporting-requirements-are-now-live/
[hl-cra]: https://www.hoganlovells.com/en/publications/eu-cyber-resilience-act-preparing-for-vulnerability-and-incident-reporting
[csa-cra]: https://labs.cloudsecurityalliance.org/research/csa-research-note-eu-cra-reporting-deadline-20260903-csa-sty/
