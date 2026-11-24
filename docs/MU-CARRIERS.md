# Carrier boards for the LattePanda Mu

**Status: research.**
The LattePanda Mu is the x86 board on the [shortlist](SHORTLIST.md#lattepanda-x86-boards) that is a compute module: it plugs into a carrier board, which carries the connectors, the power supply and anything else the device needs.
This page looks at carrier boards for the Mu, and at what a carrier of the project's own would take, against what is decided for the cyber-deck: user-serviceable and portable, with LoRa and Wi-Fi, hardware kill switches, pocket-sized if possible, and running a Linux distribution for now ([CYBERDECK.md](CYBERDECK.md#what-is-decided)).
It expands one option of roadmap decision [D1](ROADMAP.md#d1-route-to-a-prototype), "a computer module on a board of the project's own", as [CARRIERS.md](CARRIERS.md) does for Raspberry Pi's Compute Module 5.
It is not a choice: D1 is open, and task [T1](ROADMAP.md#t1-hardware-requirements)'s requirements may point elsewhere.
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-24.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it (check C17).
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.
- Prices are DFRobot's on the day they were checked, without the Mu itself unless stated, and not quotes.

## In short

- The Mu is an Intel N100 or Core i3-N305 on a 69.6 × 60 mm module that plugs into a laptop memory socket; it runs ordinary x86 Linux and has no Wi-Fi of its own.
- It needs 9 to 20 V and a power budget of more than 10 W (N100) or 15 W (N305) for the module alone, several times what the Compute Module 5 draws in use, which weighs against a small battery.
- LattePanda's own carriers (Lite, Mini and Full Eval) are 110 mm wide or more, run from a 12–20 V supply, and have no battery; LattePanda publishes their design files, the Lite Carrier's in KiCad.
- LattePanda's 18650 UPS board adds a battery to its Lite and Mini carriers, but reports battery status only to Windows.
- Open community carriers exist, among them the small MOKA and a Mu cyber-deck's main board; one more Mu cyber-deck, SmasherGS, has LoRaWAN and a battery but no published licence.
- No carrier found has a LoRa mesh radio on the board.

## What matters for the cyber-deck

The same points as for the CM5 ([CARRIERS.md](CARRIERS.md#what-matters-for-the-cyber-deck)): size, battery, LoRa, Wi-Fi and kill switches, serviceability, and Linux.
Task T1 turns them into requirements; until then they are questions, not thresholds.

## The LattePanda Mu

What LattePanda's documentation says a carrier board has to provide, and the module offers to it.

- **Chips:** Intel Processor N100 (four cores, up to 3.4 GHz) or Core i3-N305 (eight cores, up to 3.8 GHz); power limits configurable from 6 to 35 W (N100) and 9 to 35 W (N305).
- **Memory and storage:** 8 or 16 GB of LPDDR5, and 64 GB of eMMC.
- **Size and connector:** 69.6 × 60 mm; a 260-pin edge connector that fits a standard (not reverse) DDR4 laptop memory socket at least 5.2 mm high.
- **Power:**
  - 9 to 20 V, typically 12 or 15 V, with no more than 200 mV of ripple; the module shuts off outside about 7.6 to 22.3 V.
  - A power budget of more than 10 W for the N100 and 15 W for the N305, for the module alone with the default settings, with at least 50 % margin recommended.
  - A screen on the module's eDP output takes the input voltage directly, which can limit it.
  - A power-button pin (`PWR_SW#`), a reset pin, and status pins that show whether it is running or asleep; its clock battery must be fitted for it to boot normally.
- **Interfaces:** up to nine PCIe 3.0 lanes, four USB 3.2 (10 Gbit/s) and eight USB 2.0 ports, two SATA ports, an eDP output and three HDMI or DisplayPort outputs (three screens at most), four UARTs, four I²C buses and up to 64 GPIO.
  Which lanes go to USB, PCIe or SATA is fixed by the firmware, so a carrier follows LattePanda's lane maps.
- **Wi-Fi:** none on the module; it comes from a card on the carrier, usually in an M.2 E-key slot.
- **Firmware and systems:** AMI UEFI firmware; Windows 10 and 11, and Ubuntu 22.04 and 24.04.
  As an x86 module it needs no device tree, so a carrier of the project's own needs no kernel work to boot (unsourced).
- **Price:** $359 for the N100 with 8 GB, $499 for the N100 with 16 GB, and $599 for the N305 with 16 GB, against $169 and $259 with 16 GB in January 2025 ([SHORTLIST.md](SHORTLIST.md#lattepanda-x86-boards)).
- **Production:** no promise found.
- **LattePanda Mu Ultra:** a later module on Intel Core Ultra 5 226V or 7 256V, the same size and connector but a different pinout; it wants 12 to 20 V and a 50 W budget, and fits some of the Mu's carriers, not all.

Sources: [Mu specification][lp-mu-spec], [Mu edge connector][lp-mu-edge], [Mu power design guide][lp-mu-power], [Mu power control][lp-mu-pwctl], [Mu design guide foreword][lp-mu-guide], [DFRobot: LattePanda Mu][dfr-mu], [Mu Ultra specification][lp-ultra-spec], [Mu Ultra power design guide][lp-ultra-power], [Carrier compatibility][lp-compat].

## Comparison

| Carrier | Size (mm) | Power | Battery | LoRa | Open design | Price |
|---|---|---|---|---|---|---|
| [Lite Carrier](#lattepanda-lite-carrier) | 146 × 102 | 15 V USB-C or 12–20 V DC, 45 W | UPS board | None | KiCad, MIT | $39 |
| [Mini Carrier](#lattepanda-mini-carrier) | 110 × 94 | 12–20 V, 30 W | UPS board | None | Schematic only | $69 |
| [Full Eval Carrier](#lattepanda-full-eval-carrier) | 170 × 170 | 12–19 V, 45 W | None | None | Schematic, Gerbers, MIT | $89 |
| [MOKA](#moka) | ⚠ Not found | USB-PD at 12 V | None | None | CERN-OHL-S-2.0 | Not sold |
| [Mu_Cyberdeck carrier](#mu_cyberdeck) | ⚠ Not found | ⚠ Not found | Power bank | None | GPL-3.0 | Not sold |
| [SmasherGS](#smashergs) | ⚠ Not found | ⚠ Not found | Built in | LoRaWAN | ⚠ No licence | Not sold |

Sources: the sections below.

## LattePanda's carriers

### LattePanda Lite Carrier

- A 146 × 102 mm (3.5-inch) carrier, DFR1142, now in a second version.
- 15 V over USB-C Power Delivery, or 12 to 20 V through a DC jack, from a supply of 45 W or more; its PCIe x4 slot works only from 12 V.
  ⚠ Its documentation gives the DC range as 12–20 V in one place and 12–19 V in another (check C17).
- Two USB 3.2 (10 Gbit/s) and two USB 2.0 ports, Gigabit Ethernet, HDMI, a PCIe 3.0 x4 slot, an M.2 M-key 2230 slot for an SSD and an M.2 E-key 2230 slot for a Wi-Fi card, a clock battery, a fan socket, power and reset buttons, a serial port, and a 10-pin power-management connector for LattePanda's UPS board.
- Its KiCad files are published in LattePanda's repository, under the MIT licence.
- $39.

Sources: [Lite Carrier][lp-lite], [DFRobot: Lite Carrier][dfr-lite], [LattePanda Mu repository][lp-mu-repo].

### LattePanda Mini Carrier

- A 110 × 94 mm carrier, DFR1293, for both the Mu and the Mu Ultra.
- 12 to 20 V through a DC jack, a 4-pin header, either USB-C port (20 V Power Delivery), or the UPS board's 10-pin connector; at least 30 W with the Mu.
- Two full USB-C ports and two USB 3.2 Type-A ports, 2.5 Gbit/s Ethernet, HDMI, an OCuLink PCIe x4 port, M.2 M-key and E-key slots, a GPIO header, a headphone jack and a fan connector.
  ⚠ Its documentation gives HDMI 2.1 and DFRobot HDMI 2.0 (check C17).
- With the Mu, some features need a different firmware.
- Only its schematic is published, as a PDF.
- $69.

Sources: [Mini Carrier][lp-mini], [DFRobot: Mini Carrier][dfr-mini], [LattePanda Mu repository][lp-mu-repo].

### LattePanda Full Eval Carrier

- A 170 × 170 mm (Mini-ITX) carrier, DFR1141, that brings out nearly everything the Mu has, for development; it doesn't take the Mu Ultra.
- 12–19 V from a supply of 45 W or more (DFRobot gives 12–20 V).
- Four USB 3.0 ports, two 2.5 Gbit/s Ethernet ports, two HDMI, PCIe slots, two SATA ports, M.2 E-key and B-key slots, MIPI CSI-2 for a camera, an RS232 port, a TPM header and more.
- Its schematic, Gerber files and 3D model are published in LattePanda's repository, under MIT; $89.

Sources: [Full Eval Carrier][lp-full], [DFRobot: Full Eval Carrier][dfr-full], [LattePanda Mu repository][lp-mu-repo].

### LattePanda UPS board

Not a carrier: a battery board that LattePanda's Lite and Mini carriers can take.

- Three 18650 Li-ion cells in series, fitted by the owner, giving about 11.1 V; charged at up to 1 A from 20 V USB-C or a 12–24 V DC jack, from a supply of at least 36 W.
- About 30 µA drawn after shutdown; 88 × 70 mm; $39.90.
- It reports battery status over the HID UPS protocol, which its wiki says only Windows 10 and 11 read; Linux can't see the battery level.
- ⚠ DFRobot's shop lists the Lite and Mini carriers as compatible, but the wiki lists only the LattePanda IOTA, and neither mentions the Mu (check C17).

Sources: [DFRobot: UPS board][dfr-ups], [DFRobot wiki: UPS board][dfr-ups-wiki].

## Community carriers

### MOKA

- A small open carrier for the Mu by Pierluigi Colangeli, who also designed the CM5 MINIMA ([CARRIERS.md](CARRIERS.md#cm5-minima)), under CERN-OHL-S-2.0, in KiCad.
- Power from USB Power Delivery at 12 V; Gigabit Ethernet, HDMI, two USB 2.0 ports and one USB 3.0, M.2 M-key and E-key slots (2230 and 2242), a CSI camera connector, a debug serial port, a Qwiic I²C connector and a fan connector.
- No battery.
- ⚠ Its size isn't given in its README (check C17).

Sources: [MOKA repository][moka-repo].

### Mu_Cyberdeck

- A tablet-style cyber-deck with an 11.6-inch touchscreen and a slide-out mechanical keyboard, on a Mu and a carrier of its own, by Ben Makes Everything, under GPL-3.0.
- Its carrier has M.2 E-key and M-key slots, for Wi-Fi and an SSD; the KiCad files for the carrier and the keyboard, and the case's 3D files, are published.
- It runs from a separate power bank, which its author warns doesn't hold its charge well.

Sources: [Mu_Cyberdeck repository][mu-cyberdeck].

### SmasherGS

- A Mu cyber-deck for a rocketry ground station, sponsored by LattePanda, with GPS, LoRaWAN, Wi-Fi and Bluetooth, a battery, a mechanical keyboard and an aluminium and 3D-printed body.
- ⚠ Its repository has no licence, and its files and how its LoRaWAN radio is connected weren't checked (check C17).

Sources: [SmasherGS repository][smashergs].

### Others

- **MuBook:** a portable home-server carrier with four SATA ports, M.2 slots and Ethernet, under MIT; far larger than pocket-sized.
- **hackbook motherboard:** a thin laptop carrier with two M.2 M-key slots, an M.2 E-key slot and a header for a battery-management board; ⚠ no licence and no test results found (check C17).

Sources: [MuBook repository][mubook], [hackbook motherboard repository][hackbook].

## A carrier of the project's own

What the sources say about designing one; what it should hold is task T1's to decide.

- **Starting points:**
  - LattePanda's carrier design guide, pin descriptions, symbols and footprints, and its Lite Carrier in KiCad, under MIT.
  - The MOKA, under CERN-OHL-S-2.0, a strongly reciprocal licence under which a design built on it is published under the same licence (unsourced).
  - The Mu_Cyberdeck's carrier, under GPL-3.0.
- **Power:** the Mu wants 9–20 V, not 5 V, so a battery design needs a pack of three or four Li-ion cells in series, or a boost converter, and a charger for it (unsourced); LattePanda's UPS board uses three cells in series.
  With a budget above 10 W against the CM5's few watts, the battery has to be larger for the same running time (unsourced).
- **LoRa:** the Mu has UARTs, I²C and GPIO but no SPI in its specification list; ⚠ how an SX1262 radio would connect, through a USB bridge, a USB LoRa device or a module on a serial port, is open (check C17, [LORA.md](LORA.md)).
- **Wi-Fi and kill switches:** Wi-Fi comes from an M.2 or USB card the carrier holds, so a hardware switch can cut the card's power; M.2 cards also have a radio-disable pin (unsourced).
- **Serviceability:** the module sits in a socket and the Wi-Fi card and SSD on M.2 slots, so the owner can replace each (unsourced).
- **Linux:** the module boots like a PC, so a carrier needs no kernel work, but battery reporting has to be readable by Linux, unlike the UPS board's.

Sources: [LattePanda Mu repository][lp-mu-repo], [Mu design guide foreword][lp-mu-guide], [Mu power design guide][lp-mu-power], [Mu specification][lp-mu-spec], [MOKA repository][moka-repo], [Mu_Cyberdeck repository][mu-cyberdeck], [DFRobot wiki: UPS board][dfr-ups-wiki].

## What the research shows

Observations for task T1 and decision D1, not a choice.

- **Size:** the module is larger than the CM5 (69.6 × 60 against 55 × 40 mm), and LattePanda's smallest carrier is 110 × 94 mm; the MOKA may be smaller, but its size wasn't found.
- **Power:** the Mu's 9–20 V input and its power budget above 10 W are the largest obstacles to a pocket-sized battery device among the options looked at so far.
- **Battery:** no carrier found charges a battery on the board; LattePanda's UPS board adds one, but Linux can't read its battery level.
- **LoRa:** none of the carriers has a mesh radio; SmasherGS has LoRaWAN, with no licence.
- **Linux:** x86 makes the software side simple; Ubuntu is supported by LattePanda.
- **Price:** the module alone costs $359 or more, several times a CM5 ([CARRIERS.md](CARRIERS.md#the-compute-module-5)).

## Sources

All checked on 2026-11-24.

### LattePanda

- [Mu specification][lp-mu-spec]: chips, power limits, memory, storage, size, interfaces, power input, firmware and systems.
- [Mu edge connector][lp-mu-edge]: the 260-pin connector and the socket it needs.
- [Mu power design guide][lp-mu-power]: input voltage, ripple, power budget and the eDP supply.
- [Mu power control][lp-mu-pwctl]: the power, reset and status pins and the clock battery.
- [Mu design guide foreword][lp-mu-guide]: the guide's scope and the fixed lane assignment.
- [Mu Ultra specification][lp-ultra-spec] and [Mu Ultra power design guide][lp-ultra-power]: the Mu Ultra's chips, connector and power.
- [Carrier compatibility][lp-compat]: which carriers take the Mu and the Mu Ultra.
- [Lite Carrier][lp-lite], [Mini Carrier][lp-mini] and [Full Eval Carrier][lp-full]: power, interfaces and design files.
- [LattePanda Mu repository][lp-mu-repo]: the reference designs and their licence.

### DFRobot

- [DFRobot: LattePanda Mu][dfr-mu]: the module's prices.
- [DFRobot: Lite Carrier][dfr-lite], [DFRobot: Mini Carrier][dfr-mini] and [DFRobot: Full Eval Carrier][dfr-full]: sizes and prices.
- [DFRobot: UPS board][dfr-ups] and [DFRobot wiki: UPS board][dfr-ups-wiki]: cells, charging, standby draw, size, price, compatibility and Windows-only battery status.

### Community

- [MOKA repository][moka-repo]: features and licence.
- [Mu_Cyberdeck repository][mu-cyberdeck]: the cyber-deck, its carrier, power and licence.
- [SmasherGS repository][smashergs]: the cyber-deck's features.
- [MuBook repository][mubook] and [hackbook motherboard repository][hackbook]: their features and licences.

[dfr-full]: https://www.dfrobot.com/product-2821.html
[dfr-lite]: https://www.dfrobot.com/product-2822.html
[dfr-mini]: https://www.dfrobot.com/product-3155.html
[dfr-mu]: https://www.dfrobot.com/product-2820.html
[dfr-ups]: https://www.dfrobot.com/product-2983.html
[dfr-ups-wiki]: https://wiki.dfrobot.com/SKU_DFR1247_UPS_Expansion_Board
[hackbook]: https://github.com/Rabieulawal/hackbook-mobo
[lp-compat]: https://docs.lattepanda.com/content/mu_edition/module_carrier_compatibility/
[lp-full]: https://docs.lattepanda.com/content/mu_edition/full_eval/
[lp-lite]: https://docs.lattepanda.com/content/mu_edition/lite_carrier/
[lp-mini]: https://docs.lattepanda.com/content/mu_ultra_edition/mini_carrier/
[lp-mu-edge]: https://docs.lattepanda.com/content/mu_edition/design_guide_edge_connector/
[lp-mu-guide]: https://docs.lattepanda.com/content/mu_edition/design_guide_foreword/
[lp-mu-power]: https://docs.lattepanda.com/content/mu_edition/design_guide_power/
[lp-mu-pwctl]: https://docs.lattepanda.com/content/mu_edition/design_guide_pwctl_stat/
[lp-mu-repo]: https://github.com/LattePandaTeam/LattePanda-Mu
[lp-mu-spec]: https://docs.lattepanda.com/content/mu_edition/specification/
[lp-ultra-power]: https://docs.lattepanda.com/content/mu_ultra_edition/design_guide_power/
[lp-ultra-spec]: https://docs.lattepanda.com/content/mu_ultra_edition/specification/
[moka-repo]: https://github.com/piecol/lattepanda_MOKA
[mu-cyberdeck]: https://github.com/BenMakesEverything/Mu_Cyberdeck
[mubook]: https://github.com/LtBrain/MuBook
[smashergs]: https://github.com/ProgrammerTurtle/SmasherGS
