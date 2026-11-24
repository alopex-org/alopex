# Main-board shortlist

**Status: research.**
On 2026-11-24 the maintainer named the boards most in view for the cyber-deck's main board, for now: the Raspberry Pi 5, the Orange Pi 5 and 6, the Raspberry Pi Zero 2 W, and LattePanda's x86 boards.
This page sets out what each one offers against what is decided for the cyber-deck: user-serviceable and portable, with LoRa and Wi-Fi, pocket-sized if possible, and running a Linux distribution for now ([CYBERDECK.md](CYBERDECK.md#what-is-decided)).
It is a shortlist, not a choice: the main board is roadmap decision [D1](ROADMAP.md#d1-route-to-a-prototype), still open, and task [T1](ROADMAP.md#t1-hardware-requirements)'s requirements may add boards or rule some out.
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-24.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it (check C15).
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.
- Prices are the figures the sources give on the date they give, not quotes; memory prices rose sharply in 2026, so many are out of date.

## In short

- **Raspberry Pi 5:** a fast Arm board with Wi-Fi on the board, full support in mainline Linux, and a production promise to 2036; it needs a 5 V, 5 A supply, and its price has risen with memory prices.
- **Raspberry Pi Zero 2 W:** the smallest and lowest-power board on the list, with Wi-Fi on the board, but only 2.4 GHz Wi-Fi and 512 MB of memory.
- **Orange Pi 5 family:** Rockchip RK3588S and RK3588 boards with good mainline Linux support; Wi-Fi is on the board only in some models.
- **Orange Pi 6 and 6 Plus:** the most powerful Arm boards on the list, but larger, power-hungry (about 15 W at rest in one review), with Wi-Fi only as an add-on card and Linux support that still relies on the chip maker's kernel.
- **LattePanda x86 boards:** Intel boards that run ordinary PC Linux distributions; the smallest, the IOTA, has a slot for a Wi-Fi card rather than Wi-Fi on the board, and the Mu is a module that needs a carrier board.
- None has a LoRa radio; it would be added on any of them ([LORA.md](LORA.md)).

## What matters for the cyber-deck

The points the comparison looks at, taken from what is decided.
Task T1 turns them into requirements; until then they are questions, not thresholds.

1. **Linux support:** whether the mainline Linux kernel supports the board, so any distribution runs on it and it can outlive its maker's software ([decision D6](ROADMAP.md#d6-operating-system-of-the-first-prototype)).
2. **Size:** how large the board is, for a device that is pocket-sized if possible.
3. **Wi-Fi:** whether Wi-Fi is on the board, on a replaceable card, or has to be added.
4. **Power:** what supply it needs and how much it draws, which sets the battery and battery life.
5. **Serviceability:** whether the owner can replace the board, its storage and its radios.
6. **Availability:** how long it stays on sale, and its price.

## Comparison

| Board | Chip | Size (mm) | Wi-Fi | Power input | Mainline Linux | In production until |
|---|---|---|---|---|---|---|
| [Raspberry Pi 5](#raspberry-pi-5) | Broadcom BCM2712, Arm | 85 × 56 | On board, 2.4 and 5 GHz | 5 V, 5 A, USB-C | Board and GPU | At least January 2036 |
| [Raspberry Pi Zero 2 W](#raspberry-pi-zero-2-w) | RP3A0, Arm | 65 × 30 | On board, 2.4 GHz only | Micro USB | Board | At least January 2030 |
| [Orange Pi 5](#orange-pi-5-family) | Rockchip RK3588S, Arm | 100 × 62 | M.2 card, shares the SSD slot | 5 V, 4 A, USB-C | Board and GPU | Not found |
| [Orange Pi 5 Pro](#orange-pi-5-family) | Rockchip RK3588S, Arm | 89 × 56 | On board, 2.4 and 5 GHz | 5 V, 5 A, USB-C | Board and GPU | Not found |
| [Orange Pi 6](#orange-pi-6-and-6-plus) | CIX P1 (CD8180), Arm | 90 × 90 | M.2 card, optional | 20 V, 5 A, USB-C | ⚠ No board support found | Not found |
| [Orange Pi 6 Plus](#orange-pi-6-and-6-plus) | CIX P1, Arm | 115 × 100 | M.2 card, optional | 20 V, 5 A, USB-C | ⚠ No board support found | Not found |
| [LattePanda IOTA](#lattepanda-x86-boards) | Intel N150, x86 | 88 × 70 | M.2 card slot | 15 V USB-C, or 10–15 V | Not needed (unsourced) | Not found |
| [LattePanda Mu](#lattepanda-x86-boards) | Intel N100 or i3-N305, x86 | 69.6 × 60, module | On the carrier board | Not stated | Not needed (unsourced) | Not found |
| [LattePanda 3 Delta](#lattepanda-x86-boards) | Intel N5105, x86 | 125 × 78 | Intel AX201, Wi-Fi 6 | 12 V, or 15 V USB-C | Not needed (unsourced) | Not found |
| [LattePanda Sigma](#lattepanda-x86-boards) | Intel Core i5-1340P, x86 | 146 × 102 | M.2 card, in some versions | 12–20 V, or 20 V USB-C | Not needed (unsourced) | Not found |

How to read the columns:

- **Mainline Linux:** whether the mainline Linux kernel (7.4-rc4 on 2026-11-24) has a description of the board (a device tree), and whether its graphics chip (GPU) has an open driver there.
  An Arm board needs a device tree for its parts to work; an x86 board describes itself to the kernel the way a PC does, so it needs none (unsourced).
- **In production until:** the maker's published promise, where there is one.

Sources: the sections below.

## Raspberry Pi boards

### Raspberry Pi 5

- **Chip:** Broadcom BCM2712, four Arm Cortex-A76 cores at 2.4 GHz; VideoCore VII GPU.
- **Memory:** 1, 2, 4, 8 or 16 GB.
- **Size:** 85 × 56 mm.
- **Wi-Fi and Bluetooth:** dual-band 802.11ac Wi-Fi and Bluetooth 5.0, on the board.
- **Storage:** microSD, and an NVMe SSD through a separate M.2 adapter on its PCIe connector.
- **Power:**
  - 5 V, 5 A over USB-C, with USB Power Delivery; Raspberry Pi recommends its 27 W supply.
  - ⚠ On a supply that offers only 3 A, the Pi 5 limits what its USB ports may draw (to 600 mA, against 1.6 A on a 5 A supply) and doesn't start from USB by default (check C13).
  - ⚠ Switched off, it draws about 1 to 1.4 W unless set to cut power on halt (check C13).
- **Mainline Linux:** device trees for the Pi 5, with the GPU on the open V3D driver ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
- **Secure boot:** documented publicly, with Raspberry Pi's own open tool ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
- **Production:** until at least January 2036.
- **Price:**
  - Raspberry Pi's list prices of 2026-02-02 were $45 for 1 GB, $65 for 2 GB, $85 for 4 GB, $125 for 8 GB and $205 for 16 GB.
  - A US reseller's prices of 2026-11-03 were $45, $77.50, $110, $175 and $385.
  - ⚠ Raspberry Pi's product page gives $305 for 16 GB, undated (check C15).
- **Related:** the Compute Module 5 is the same chip as a plug-in module, for a carrier board of the project's own ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)); the earlier [handheld proposal](HANDHELD.md#main-board) uses either.

Sources: [Raspberry Pi 5][rpi5], [Raspberry Pi 5 product brief][rpi5-brief], [Raspberry Pi hardware documentation][rpi-hw], [Notebookcheck on Pi 5 prices][nbc-rpi5], [PCWorld on Pi 5 prices][pcworld-rpi5], [Linux: Broadcom device trees][linux-broadcom].

### Raspberry Pi Zero 2 W

- **Chip:** RP3A0, a system-in-package with four Arm Cortex-A53 cores at 1 GHz.
- **Memory:** 512 MB, the only option.
- **Size:** 65 × 30 mm.
- **Wi-Fi and Bluetooth:** 2.4 GHz 802.11b/g/n Wi-Fi and Bluetooth 4.2, on the board with its own antenna; no 5 GHz Wi-Fi.
- **Power:** over micro USB.
  ⚠ Raspberry Pi's documentation recommends a 2 A supply and gives about 350 mA for the bare board (check C15).
- **Mainline Linux:** a device tree for the board (`bcm2837-rpi-zero-2-w`).
- **Production:** until at least January 2030.
- **Price:** $15 at launch in 2021; ⚠ a current price was not found (check C15).

Sources: [Raspberry Pi Zero 2 W][rpi-zero2w], [Raspberry Pi hardware documentation][rpi-hw], [Linux: Broadcom device trees][linux-broadcom].

## Orange Pi boards

Orange Pi is a brand of Shenzhen Xunlong.

### Orange Pi 5 family

Boards on Rockchip's RK3588S or RK3588, with four Cortex-A76 and four Cortex-A55 cores, an Arm Mali-G610 GPU and a 6 TOPS neural processor.

- **Orange Pi 5:**
  - 100 × 62 mm, 46 g; 4 to 16 GB of memory.
  - Wi-Fi 6 and Bluetooth 5.0 only through an optional M.2 card (Ampak AP6275P), in the same M.2 slot as the SSD, so it has one or the other.
  - ⚠ Power: 5 V, 4 A; the launch article lists a DC jack and USB-C, then says only USB-C remains (check C15).
  - Launched in 2022 at $60 for 4 GB and $75 for 8 GB, later $75 and $90.
- **Orange Pi 5 Pro:**
  - 89 × 56 mm, 62 g; 4, 8 or 16 GB.
  - Dual-band Wi-Fi 5 and Bluetooth 5.0 on the board (Ampak AP6256), with an external antenna, and a separate M.2 slot for an SSD.
  - 5 V, 5 A over USB-C.
  - Launched in 2024 at $60 for 4 GB, $80 for 8 GB and $109 for 16 GB.
- **Other models:** the 5B adds Wi-Fi 6 and Bluetooth on the board; the 5 Plus, 5 Max and 5 Ultra use the full RK3588.
  ⚠ Their sizes and prices weren't checked (check C15).
- **Software from Orange Pi:** Debian, Ubuntu, Android and its own Orange Pi OS, on Linux 5.10 from Rockchip.
- **Mainline Linux:** device trees for the Orange Pi 5, 5B, 5 Pro, 5 Plus, 5 Max and 5 Ultra, and for the CM5 module, with the Mali GPU on the open Panthor driver ([BOARDS.md](BOARDS.md#rockchip-rk3588-boards)).
- **Secure boot:** the RK3588's secure boot has a single root key that can't be changed, and its signing tool from Rockchip is closed; an open replacement exists ([BOARDS.md](BOARDS.md#rockchip-rk3588-boards)).

Sources: [CNX Software on the Orange Pi 5][cnx-opi5], [CNX Software on the Orange Pi 5 Pro][cnx-opi5pro], [Linux: Rockchip device trees][linux-rockchip].

### Orange Pi 6 and 6 Plus

Boards on CIX's P1, a 12-core Armv9 chip (eight Cortex-A720 and four Cortex-A520 cores) made at 6 nm, with an Arm Immortalis-G720 GPU and a neural processor of about 30 TOPS.

- **Orange Pi 6** (June 2026):
  - 90 × 90 mm, 106 g; 8 to 32 GB of memory.
  - Two 2.5 Gbit/s Ethernet ports; Wi-Fi and Bluetooth only through an optional M.2 card.
  - 20 V, 5 A over USB-C; CNX Software advises the 100 W supply to avoid random restarts.
  - Unlike the 6 Plus, it has no battery connector.
  - Launch prices $239 for 8 GB to $569 for 32 GB, with a fan.
- **Orange Pi 6 Plus** (October 2025):
  - 115 × 100 mm, 132 g; 16, 32 or 64 GB.
  - Two 5 Gbit/s Ethernet ports; Wi-Fi and Bluetooth only through an optional M.2 card.
  - 20 V, 5 A over USB-C, sold with a 100 W supply; a battery connector with a charging chip, ⚠ with few details given (check C15).
  - $199 for 16 GB and $249 for 32 GB from Orange Pi, but sold only as a kit with a cooler and supply, at $223.90 and $268.89 at launch.
  - Needs a fan, which one reviewer found loud.
- **Power use:** one reviewer measured the 6 Plus over a month at about 15 W at rest and up to about 30 W under load; ⚠ no figure from Orange Pi, and none for the Orange Pi 6 (check C15).
- **Software:**
  - Orange Pi lists Debian, Ubuntu, Android, Windows and others; its documentation was mostly empty at both launches.
  - The reviewer's image used Orange Pi's kernel 6.6.89; the GPU worked only with Arm's closed driver.
  - Canonical's experimental Ubuntu 26.04 image for CIX P1 boards, tested on the 6 Plus, uses Linux 7.0 from CIX's own tree, with patches on top of mainline that CIX means to upstream.
    ⚠ It says it uses only open-source drivers, which differs from the reviewer's finding (check C15).
- **Mainline Linux:** the P1 chip and Radxa's Orion O6 board have device trees; no device tree for either Orange Pi board was found.

Sources: [CNX Software on the Orange Pi 6][cnx-opi6], [CNX Software on the Orange Pi 6 Plus][cnx-opi6plus], [Tao of Mac review of the 6 Plus][taoofmac-opi6plus], [OMG! Ubuntu on CIX P1][omgubuntu-cix], [Linux: CIX device trees][linux-cix].

## LattePanda x86 boards

LattePanda is DFRobot's range of Intel boards.
Unlike the Arm boards above, they are PCs on a small board: they boot like a PC, and ordinary x86 Linux distributions run on them without a board-specific kernel (unsourced).
Each has a small microcontroller on the board for electronics projects.

- **LattePanda IOTA:**
  - Intel N150, four cores up to 3.6 GHz, base power 6 W (adjustable 6–15 W).
  - 88 × 70 × 19 mm; 8 or 16 GB of memory, 64 or 128 GB of storage on the board.
  - No Wi-Fi on the board; an M.2 2230 slot for a Wi-Fi card.
  - Power: 15 V over USB-C Power Delivery, or 10–15 V through a connector; a UPS expansion board is offered.
  - An RP2040 microcontroller.
  - Windows, and Ubuntu 22.04 and 24.04.
  - ⚠ Price not found (check C15).
- **LattePanda Mu:**
  - A compute module, 69.6 × 60 mm, with a 260-pin SO-DIMM edge connector; it needs a carrier board, LattePanda's or the project's own ([MU-CARRIERS.md](MU-CARRIERS.md)).
  - Intel N100 (four cores, 6 W) or Core i3-N305 (eight cores, 15 W); up to 16 GB of memory and 64 GB of storage.
  - No Wi-Fi on the module.
  - Windows and Linux.
  - In January 2025, $169 for the N100 and $259 for the i3-N305, with 16 GB, without a carrier board.
- **LattePanda 3 Delta:**
  - Intel Celeron N5105; 125 × 78 × 16 mm; 8 GB of memory and 64 GB of storage.
  - Wi-Fi 6 and Bluetooth 5.2 (Intel AX201).
  - 12 V through a connector, or 15 V over USB-C Power Delivery.
  - An ATmega32U4 microcontroller; Windows and Ubuntu.
- **LattePanda Sigma:**
  - Intel Core i5-1340P, 12 cores, base power 28 W; 146 × 102 mm; 16 or 32 GB.
  - Wi-Fi 6E (Intel AX211) in some versions, none in others.
  - 12–20 V, or 20 V over USB-C, with a 90 W supply.
  - Windows, Ubuntu and Proxmox.
- **Linux on them:** Intel's graphics and Wi-Fi chips have open drivers in mainline Linux (unsourced).
- **Secure boot:** PC-style UEFI secure boot (unsourced); ⚠ how it is set up on these boards wasn't checked (check C15).
- **Production:** no promise found.

Sources: [LattePanda IOTA specification][lp-iota-spec], [LattePanda IOTA][lp-iota], [LattePanda Mu][lp-mu], [CNX Software on the LattePanda Mu][cnx-lp-mu], [LattePanda 3 Delta specification][lp-delta-spec], [LattePanda Sigma specification][lp-sigma-spec].

## What the comparison shows

Observations for task T1 and decision D1, not a choice.

- **Size:** the Zero 2 W (65 × 30 mm) is far smaller than any other board; the Pi 5, the Orange Pi 5 Pro and the LattePanda IOTA are close to one another (85 × 56, 89 × 56 and 88 × 70 mm); the Orange Pi 6 boards and the larger LattePandas are bigger than a pocket-sized device is likely to allow (unsourced).
- **Wi-Fi:** on the board in the Pi 5, the Zero 2 W (2.4 GHz only), the Orange Pi 5 Pro and 5B, and the LattePanda 3 Delta; on a replaceable M.2 card in the others.
  A card can be replaced by its owner, but takes space (unsourced).
- **Power:** the boards range from a 5 V supply (Raspberry Pi, Orange Pi 5) to 15–20 V (Orange Pi 6, LattePanda), which changes how the battery is built; the Orange Pi 6 Plus's measured 15 W at rest would empty a phone-sized battery in a few hours (unsourced).
- **Linux:** the Raspberry Pi boards and the Orange Pi 5 family are in mainline Linux, the LattePanda boards run any x86 distribution, and the Orange Pi 6 boards still depend on CIX's own kernel.
- **Availability:** only Raspberry Pi publishes how long its boards stay in production.
- **LoRa:** no board has it; every board would need a LoRa radio added, on SPI or USB ([LORA.md](LORA.md)).

## Sources

All checked on 2026-11-24.

### Raspberry Pi

- [Raspberry Pi 5][rpi5]: chip, GPU, memory, Wi-Fi, power, production to 2036, and the $305 price.
- [Raspberry Pi 5 product brief][rpi5-brief]: the board's size and its features.
- [Raspberry Pi hardware documentation][rpi-hw]: supply and USB current figures, and power when off.
- [Notebookcheck on Pi 5 prices][nbc-rpi5]: Raspberry Pi's list prices up to 2026-02-02.
- [PCWorld on Pi 5 prices][pcworld-rpi5]: a US reseller's prices on 2026-11-03.
- [Raspberry Pi Zero 2 W][rpi-zero2w]: chip, memory, size, Wi-Fi, power, production to 2030, and the launch price.

### Orange Pi

- [CNX Software on the Orange Pi 5][cnx-opi5]: size, memory, the M.2 Wi-Fi card, power, software and launch prices.
- [CNX Software on the Orange Pi 5 Pro][cnx-opi5pro]: size, Wi-Fi, power, software and prices.
- [CNX Software on the Orange Pi 6][cnx-opi6]: chip, size, memory, Wi-Fi card, power, no battery connector, and prices.
- [CNX Software on the Orange Pi 6 Plus][cnx-opi6plus]: size, memory, battery connector, power and prices.
- [Tao of Mac review of the 6 Plus][taoofmac-opi6plus]: measured power, the vendor kernel, the closed GPU driver and the fan.
- [OMG! Ubuntu on CIX P1][omgubuntu-cix]: Canonical's experimental Ubuntu 26.04 image.

### LattePanda

- [LattePanda IOTA specification][lp-iota-spec] and [LattePanda IOTA][lp-iota]: chip, size, Wi-Fi slot, power, microcontroller and systems.
- [LattePanda Mu][lp-mu] and [CNX Software on the LattePanda Mu][cnx-lp-mu]: the module, its chips, size and prices.
- [LattePanda 3 Delta specification][lp-delta-spec] and [LattePanda Sigma specification][lp-sigma-spec]: chips, sizes, Wi-Fi and power.

### Linux

- [Linux: Broadcom device trees][linux-broadcom], [Linux: Rockchip device trees][linux-rockchip] and [Linux: CIX device trees][linux-cix]: which boards the mainline kernel describes (Linux 7.4-rc4).

[rpi5]: https://www.raspberrypi.com/products/raspberry-pi-5/
[rpi5-brief]: https://cdn.sparkfun.com/assets/9/9/0/d/e/raspberry-pi-5-product-brief.pdf
[rpi-hw]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html
[nbc-rpi5]: https://www.notebookcheck.net/Raspberry-Pi-5-now-costs-up-to-205-due-to-RAM-crisis.1218213.0.html
[pcworld-rpi5]: https://www.pcworld.com/article/3275871/ouch-the-raspberry-pi-5-just-hit-an-eye-watering-385.html
[rpi-zero2w]: https://www.raspberrypi.com/products/raspberry-pi-zero-2-w/
[cnx-opi5]: https://www.cnx-software.com/2022/07/15/orange-pi-5-most-affordable-rockchip-rk3588s-sbc/
[cnx-opi5pro]: https://www.cnx-software.com/2024/04/12/orange-pi-5-pro-low-cost-rockchip-rk3588s-sbc-16gb-lpddr5-ram-dual-hdmi/
[cnx-opi6]: https://www.cnx-software.com/2026/06/25/orange-pi-6-cix-cd8180-12-core-arm-sbc-gets-2-5gbe-networking-smaller-form-factor-drops-battery-support/
[cnx-opi6plus]: https://www.cnx-software.com/2025/10/15/orange-pi-6-plus-cix-p1-sbc-64gb-lpddr5-45-tops-ai-performance/
[taoofmac-opi6plus]: https://taoofmac.com/space/reviews/2026/04/11/1900
[omgubuntu-cix]: https://www.omgubuntu.co.uk/2026/05/ubuntu-cix-p1-support
[lp-iota-spec]: https://docs.lattepanda.com/content/iota_edition/specification/
[lp-iota]: https://www.lattepanda.com/lattepanda-iota
[lp-mu]: https://www.lattepanda.com/lattepanda-mu
[cnx-lp-mu]: https://www.cnx-software.com/2025/01/02/lattepanda-mu-som-intel-core-i3-n305-octa-core-soc/
[lp-delta-spec]: https://docs.lattepanda.com/content/3rd_delta_edition/specification/
[lp-sigma-spec]: https://docs.lattepanda.com/content/sigma_edition/Specification/
[linux-broadcom]: https://github.com/torvalds/linux/tree/master/arch/arm64/boot/dts/broadcom
[linux-rockchip]: https://github.com/torvalds/linux/tree/master/arch/arm64/boot/dts/rockchip
[linux-cix]: https://github.com/torvalds/linux/tree/master/arch/arm64/boot/dts/cix
