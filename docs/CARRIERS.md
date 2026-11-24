# Carrier boards for the Compute Module 5

**Status: research.**
A carrier board is the board a compute module plugs into: it carries the connectors, the power supply and anything else the device needs.
This page looks at carrier boards for Raspberry Pi's Compute Module 5 (CM5), and at what a carrier of the project's own would take, against what is decided for the cyber-deck: user-serviceable and portable, with LoRa and Wi-Fi, hardware kill switches, pocket-sized if possible, and running a Linux distribution for now ([CYBERDECK.md](CYBERDECK.md#what-is-decided)).
It expands one option of roadmap decision [D1](ROADMAP.md#d1-route-to-a-prototype), "a computer module on a board of the project's own".
It is not a choice: D1 is open, the CM5 isn't on the [shortlist](SHORTLIST.md), and task [T1](ROADMAP.md#t1-hardware-requirements)'s requirements may point elsewhere.
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-24.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it (check C16).
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.
- Prices are the figures the sources give, without the CM5 itself, and not quotes.

## In short

- The CM5 is the Raspberry Pi 5's chip on a 55 × 40 mm module; a carrier board gives it power, connectors and whatever else the device needs.
- It has two pins that switch its Wi-Fi and Bluetooth off in hardware, which a kill switch could drive.
- Ready-made carriers range from boards the size of the module itself (Waveshare's Nano boards) to Raspberry Pi's own 160 × 90 mm IO board; most run from a 5 V supply and have no battery.
- A few open designs already run a CM5 from a battery: the Argo carrier, and the main boards of the HackberryPi CM5 and piBrick hand-helds.
- None of the carriers found has a LoRa radio on the board; the uConsole's add-on board is the one CM5 setup found with LoRa, and users report it needs care to set up.
- Raspberry Pi publishes its IO board in KiCad, and the Argo and CM5 MINIMA carriers are open under the CERN-OHL-S licence, so a carrier of the project's own need not start from nothing.

## What matters for the cyber-deck

The points the comparison looks at, taken from what is decided.
Task T1 turns them into requirements; until then they are questions, not thresholds.

1. **Size:** how large the carrier is, for a device that is pocket-sized if possible.
2. **Battery:** whether it can run from a battery and charge it, or needs a fixed 5 V supply.
3. **LoRa:** whether it has a LoRa radio, or the SPI pins and space to add one ([LORA.md](LORA.md)).
4. **Wi-Fi and kill switches:** how Wi-Fi reaches the device, and whether a hardware switch can cut each radio.
5. **Serviceability:** whether the owner can replace the module, storage, battery and radios, and whether the design files are open so others can repair or remake it.
6. **Linux:** what the carrier needs from the kernel; the CM5's own support is in [The Compute Module 5](#the-compute-module-5).

## The Compute Module 5

What the CM5's datasheet says a carrier board has to provide, and offers to it.

- **Size:** 55 × 40 mm, 4.6 mm deep, with four M2.5 mounting holes.
  Mounted, it stands 4.94 mm or 7.44 mm high, depending on which of two Amphenol connectors the carrier uses.
- **Connectors:** two 100-pin high-density connectors; the CM5 keeps most of the CM4's pin layout, so many CM4 carriers take it with few changes.
- **Power:** a regulated 5 V supply (4.75 to 5.25 V), and nothing else.
  - The CM5 makes 3.3 V and 1.8 V for the carrier, up to 600 mA each.
  - Typical draw: about 400 mA at idle and 900 mA in use, at 5 V; about 3 mA shut down, and about 1.3 mA with its power-enable pin (`PMIC_EN`) held low.
  - A power-button pin (`PWR_BUT`) switches it on and off, and an RTC battery input (`VBAT`) keeps its clock.
- **Interfaces:** one PCIe x1 lane, two USB 3.0 ports, one USB 2.0 port, two 4-lane MIPI ports for screens or cameras, two HDMI outputs, Gigabit Ethernet, and up to 30 GPIO at 1.8 or 3.3 V.
- **Wi-Fi and Bluetooth:** sold with or without them.
  - With them, the antenna is either the module's PCB antenna or an external one on a U.FL connector, chosen in `config.txt` at boot.
  - The PCB antenna needs 10 mm of clear space and no metal underneath, which matters in a metal case.
  - Raspberry Pi sells a certified antenna kit; with any other antenna, the device maker certifies the radio itself.
- **Hardware radio switches:** two pins, `WL_nDisable` and `BT_nDisable`, stop Wi-Fi and Bluetooth from powering up when held low, "to physically disable" them in the datasheet's words.
  ⚠ Whether holding these pins low meets what the project means by a kill switch, or whether the radio's power has to be cut too, is open (check C16).
- **Variants:** 2, 4, 8 or 16 GB of memory; no eMMC storage (CM5 Lite) or 16, 32 or 64 GB; from $67.50.
- **Production:** until at least January 2036.
- **Linux:** the mainline kernel (7.4-rc4) describes the Raspberry Pi 5 but not the CM5; Raspberry Pi's own kernel (6.18) has device trees for the CM5 on its IO boards.
  A carrier of the project's own would need a device tree, or an overlay on Raspberry Pi's, describing its parts (unsourced).

Sources: [CM5 datasheet][cm5-ds], [Compute Module 5][rpi-cm5], [Linux: Broadcom device trees][linux-broadcom], [Raspberry Pi kernel: device trees][rpi-linux-dts].

## Comparison

| Carrier | Size (mm) | Power | Battery | LoRa | Open design | Price |
|---|---|---|---|---|---|---|
| [Raspberry Pi CM5 IO Board](#raspberry-pi-cm5-io-board) | 160 × 90 | 5 V USB-C | RTC cell only | None | KiCad files published | ⚠ Not checked |
| [Waveshare CM5-NANO-A](#waveshare-nano-boards) | 55 × 40 | 5 V | RTC header only | None | Not stated | $14.99 |
| [Waveshare CM5-NANO-B](#waveshare-nano-boards) | 55 × 41 | 5 V, 5 A | RTC header only | None | Not stated | $17.99 |
| [Waveshare CM5 to Pi 5 Adapter](#waveshare-cm5-to-pi-5-adapter) | 85 × 56 | 5 V, 5 A | RTC header only | None | Not stated | $19.99 |
| [CM5 MINIMA REV2](#cm5-minima) | ⚠ 54 × 57 or 61 × 61 | USB-C PD | None | None on the board | CERN-OHL-S-2.0 | $65 |
| [Argo](#argo) | ⚠ Not found | USB-C or battery | Charger and 5 V boost | None | CERN-OHL-S-2.0, no commercial copies | ⚠ Not found |
| [HackberryPi CM5 main board](#hackberrypi-cm5) | Device 143.5 × 91.8 | USB-C or battery | 5000 mAh LiPo | None | MIT | ⚠ Not found |
| [piBrick Pocket-CM5](#pibrick-pocket-cm5) | ⚠ Not found | Battery | 5000 mAh Li-ion | None | ⚠ GPL 3.0, repository not found | ⚠ About $172 in parts |
| [uConsole CM5 adapters](#uconsole-adapters-and-aio-v2) | Fits the uConsole | From the uConsole | The uConsole's cells | On the AIO V2 add-on | Varies | $19–23 |

Sources: the sections below.

## Ready-made carriers

Carriers sold to plug a CM5 into, without a battery.

### Raspberry Pi CM5 IO Board

- Raspberry Pi's own carrier, 160 × 90 mm, for the CM5 and CM5 Lite.
- 5 V over USB-C: at 5 A it allows the full peripheral current; at 3 A it limits USB peripherals to 600 mA.
- Two USB 3 ports, two full-size HDMI, two MIPI connectors, an M.2 M-key PCIe slot, the 40-pin GPIO header, a power button, a fan connector, and an RTC battery socket; a microSD slot for the CM5 Lite only.
- Its KiCad files are published, and its datasheet says they can be used in one's own designs.
  Raspberry Pi's licensing page grants use of most of its design files for any purpose, except third-party parts' files, which keep their makers' terms.
  ⚠ The page doesn't name the IO board's files (check C16).
- Too large for a pocket-sized device; a reference to start from, not a board to build in (unsourced).

Sources: [CM5 IO Board][rpi-cm5io], [CM5 IO Board datasheet][cm5io-ds], [Raspberry Pi design files][rpi-design-files], [Raspberry Pi licensing][rpi-licensing].

### Waveshare Nano boards

Carriers the size of the module itself.

- **CM5-NANO-A:** 55 × 40 mm; 5 V; one USB 3.2 Gen 1 Type-A port, two MIPI connectors, the 40-pin GPIO header, a fan header and an RTC battery header; $14.99.
- **CM5-NANO-B:** 55 × 41 mm; 5 V, 5 A; adds Gigabit Ethernet, a mini HDMI output, a headphone jack through a USB audio chip, and a 16-pin PCIe connector; $17.99.
- Neither has a battery charger, or says whether its design files are published.

Sources: [Waveshare CM5-NANO-A][ws-nano-a], [Waveshare CM5-NANO-B][ws-nano-b].

### Waveshare CM5 to Pi 5 Adapter

- 85 × 56 mm, the Raspberry Pi 5's size, so a CM5 fits cases and add-on boards made for the Pi 5.
- 5 V, 5 A; two USB 3.2 Gen 1 and two USB 2.0 ports, Gigabit Ethernet, a 16-pin PCIe connector, two MIPI connectors, the 40-pin GPIO header, a fan connector and an RTC battery header.
- ⚠ Its page lists two HDMI outputs as full-size in one place and micro in another (check C16).
- $19.99.

Sources: [Waveshare CM5 to Pi 5 Adapter][ws-cm5-pi5].

### CM5 MINIMA

- A small open carrier designed in KiCad by Pierluigi Colangeli, sold by Seeed Studio and Elecrow; certified as open hardware by the OSHWA (IT000020), under CERN-OHL-S-2.0.
- USB-C Power Delivery, USB 2.0, Gigabit Ethernet, HDMI, an M.2 M-key slot for 2230 SSDs (Seeed also lists 2242), one MIPI connector, I²C and SPI connectors, a fan connector, and a temperature sensor.
- No microSD slot, so a CM5 with eMMC is advised; no battery charger.
- $65 at both sellers.
- ⚠ Its size is 5.4 × 5.7 cm in its repository and at Elecrow, but 61 × 61 × 15 mm at Seeed (check C16).
- Its repository also holds a LoRaWAN schematic sheet with a RAK3172 LoRa module, which the REV2 board's schematic doesn't include.

Sources: [CM5 MINIMA REV2 repository][minima-repo], [OSHWA certificate][minima-oshwa], [Seeed: CM5 MINIMA][seeed-minima], [Elecrow: CM5 MINIMA R2][elecrow-minima].

## Carriers built for a battery

### Argo

- An open CM5 carrier "for portable and compact applications", by azlan.works, under CERN-OHL-S-2.0; its README says commercial copies need the author's agreement.
- Two 100-pin Hirose connectors, two MIPI connectors, micro HDMI, an HDMI FPC connector, a PCIe FPC connector like the Pi 5's, and two USB-C ports (one for power and flashing, one USB 3.0).
- A TI BQ25895 battery charger, with up to 5 A charging depending on the battery, and a TPS61022 boost to 5 V for up to 3 A from the battery or USB; battery level read over I²C.
- An optional board adds an M.2 M-key slot for an SSD.
- Its KiCad and EasyEDA files and a schematic are published, and it is certified by the OSHWA.
- Announced for a Crowd Supply campaign that hasn't launched.
- ⚠ Its size and price weren't found; the Crowd Supply page refused the fetch (check C16).

Sources: [Argo repository][argo-repo].

### HackberryPi CM5

The hand-held already described in [CYBERDECK.md](CYBERDECK.md#hackberrypi-cm5); its main board is a CM5 carrier built for a battery.

- An IP5306 charger and an IP5310 power-bank chip make 5 V from a 5000 mAh LiPo, charged over USB-C at 1.5–2 A; about 3–4 hours of typical use.
- Two DF40C 100-pin connectors for the CM5, two USB 3.0 ports, full-size HDMI, an M.2 2242 slot, microSD, and a Stemma QT I²C port.
- An RP2040 reads a BlackBerry keyboard over USB; the 4-inch screen uses the GPIO pins (DPI).
- Its schematic is published under the MIT licence.
- Its README warns that the CM5's PCB antenna may work poorly inside the metal case.

Sources: [HackberryPi CM5][hackberry-cm5], [HackberryPi CM5 hardware][hackberry-hw].

### piBrick Pocket-CM5

- A DIY hand-held around a CM5, reported in June 2026: a 3.92-inch AMOLED touchscreen, a BlackBerry-style keyboard with a trackpad, and a 5000 mAh cell charged by a TP4056-based circuit.
- The report says its hardware files are under GPL 3.0 and gives about $172 for the parts.
- ⚠ The repository it links wasn't found, and the report gives the CM5's chip wrongly as six Cortex-A78 cores, so its other figures need a second source (check C16).

Sources: [LavX on the piBrick Pocket-CM5][lavx-pibrick].

### uConsole adapters and AIO V2

The clockworkPi uConsole ([CYBERDECK.md](CYBERDECK.md#clockworkpi-uconsole)) takes a CM5 through an adapter board.

- A community list from June 2026 names four adapters at $19–23: clockworkPi's own (open, CM4 and CM5), HackerGadgets' (not open, adds NVMe and USB 3), lululvlv's (CM5 only, adds NVMe and USB 3, not yet open), and one for the Radxa CM5.
- clockworkPi's own uConsole page lists the CM4, not the CM5.
- HackerGadgets' AIO V2 add-on adds LoRa, GNSS, a software-defined radio, a clock and a USB hub; users switch each part on and off through GPIO pins with a tool of HackerGadgets'.
- ⚠ Users reported Meshtastic's `meshtasticd` failing to find the AIO V2's SX1262 on a CM5 until the right SPI device was set up (check C16).

Sources: [clockworkPi adapter list][cpi-adapters], [clockworkPi uConsole][uconsole], [clockworkPi forum: AIO V2 and meshtasticd][cpi-aio-lora], [HackerGadgets][hackergadgets].

## A carrier of the project's own

What the sources say about designing one; what it should hold is task T1's to decide.

- **Starting points:**
  - Raspberry Pi's IO board in KiCad, which its datasheet offers for one's own designs.
  - The Argo and the CM5 MINIMA, open under CERN-OHL-S-2.0: a strongly reciprocal licence, under which a design built on theirs is published under the same licence (unsourced); Argo's author also asks for an agreement before commercial copies.
  - The HackberryPi CM5's schematic, under MIT.
- **Power:** the CM5 needs only 5 V, so a battery design is a charger and a boost converter to 5 V, as on the Argo (BQ25895 and TPS61022) and the HackberryPi (IP5306 and IP5310).
- **LoRa:** no carrier found has a LoRa radio on the board; the CM5's SPI pins can take one, as the uConsole AIO V2 does ([LORA.md](LORA.md)).
- **Wi-Fi and kill switches:**
  - With a CM5 with wireless, a switch could hold `WL_nDisable` and `BT_nDisable` low.
  - With a CM5 without wireless, Wi-Fi could come from a card or a USB adapter whose power a switch cuts, as the [handheld proposal](HANDHELD.md#main-board) does.
  - For LoRa and other parts, the uConsole AIO V2 shows parts switched through GPIO pins; a hardware switch would cut them independently of software (unsourced).
- **Antenna and certification:** the CM5's radio stays certified with Raspberry Pi's antenna kit; any other antenna, or a LoRa radio of the project's own, brings certification work ([FEASIBILITY.md](FEASIBILITY.md)).
- **Serviceability:** the CM5 sits on connectors, so the owner can swap it, and a CM5 Lite takes storage the owner can replace (unsourced).

Sources: [CM5 datasheet][cm5-ds], [CM5 IO Board datasheet][cm5io-ds], [Argo repository][argo-repo], [CM5 MINIMA REV2 repository][minima-repo], [HackberryPi CM5][hackberry-cm5].

## What the research shows

Observations for task T1 and decision D1, not a choice.

- **Size:** a CM5 carrier can be as small as the module (55 × 40 mm), smaller than any board on the shortlist except the Raspberry Pi Zero 2 W ([SHORTLIST.md](SHORTLIST.md#comparison)).
- **Battery:** none of the small ready-made carriers runs from a battery; the battery-ready designs found are the Argo, not yet on sale, and the main boards of two hand-helds.
- **LoRa:** no carrier has it, so LoRa comes from an add-on board or from a carrier of the project's own.
- **Kill switches:** the CM5's two radio-disable pins are a starting point; whether they are enough is check C16.
- **Open designs:** enough exist (Raspberry Pi's IO board, the Argo, the MINIMA, the HackberryPi) that a carrier of the project's own can build on them, within their licences.

## Sources

All checked on 2026-11-24.

### Raspberry Pi

- [CM5 datasheet][cm5-ds]: size, connectors, power, power draw, interfaces, antenna, radio-disable pins, and the IO board's design files.
- [Compute Module 5][rpi-cm5]: variants, price and production to 2036.
- [CM5 IO Board][rpi-cm5io] and [CM5 IO Board datasheet][cm5io-ds]: size, power, interfaces, and the design files' use.
- [Raspberry Pi design files][rpi-design-files]: the IO board's KiCad files.
- [Raspberry Pi licensing][rpi-licensing]: the terms for Raspberry Pi's design files.
- [Raspberry Pi kernel: device trees][rpi-linux-dts]: the CM5 device trees in Raspberry Pi's kernel.
- [Linux: Broadcom device trees][linux-broadcom]: the mainline kernel's Raspberry Pi 5 device trees, and none for the CM5 (Linux 7.4-rc4).

### Carriers

- [Waveshare CM5-NANO-A][ws-nano-a], [Waveshare CM5-NANO-B][ws-nano-b] and [Waveshare CM5 to Pi 5 Adapter][ws-cm5-pi5]: sizes, power, interfaces and prices.
- [CM5 MINIMA REV2 repository][minima-repo], [OSHWA certificate][minima-oshwa], [Seeed: CM5 MINIMA][seeed-minima] and [Elecrow: CM5 MINIMA R2][elecrow-minima]: features, size, licence, the LoRaWAN sheet and prices.
- [Argo repository][argo-repo]: features, battery charger, licence and the planned campaign.
- [HackberryPi CM5][hackberry-cm5] and [HackberryPi CM5 hardware][hackberry-hw]: power chips, battery, connectors and licence.
- [LavX on the piBrick Pocket-CM5][lavx-pibrick]: the hand-held's parts, licence and cost.

### uConsole

- [clockworkPi adapter list][cpi-adapters]: the CM5 adapters, their prices and whether they are open.
- [clockworkPi uConsole][uconsole]: the modules clockworkPi lists.
- [clockworkPi forum: AIO V2 and meshtasticd][cpi-aio-lora]: the SX1262 set-up problem on a CM5 and the GPIO pins that switch the AIO V2's parts.
- [HackerGadgets][hackergadgets]: the AIO V2's parts and the adapter's price.

[argo-repo]: https://github.com/azlan-works/Argo
[cm5-ds]: https://datasheets.raspberrypi.com/cm5/cm5-datasheet.pdf
[cm5io-ds]: https://datasheets.raspberrypi.com/cm5/cm5io-datasheet.pdf
[cpi-adapters]: https://forum.clockworkpi.com/t/uconsole-core-and-adapter-board-directory/22664
[cpi-aio-lora]: https://forum.clockworkpi.com/t/aio-v2-cm5-debian-trixie-meshtasticd-sx1262-initialization-failure/23299
[elecrow-minima]: https://www.elecrow.com/cm5-minima-r-2.html
[hackberry-cm5]: https://github.com/CarbonComputers/Hackberry-Pi-CM5
[hackberry-hw]: https://github.com/CarbonComputers/Hackberry-Pi-CM5/tree/main/Hardware
[hackergadgets]: https://hackergadgets.com/
[lavx-pibrick]: https://news.lavx.hu/article/pibrick-pocket-cm5-diy-raspberry-pi-handheld-with-keyboard-trackpad-and-3-9-inch-amoled
[linux-broadcom]: https://github.com/torvalds/linux/tree/master/arch/arm64/boot/dts/broadcom
[minima-oshwa]: https://certification.oshwa.org/it000020.html
[minima-repo]: https://github.com/piecol/CM5_MINIMA_REV2
[rpi-cm5]: https://www.raspberrypi.com/products/compute-module-5/
[rpi-cm5io]: https://www.raspberrypi.com/products/compute-module-5-io-board/
[rpi-design-files]: https://pip.raspberrypi.com/categories/1098-design-files
[rpi-licensing]: https://www.raspberrypi.com/licensing/
[rpi-linux-dts]: https://github.com/raspberrypi/linux/tree/rpi-6.18.y/arch/arm64/boot/dts/broadcom
[seeed-minima]: https://www.seeedstudio.com/CM5-MINIMA-p-6485.html
[uconsole]: https://www.clockworkpi.com/uconsole
[ws-cm5-pi5]: https://www.waveshare.com/product/cm5-to-pi5-adapter.htm
[ws-nano-a]: https://www.waveshare.com/cm5-nano-a.htm
[ws-nano-b]: https://www.waveshare.com/cm5-nano-b.htm
