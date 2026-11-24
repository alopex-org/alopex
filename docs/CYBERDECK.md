# Cyber-deck

**Status: proposal.**
Since 2026-11-24, the project is proposed to work toward a cyber-deck: a portable computer of its own.
Its primary purpose is to be user-serviceable; it has LoRa and Wi-Fi, is meant to be pocket-sized if possible, and runs a Linux distribution for now ([What is proposed](#what-is-proposed)).
Its main board, screen and controls, power, case and other radios are undecided.
This page says what a cyber-deck is, what is proposed for this one, what is undecided and where each question is decided, and describes cyber-decks that already exist.
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-23.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it.
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.

## In short

- A cyber-deck is a custom-built, portable computer, often made for one purpose, nominally with a keyboard and a screen.
- The project proposes to build one: user-serviceable and portable, with LoRa and Wi-Fi, pocket-sized if possible, running a Linux distribution for now.
- Its main board, screen and controls, power, case and other radios are undecided.
- The first step is a list of requirements (roadmap task T1); the open decisions follow from it.
- The earlier research into a phone, development boards and a Raspberry Pi handheld is background for those decisions, not a plan.

## What a cyber-deck is

- A cyber-deck is a custom-built, portable computer, often made for one purpose, usually with a "cyberpunk" look; the word comes from the "cyberspace deck" in William Gibson's 1984 novel *Neuromancer*.
- Builders typically use a single-board computer such as a Raspberry Pi, a compact screen and keyboard, and lithium-ion batteries, in a 3D-printed body or a rugged case; some carry LoRa radios running Meshtastic.
- Hackaday, which has run cyber-deck contests since 2022, gives no strict definition: a computer that serves a practical purpose, nominally with a keyboard and a display, and above all personal.

Sources: [Wikipedia: Cyberdeck][wiki-cyberdeck], [Hackaday 2022 contest][had-2022], [Hackaday 2023 contest][had-2023].

## What is proposed

Proposed 2026-11-24, for the founding meeting to confirm ([DESIGN.md](DESIGN.md#a-cyber-deck-as-the-device)):

- **Primary purpose: user-serviceable.**
  A portable cyber-deck its owner can open, repair and change: parts that can be replaced, and a design that doesn't stop the owner working on it.
  What exactly that requires is task T1.
- **LoRa and Wi-Fi.**
  The LoRa mesh radio was decided on 2026-11-21 ([LORA.md](LORA.md)); which network it runs is decision D4.
- **Pocket-sized if possible.**
  Size is a target, weighed against being user-serviceable and against battery life in task T1.
- **A Linux distribution, for now.**
  Which one is FoxieOS's decision; "for now" leaves room to revisit it (decision D6).

## What is undecided

Task T1 drafts the requirements, and the maintainers decide through the roadmap items named.

| Question | Where it is decided |
|---|---|
| What user-serviceable means in practice: which parts the owner can replace, with what tools | Task [T1](ROADMAP.md#t1-hardware-requirements) |
| Its exact size, its screen, and how it is typed on and controlled | Task T1 |
| How it is built, and around what main board | Decision [D1](ROADMAP.md#d1-route-to-a-prototype) |
| Whether it also connects to mobile networks | Decision [D2](ROADMAP.md#d2-cellular-or-wi-fi-only) |
| Its other radios, such as Bluetooth and satellite positioning | Task T1 |
| Which mesh network its LoRa radio runs | Decision [D4](ROADMAP.md#d4-lora-mesh-network) |
| Its power: battery, charging and battery life | Task T1 |
| Privacy and security, such as hardware switches and secure boot | Task T1 |
| Its case | Task T1 |
| Which Linux distribution it runs | [FoxieOS](https://github.com/alopex-org/foxieos), with decision [D6](ROADMAP.md#d6-operating-system-of-the-first-prototype) here |
| Who gets the prototypes | Decision [D3](ROADMAP.md#d3-sharing-prototypes) |
| Whether it stays a prototype or becomes a product | Decision [D5](ROADMAP.md#d5-prototype-or-product) |

## Earlier work that bears on it

- [FEASIBILITY.md](FEASIBILITY.md): the research into a phone: the routes to a device, certification and the EU's rules, which apply to the cyber-deck too if it is sold.
- [BOARDS.md](BOARDS.md): development boards compared for the earlier phone plan, which can be candidates for the bench.
- [LORA.md](LORA.md): the LoRa mesh networks, how the radio could be built in, and its certification.
- [HANDHELD.md](HANDHELD.md): a Raspberry Pi handheld proposed on 2026-11-23, one worked-out option.

## Cyber-decks that already exist

What is on sale or published, as examples of what a cyber-deck can be.
None of them is a model the project has chosen.

| Device | Computer | Screen | Keyboard | LoRa | Battery |
|---|---|---|---|---|---|
| [clockworkPi uConsole](#clockworkpi-uconsole) | Raspberry Pi CM4 and others | 5-inch, 1280 × 720 | 74 keys, trackball | On an add-on board | Two 18650 cells |
| [HackberryPi CM5](#hackberrypi-cm5) | Raspberry Pi CM5 | 4-inch, 720 × 720, touch | BlackBerry keyboard | None | 5000 mAh flat cell |
| [LILYGO T-Deck Plus](#lilygo-t-deck-plus) | ESP32-S3 microcontroller | 2.8-inch, 320 × 240 | Backlit, trackball | SX1262, built in | 2000 mAh |
| [Beepy](#beepy) | Raspberry Pi Zero | Sharp memory LCD | BlackBerry keyboard | None | 2000 mAh flat cell |
| [MNT Pocket Reform](#mnt-pocket-reform) | RK3588 or QCS6490 module | 7-inch, 1920 × 1200 | Mechanical, trackball | None | Two Li-ion cells, 8000 mAh |

### clockworkPi uConsole

- A modular hand-held for the Raspberry Pi CM4 and other modules, including a RISC-V one, with a 5-inch 720p screen, a 74-key backlit keyboard and a trackball.
- Two 18650 cells, not included; an optional 4G module.
- Its schematics, firmware and 3D files are published under the GPL v3.
- HackerGadgets makes an add-on board for it with an SX1262 LoRa chip, a GNSS receiver, a real-time clock, a software-defined radio and a USB hub, advertised at $78.99.
- ⚠ Its own page doesn't list the CM5; one news article reports a CM5 software image.

### HackberryPi CM5

- A CM5 hand-held with a 4-inch, 720 × 720 touchscreen and a reused BlackBerry Q10, Q20 or 9900 keyboard.
- A 5000 mAh battery, about 3–4 hours of typical use; 143.5 × 91.8 × 17.6 mm, 306 g, in an aluminium case.
- Its design is published under the MIT licence.

### LILYGO T-Deck Plus

- A hand-held on an ESP32-S3 microcontroller, not a Linux computer, with a keyboard, a trackball, a 2.8-inch screen, a GPS and a 2000 mAh battery.
- Its SX1262 LoRa radio comes in 868, 915 and 433 MHz versions, and it runs Meshtastic.

### Beepy

- A board that joins a BlackBerry keyboard, a Sharp memory LCD with no backlight and a 2000 mAh battery to a Raspberry Pi Zero; an RP2040 reads the keyboard.
  ⚠ The review gives the screen as 400 × 200 in one place and 400 × 240 in another.
- $79 without the Pi, under the CERN OHL v1.2 hardware licence.

### MNT Pocket Reform

- A 7-inch mini laptop with a mechanical keyboard and a trackball, on an RK3588 or a QCS6490 module, with Debian preinstalled.
- Two Li-ion cells, 8000 mAh in all, about 4 hours; 1100 g; listed at €1,329.

### What they show

- Cyber-decks range from microcontroller devices such as the T-Deck, which run a mesh network's firmware, to full computers on a single-board computer or a compute module, such as the uConsole and the Pocket Reform.
- Several publish their designs under open licences (the uConsole under the GPL v3, the HackberryPi CM5 under MIT, Beepy under the CERN OHL), which helps owners repair them and which the project can learn from within those licences' terms.
- On size, the HackberryPi CM5 shows what a Linux hand-held with a keyboard can reach: 143.5 × 91.8 × 17.6 mm and 306 g, against 1100 g for the Pocket Reform.

Sources: [clockworkPi uConsole][uconsole], [CNX Software on the uConsole][cnx-uconsole], [RTL-SDR.com on the add-on board][rtlsdr-aio], [HackberryPi CM5][hackberry-cm5], [Meshtastic: T-Deck][mt-tdeck], [Hackaday: Beepy review][had-beepy], [MNT Pocket Reform][mnt-pocket].

## Sources

All checked on 2026-11-23.

- [Wikipedia: Cyberdeck][wiki-cyberdeck]: the definition, the origin in *Neuromancer*, and what builders use.
- [Hackaday 2022 contest][had-2022] and [Hackaday 2023 contest][had-2023]: Hackaday's criteria for a cyber-deck.
- [clockworkPi uConsole][uconsole]: modules, screen, keyboard, 18650 cells, GPL v3, 4G module.
- [CNX Software on the uConsole][cnx-uconsole]: two 18650 cells, modules and 4G.
- [RTL-SDR.com on the add-on board][rtlsdr-aio]: the SX1262, GNSS, clock and radio add-on board, and its price.
- [HackberryPi CM5][hackberry-cm5]: screen, keyboard, battery, size, weight and licence.
- [Meshtastic: T-Deck][mt-tdeck]: the T-Deck Plus's chips, bands, screen, GPS and battery.
- [Hackaday: Beepy review][had-beepy]: Beepy's board, screen, keyboard controller, battery, price and licence.
- [MNT Pocket Reform][mnt-pocket]: screen, keyboard, modules, Debian, battery, weight and price.

[cnx-uconsole]: https://www.cnx-software.com/2022/10/26/uconsole-modular-arm-or-risc-v-handheld-computer-4g-connectivity/
[hackberry-cm5]: https://github.com/CarbonComputers/Hackberry-Pi-CM5
[had-2022]: https://hackaday.com/2022/08/08/load-your-icebreakers-the-2022-cyberdeck-contest-is-here
[had-2023]: https://hackaday.com/2023/06/20/jack-in-the-2023-cyberdeck-challenge-starts-now
[had-beepy]: https://hackaday.com/2023/08/07/review-beepy-a-palm-sized-linux-hacking-playground
[mnt-pocket]: https://shop.mntre.com/products/mnt-pocket-reform
[mt-tdeck]: https://meshtastic.org/docs/hardware/devices/lilygo/tdeck/
[rtlsdr-aio]: https://www.rtl-sdr.com/an-rtl-sdr-lora-gps-rtc-usb-hub-extension-board-for-the-uconsole/
[uconsole]: https://www.clockworkpi.com/uconsole
[wiki-cyberdeck]: https://en.wikipedia.org/wiki/Cyberdeck
