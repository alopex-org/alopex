# Cyber-deck prototype

**Status: proposal.**
This page describes the proposed first device: a rugged, hand-held cyber-deck built around a Raspberry Pi, for private messaging with and without a network.
Nothing on it is decided.
The design comes from a set of concept renders shared with the members in November 2026; they show the look and the layout, not a finished engineering design.
The maintainers weigh it in roadmap decisions [D1](ROADMAP.md#d1-route-to-a-prototype) (route to a prototype), [D2](ROADMAP.md#d2-cellular-or-wi-fi-only) (cellular or Wi-Fi only), [D6](ROADMAP.md#d6-operating-system-of-the-first-prototype) (operating system), [D7](ROADMAP.md#d7-signal-gauges) (signal gauges) and [D8](ROADMAP.md#d8-case) (case).
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-23.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it.
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.

## In short

- **The device:** an upright hand-held computer with a touchscreen that slides sideways to uncover a physical keyboard, a telescopic LoRa antenna, two signal gauges on top, knobs on the sides, and two 18650 batteries at the back that can be swapped one at a time while it runs.
- **What it is for:** encrypted messages without any network over a LoRa mesh, with position sharing, and over the internet through Wi-Fi when there is one.
- **Inside:** a Raspberry Pi Compute Module 5 on a board of the project's own, a LoRa radio, a GNSS receiver, a removable USB Wi-Fi adapter, and hardware switches that cut the radios and the microphone.
- **Its software** is [FoxieOS](https://github.com/alopex-org/foxieos), a Linux system for this device (decision D6).
- **It fits the plan's cheapest route:** Wi-Fi only, with no cellular module and no mobile-network patent licences (decisions D1 and D2).
- **The hard parts** are mechanical: the sliding screen and its cable, the double battery bay, and fitting it all in a case that is still hand-held.
- **The price is size and apps:** the device is thick and heavy, and mainstream apps don't run on it.

## What a cyber-deck is

- A cyber-deck is a custom-built, portable computer, often made for one purpose, usually with a "cyberpunk" look; the word comes from the "cyberspace deck" in William Gibson's 1984 novel *Neuromancer*.
- Builders typically use a single-board computer such as a Raspberry Pi, a compact screen and keyboard, and lithium-ion batteries, in a 3D-printed body or a rugged case; some carry LoRa radios running Meshtastic.
- Hackaday, which has run cyber-deck contests since 2022, gives no strict definition: a computer that serves a practical purpose, nominally with a keyboard and a display, and above all personal.

So the device is meant to be opened, repaired and changed by its owner, which suits a prototype built in small numbers.

Sources: [Wikipedia: Cyberdeck][wiki-cyberdeck], [Hackaday 2022 contest][had-2022], [Hackaday 2023 contest][had-2023].

## The design

What the concept renders show, part by part.

### Front

- A **portrait touchscreen** in a raised, screwed frame, with three buttons under it: back, home and overview.
- An **instrument panel** above the screen: a strip showing the radio band, and two round gauges, one for the received signal's strength (RSSI, in dBm) and one for its clarity (SNR, in dB).
- The **Alopex name and fox logo** between the panel and the screen.
- A **carry handle** across the top and a **loop** across the bottom, in tubes with copper-coloured ends.
- A dark, gunmetal-grey case with copper accents and visible screws.

### Slide-out keyboard

- The screen slides sideways, to the right, and uncovers a **physical keyboard**; a latch marked "RELEASE" on the left edge holds it closed.
- With the screen out, the device is held **sideways**: the keys and the screen's contents turn a quarter.
- The keyboard has about 35 keys: the letter rows Q–P, A–L and Z–M, with Shift, Ctrl, Fn, a long space bar, Enter and Backspace.
- Rails on the back of the screen panel guide the slide.

### Sides

- **Left:** a USB-C port, two knurled knobs, a round button or connector, an orange light, and a battery indicator near the bottom.
- **Right:** a knurled knob, and buttons along the edge.

### Back and batteries

- **Two battery bays, A and B,** each holding one 18650 cell in a sled with a copper-coloured latch.
- One sled can be pulled out while the device runs on the other.

### Antenna

- A **telescopic whip antenna** at the top left, on a thick, ribbed base.
- ⚠ The renders label the radio "LoRa 925 MHz", which is in the US band (902–928 MHz).
  In Greece and the rest of Europe the device must use 868 MHz, and Meshtastic's EU_868 setting uses 869.4–869.65 MHz ([LORA.md](LORA.md#certification-and-band-rules)).
  The antenna and the radio module are chosen for 868 MHz.

### The screens shown

- Upright: "alopex mesh", with "12 bays · 2.3 kbps · SF10", and a list of twelve entries, each with a signal strength between about −78 and −106 dBm, and "A" and "B" markers that the renders don't explain.
- Sideways: the same mesh as "12 nodes", spread over the screen.
- A status bar with the mesh, a lock, the battery at 96%, and signal bars.

These are mock-ups of FoxieOS's interface, which FoxieOS designs on its side (its decision D11).

## How it fits the plan

- **Decision D1 (route to a prototype):** a Compute Module 5 on a board of the project's own, in a case of the project's own.
- **Decision D2 (cellular or Wi-Fi only):** Wi-Fi only, the cheaper first prototype the roadmap recommends.
- **Decision D4 (LoRa mesh network):** Meshtastic by default.
- **Decision D6 (operating system):** FoxieOS, a Linux system, instead of Android.
- **Decisions D7 (signal gauges) and D8 (case):** new with this design.
- **Task T1 (hardware requirements):** the switches and swappable batteries are requirements T1 already lists.
- **Task T7 (cyber-deck bench build)** tries the electronics on the bench, and **task T8 (case and slide mock-up)** tries the mechanics.

## The proposal

| Part | Proposed | Details |
|---|---|---|
| Main board | Raspberry Pi Compute Module 5 on a carrier board of the project's own | [Main board](#main-board) |
| Screen | A portrait touchscreen on a slide | [Screen and slide](#screen-and-slide) |
| Keyboard | About 35 keys, with a small controller | [Keyboard](#keyboard) |
| LoRa radio | SX1262, 868 MHz, telescopic antenna | [LoRa radio](#lora-radio) |
| Signal gauges | RSSI and SNR, on top | [Signal gauges](#signal-gauges) |
| Knobs and buttons | Rotary knobs on the sides, three buttons under the screen | [Knobs and buttons](#knobs-and-buttons) |
| Wi-Fi | A removable USB adapter | [Wi-Fi adapter](#wi-fi-adapter) |
| Position | A GNSS receiver | [Position](#position) |
| Hardware switches | Cut power to Wi-Fi, LoRa, GNSS and the microphone | [Hardware switches](#hardware-switches) |
| Batteries | Two 18650 cells, swapped one at a time | [Batteries](#batteries) |
| Case | Rugged, screwed together, with handles | [Case and size](#case-and-size) |
| Operating system | FoxieOS | [Operating system](#operating-system) |

## Parts

### Main board

- **Raspberry Pi Compute Module 5 (CM5),** on a carrier board of the project's own; the Raspberry Pi 5 is the ready-made board for bench work.
  [BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5) compares them with the other boards.
- The CM5 is sold with or without wireless; one without wireless leaves the USB adapter as the device's only Wi-Fi.
  It comes with 2–16 GB of memory and 0–64 GB of built-in storage (eMMC), from $67.50, and stays in production until at least January 2036.
- Secure boot is documented publicly, and Raspberry Pi's own open tool sets it up; it writes a key's fingerprint into the chip for good ([DESIGN.md](DESIGN.md#each-party-keeps-its-own-keys)).
- ⚠ The Pi 5's supply needs, and how much current its USB ports may draw, need checking against Raspberry Pi's documentation (check C13).

Sources: [Compute Module 5][rpi-cm5], [Raspberry Pi hardware documentation][rpi-hw].

### Screen and slide

- The renders show a tall screen, roughly the size of a small phone's; its size isn't set.
  Other hand-helds use a 4-inch, 720 × 720 touchscreen (HackberryPi CM5) or a 5-inch, 1280 × 720 screen (uConsole).
- **The slide is the hardest mechanical part:** the screen's cable has to bend every time the screen moves, and the rails have to hold the screen firmly in both positions (unsourced).
- **A sensor** (a magnet and a Hall sensor, or a switch) tells FoxieOS whether the screen is out, so it can turn the interface (unsourced).
- **Task T8** builds the slide first as a mock-up, before any electronics go in.

### Keyboard

- About 35 keys, with Shift, Ctrl and Fn layers for numbers and symbols.
- **Own keys, or a reused keyboard:**
  - Beepy and the HackberryPi reuse BlackBerry keyboards; Beepy reads its keyboard with an RP2040 microcontroller.
  - The renders' keys are larger than a BlackBerry's, which suggests keys of the project's own in a grid, read by a small microcontroller that shows up to the CM5 as a USB keyboard (unsourced).
- The keys must still be reachable with the screen slid out, and protected when it is in.

Sources: [Hackaday: Beepy review][had-beepy], [HackberryPi CM5][hackberry-cm5].

### LoRa radio

- **Choose the SX1262.**
  Meshtastic recommends it, and most current Meshtastic hardware uses it.
- **Straight to the CM5, over SPI:** Meshtastic's Linux service, `meshtasticd`, drives an SX1262 on the Pi's SPI pins.
  This differs from the plan's earlier design, a small separate processor with its own LoRa chip ([LORA.md](LORA.md#integrating-the-radio)); the CM5 then stays awake for the mesh, which costs battery (unsourced).
  Task T6 compares the two on the bench.
- **Antenna:** a telescopic whip tuned for 868 MHz on an SMA connector.
  A quarter of the wavelength at 868 MHz is about 8.6 cm, a guide to the whip's length (calculation).
  Never transmit without the antenna connected, which can damage the radio (unsourced).
- **Band rules:** in Europe the software keeps to the EU_868 limits on power and transmitting time ([LORA.md](LORA.md#certification-and-band-rules)).

Sources: [Meshtastic Linux hardware][mt-linux], [Meshtastic LoRa configuration][mt-lora].

### Signal gauges

The two round gauges show the strength (RSSI) and clarity (SNR) of the last LoRa message received.
Whether they are real needles or small round screens is decision [D7](ROADMAP.md#d7-signal-gauges).

- **Moving-coil meters:** real needles, driven by the CM5 or a microcontroller; they look like the renders, but are fragile and need their own scale printed (unsourced).
- **Small round screens:** draw the needle in software, can show more, and survive drops better, but use more power (unsourced).
- **Either way,** a reading arrives only with each received message, so the needle jumps and then rests; FoxieOS decides how to show that (unsourced).
- The band strip above the screen can be a small display or a printed label.

### Knobs and buttons

- **Rotary knobs** (rotary encoders, which turn without end and click) for scrolling, volume or choosing a channel (unsourced).
- **Three buttons under the screen** (back, home, overview), and buttons on the right edge.
- Each is read by the CM5's pins or the keyboard's microcontroller; what each does is FoxieOS's choice.

### Wi-Fi adapter

- A USB adapter that can be pulled out, or cut off by a hardware switch, takes the device off the internet for certain.
- Linux supports some adapters' chips better than others, so the adapter should be chosen for an open driver in the mainline kernel (unsourced).
- A new, random hardware address (MAC address) for every connection is a setting of the operating system, not of the hardware.

### Position

- A GNSS receiver (for GPS and similar satellite systems) lets the device share its position over the mesh.
- Meshtastic shares a node's position from the node's own GPS, or from a paired phone, and lets an external GPS module connect to a node's pins.
- ⚠ Whether `meshtasticd` on Linux can use a GPS receiver isn't stated in Meshtastic's documentation (check C14).

Sources: [Meshtastic position settings][mt-position].

### Hardware switches

Switches on the edge of the case cut the power to the USB Wi-Fi adapter, the LoRa radio, the GNSS receiver and the microphone.

- Phones on sale already do this: the FuriLabs FLX1s cuts the microphone, the cameras and the modem ([FEASIBILITY.md](FEASIBILITY.md#furilabs-flx1s)), and the SHIFTphone 8 has a switch for the camera and microphone ([FEASIBILITY.md](FEASIBILITY.md#partnership-with-a-phone-maker)).
- **Cut the data lines too, or isolate them.**
  A part whose power is cut can still be powered, partly, through the wires that carry its data (unsourced; check C14).
- **Let the operating system see each switch,** so software doesn't keep using a part that is switched off (unsourced).
- **Never cut the LoRa radio's antenna instead of its power,** which can damage the radio (unsourced).
- The renders don't show where the switches sit; the knobs and the side buttons are candidates, and task T8 places them.

### Batteries

- **Two bays, A and B,** each with one protected 18650 lithium-ion cell in a sled the user pulls out by hand.
- **Swapping while it runs:** the two cells feed the device through a power-path controller ("ideal diodes") that takes power from whichever cell is present, so pulling one leaves the other running it (unsourced).
  This replaces the small backup cell of the earlier handheld proposal.
- **Each bay needs** its own protection, a charger that can charge each cell on its own, and a way to tell the operating system which cells are present and how full they are (unsourced).
- **A cell put in backwards** must not damage anything, since users swap them by hand (unsourced).
- **Power budget:** the CM5, the screen and the radios draw more than a microcontroller device; the converter to 5 V and the battery life are the main electrical work (check C13).
- **EU rules:** from 2027-02-18, batteries in portable products must be removable and replaceable by the user, which this design meets ([FEASIBILITY.md](FEASIBILITY.md#eu-battery-rules)).

### Case and size

- The renders show a rugged, screwed-together case with handles.
  How it is made (3D-printed, machined aluminium, or both) is decision [D8](ROADMAP.md#d8-case).
- **Thickness:** at least the 18 mm of a cell, plus the main board, the keyboard and the sliding screen on top (calculation from the cell size).
  The HackberryPi CM5, with a flat battery and no slide, is 17.6 mm thick and weighs 306 g.
- **Weight:** two cells, a metal case and handles make it heavier than a phone; task T8 weighs the mock-up.
- **Openings** for the USB-C port, the antenna, the knobs and the battery sleds let in dust and water unless sealed (unsourced).

Sources: [HackberryPi CM5][hackberry-cm5].

## Cyber-decks that already exist

What is on sale or published, to compare the design with.

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

### What this means for the design

- **The uConsole is the closest:** a Raspberry Pi compute module, two 18650 cells, and LoRa on a board inside.
  Its published design is a good place to learn from, within the GPL's terms.
- **None of the five has a screen that slides over its keyboard, hardware switches for its radios, or batteries swapped while it runs,** as far as their pages say.
  Those, with the signal gauges, are what would set the Alopex cyber-deck apart.
- **A microcontroller device such as the T-Deck** does mesh messaging for days on a small battery; a Linux computer does more but draws more (unsourced).

Sources: [clockworkPi uConsole][uconsole], [CNX Software on the uConsole][cnx-uconsole], [RTL-SDR.com on the add-on board][rtlsdr-aio], [HackberryPi CM5][hackberry-cm5], [Meshtastic: T-Deck][mt-tdeck], [Hackaday: Beepy review][had-beepy], [MNT Pocket Reform][mnt-pocket].

## Operating system

The device runs [FoxieOS](https://github.com/alopex-org/foxieos), a Linux system for it (decision [D6](ROADMAP.md#d6-operating-system-of-the-first-prototype)).

- FoxieOS is a separate project, and adapts to this design; this project doesn't follow FoxieOS's plan ([DESIGN.md](DESIGN.md#a-separate-project)).
- **Android on a CM5:** only a community build exists, with its security rules (SELinux) off, no encryption of user data, and a ban on commercial use ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
- **What the hardware must allow** for FoxieOS's plans:
  - encrypting the whole storage, which LUKS does on Linux;
  - a new random MAC address on every network;
  - messaging over the internet with apps such as Session, which needs no phone number and has a Linux app, and Briar, whose Linux app is a beta;
  - Meshtastic's own encryption over LoRa: AES with a shared key on channels, a key pair for each device on direct messages; message headers aren't encrypted and there is no forward secrecy.
- **No home-made encryption:** encryption written from scratch is easy to get wrong, and wouldn't talk to other Meshtastic devices (unsourced).

Sources: [cryptsetup][cryptsetup], [Session][session], [Briar Desktop][briar-desktop], [Meshtastic encryption][mt-encryption].

## What it costs the user

- **Size and weight:** with two 18650 cells, a telescopic antenna, a sliding screen and a rugged case, the device is closer to a hand-held radio than a phone.
- **No mainstream apps:** banking apps, WhatsApp, Instagram and Google's services don't run on it.
- **Careful use:** no hardware protects a user who signs in to accounts in their own name, uses their home Wi-Fi, or carries the device switched on everywhere (unsourced).
  That belongs in a user guide, not in the hardware.

## Open questions

- Whether the gauges are needles or small screens (decision D7), and how the case is made (decision D8).
- The screen's size, and whether its cable survives the slide (task T8, check C15).
- The double battery bay's power path, and the battery life (checks C13 and C16).
- Whether cutting power alone switches a part off fully, and whether `meshtasticd` can use a GPS receiver (check C14).
- Whether handing a device to someone outside the maintainers makes the project a manufacturer (check C12).

## Sources

All checked on 2026-11-23.

### Cyber-decks

- [Wikipedia: Cyberdeck][wiki-cyberdeck]: the definition, the origin in *Neuromancer*, and what builders use.
- [Hackaday 2022 contest][had-2022] and [Hackaday 2023 contest][had-2023]: Hackaday's criteria for a cyber-deck.
- [clockworkPi uConsole][uconsole]: modules, screen, keyboard, 18650 cells, GPL v3, 4G module.
- [CNX Software on the uConsole][cnx-uconsole]: two 18650 cells, modules and 4G.
- [RTL-SDR.com on the add-on board][rtlsdr-aio]: the SX1262, GNSS, clock and radio add-on board, and its price.
- [HackberryPi CM5][hackberry-cm5]: screen, keyboard, battery, size, weight and licence.
- [Meshtastic: T-Deck][mt-tdeck]: the T-Deck Plus's chips, bands, screen, GPS and battery.
- [Hackaday: Beepy review][had-beepy]: Beepy's board, screen, keyboard controller, battery, price and licence.
- [MNT Pocket Reform][mnt-pocket]: screen, keyboard, modules, Debian, battery, weight and price.

### Hardware

- [Compute Module 5][rpi-cm5]: variants with and without wireless, memory, storage, price and production until 2036.
- [Raspberry Pi hardware documentation][rpi-hw]: the Pi 5's 5 V supply and USB current limit; ⚠ the exact power figures weren't read from the page (check C13).
- [Meshtastic Linux hardware][mt-linux]: `meshtasticd` over SPI and USB, and the SX1262 recommendation.
- [Meshtastic LoRa configuration][mt-lora]: the EU_868 and US bands.
- [Meshtastic position settings][mt-position]: sharing positions, and GPS modules on a node's pins.

### Software

- [Meshtastic encryption][mt-encryption]: channel and direct-message encryption, and their limits.
- [cryptsetup][cryptsetup]: the LUKS disk-encryption tool.
- [Briar Desktop][briar-desktop]: the Linux beta and what it lacks next to Android.
- [Session][session]: onion routing, no phone number, and its desktop apps.

[briar-desktop]: https://briarproject.org/download-briar-desktop/
[cnx-uconsole]: https://www.cnx-software.com/2022/10/26/uconsole-modular-arm-or-risc-v-handheld-computer-4g-connectivity/
[cryptsetup]: https://gitlab.com/cryptsetup/cryptsetup
[hackberry-cm5]: https://github.com/CarbonComputers/Hackberry-Pi-CM5
[had-2022]: https://hackaday.com/2022/08/08/load-your-icebreakers-the-2022-cyberdeck-contest-is-here
[had-2023]: https://hackaday.com/2023/06/20/jack-in-the-2023-cyberdeck-challenge-starts-now
[had-beepy]: https://hackaday.com/2023/08/07/review-beepy-a-palm-sized-linux-hacking-playground
[mnt-pocket]: https://shop.mntre.com/products/mnt-pocket-reform
[mt-encryption]: https://meshtastic.org/docs/overview/encryption/
[mt-linux]: https://meshtastic.org/docs/software/linux/hardware/
[mt-lora]: https://meshtastic.org/docs/configuration/radio/lora/
[mt-position]: https://meshtastic.org/docs/configuration/radio/position/
[mt-tdeck]: https://meshtastic.org/docs/hardware/devices/lilygo/tdeck/
[rpi-cm5]: https://www.raspberrypi.com/products/compute-module-5/
[rpi-hw]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html
[rtlsdr-aio]: https://www.rtl-sdr.com/an-rtl-sdr-lora-gps-rtc-usb-hub-extension-board-for-the-uconsole/
[session]: https://getsession.org/
[uconsole]: https://www.clockworkpi.com/uconsole
[wiki-cyberdeck]: https://en.wikipedia.org/wiki/Cyberdeck
