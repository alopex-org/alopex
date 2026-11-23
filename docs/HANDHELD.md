# Handheld prototype

**Status: earlier proposal, now one option.**
This page describes a first prototype proposed on 2026-11-23: a rugged handheld built around a Raspberry Pi, for private messaging with and without a network.
Since then, the project is proposed to work toward a cyber-deck whose purpose, parts and software are all undecided ([CYBERDECK.md](CYBERDECK.md)); this handheld is one option for it, not a plan.
Nothing on it is decided.
The maintainers weigh it in roadmap decisions [D1](ROADMAP.md#d1-route-to-a-prototype) (route to a prototype), [D2](ROADMAP.md#d2-cellular-or-wi-fi-only) (cellular or Wi-Fi only) and [D6](ROADMAP.md#d6-operating-system-of-the-first-prototype) (operating system of the first prototype).
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-23.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it.
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.

## In short

- **The device:** a Raspberry Pi in a screw-together case, with a LoRa radio and an external antenna, a removable USB Wi-Fi adapter, a satellite positioning (GNSS) receiver, hardware switches and a battery that can be swapped while it runs.
- **What it is for:** encrypted messages over the internet through Tor, and without any network over a LoRa mesh, with position sharing.
- **It fits the plan's cheapest route:** a development board in a case of the project's own, Wi-Fi only, with no cellular module and no mobile-network patent licences (decisions D1 and D2).
- **Two parts of it differ from the rest of the plan:**
  - it runs a plain Linux system, not Android, which this project was set up for (decision D6);
  - it wires the LoRa chip straight to the Pi, where the plan proposes a small separate processor for the radio ([LORA.md](LORA.md#integrating-the-radio)).
- **The proposal's own software for LoRa encryption isn't needed:** Meshtastic already encrypts messages, and a home-made scheme would add risk.
- **The price is size, apps and discipline:** the device is thick and heavy, mainstream apps don't run on it, and it protects its user only if they use it carefully.

## The proposal

| Part | Proposed | Details |
|---|---|---|
| Main board | Raspberry Pi | [Main board](#main-board) |
| LoRa radio | SX1262 or RFM95W module on the Pi's pins, 868 MHz, SMA antenna on top | [LoRa radio](#lora-radio) |
| Wi-Fi | A removable USB adapter | [Wi-Fi adapter](#wi-fi-adapter) |
| Position | A GNSS receiver | [Position](#position) |
| Hardware switches | Cut power to Wi-Fi, LoRa, GNSS and the microphone | [Hardware switches](#hardware-switches) |
| Battery | A swappable 18650 cell or camera battery, with a small backup cell | [Battery](#battery) |
| Operating system | Alpine Linux or a Buildroot system | [Operating system](#operating-system) |

## How it fits the plan

- **Decision D1 (route to a prototype):** the handheld is the option "a development board in a case of the project's own".
- **Decision D2 (cellular or Wi-Fi only):** it is Wi-Fi only, the cheaper first prototype the roadmap recommends.
- **Decision D4 (LoRa mesh network):** it uses Meshtastic, the network the roadmap recommends as the default.
- **Task T1 (hardware requirements):** its switches and swappable battery are requirements T1 already lists, extended to Wi-Fi and GNSS.
- **Decision D6 (operating system of the first prototype):** new with this proposal, because the project was set up to build hardware for an operating system based on Android.
- **Task T7 (handheld test build):** new with this proposal, to build one on the bench before anything is decided.

## Parts

### Main board

- **Raspberry Pi 5,** or the **Compute Module 5 (CM5)** on a carrier board of the project's own.
  [BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5) compares them with the other boards.
- The CM5 is sold with or without wireless, so a CM5 without wireless leaves the USB adapter as the device's only Wi-Fi.
  It comes with 2–16 GB of memory and 0–64 GB of built-in storage (eMMC), from $67.50, and stays in production until at least January 2036.
- On a Pi 5, the built-in Wi-Fi would have to be switched off in software, which a hardware switch can't guarantee (unsourced).
- Secure boot is documented publicly, and Raspberry Pi's own open tool sets it up ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
- ⚠ The Pi 5 needs a 5 V supply that can deliver a lot of current, and with a weaker one it limits what its USB ports may draw; the exact figures need checking against Raspberry Pi's documentation (check C13).

Sources: [Compute Module 5][rpi-cm5], [Raspberry Pi hardware documentation][rpi-hw].

### LoRa radio

- **Choose the SX1262 over the RFM95W.**
  Meshtastic recommends the SX1262, used in most current Meshtastic hardware, over the older SX127x chips.
  The RFM95W is built on an SX127x chip (unsourced).
- **Straight to the Pi, over SPI:** Meshtastic's Linux program, `meshtasticd`, drives a LoRa radio on the Pi's SPI pins.
  Meshtastic lists radio boards it has tested on a Pi, and some it advises against for real use.
  Radios connected over UART aren't supported; a radio on a USB adapter is.
- **This differs from the plan's proposed design,** a small separate processor with its own LoRa chip ([LORA.md](LORA.md#integrating-the-radio)).
  The plan turned down a LoRa chip run by the main processor because Android stops it whenever the phone sleeps.
  A Pi running Linux usually stays awake, so the mesh keeps running, but the whole Pi stays powered for it, which costs battery (unsourced).
  For bench work the SPI design is the quickest; for a device carried every day, the separate processor still saves battery.
- **Antenna:** an SMA connector on top of the case, with an antenna tuned for 868 MHz, the band used in Greece and the rest of Europe ([LORA.md](LORA.md#certification-and-band-rules)).
  Never transmit without the antenna connected, which can damage the radio (unsourced).
- **Band rules:** in Europe the software must keep to each sub-band's limit on transmitting time ([LORA.md](LORA.md#certification-and-band-rules)).

Sources: [Meshtastic Linux hardware][mt-linux].

### Wi-Fi adapter

- A USB adapter that can be pulled out, or cut off by a hardware switch, takes the device off the internet for certain.
- Linux supports some adapters' chips better than others, so the adapter should be chosen for an open driver in the mainline kernel (unsourced).
- A new, random hardware address (MAC address) for every connection is a setting of the operating system, not of the hardware ([Operating system](#operating-system)).

### Position

- A GNSS receiver (for GPS and similar satellite systems) lets the device share its position over the mesh.
- Meshtastic shares a node's position from the node's own GPS, or from a paired phone, and lets an external GPS module connect to a node's pins.
- ⚠ Whether `meshtasticd` on Linux can use a GPS receiver isn't stated in Meshtastic's documentation (check C14).

Sources: [Meshtastic position settings][mt-position].

### Hardware switches

Switches on the edge of the case cut the power to the USB Wi-Fi adapter, the LoRa radio, the GNSS receiver and the microphone.

- Phones on sale already do this: the FuriLabs FLX1s cuts the microphone, the cameras and the modem ([FEASIBILITY.md](FEASIBILITY.md#furilabs-flx1s)), and the SHIFTphone 8 has a switch for the camera and microphone ([FEASIBILITY.md](FEASIBILITY.md#partnership-with-a-phone-maker)).
- **Cut the data lines too, or isolate them.**
  A part whose power is cut can still be powered, partly, through the wires that carry its data, so cutting only the 3.3 V or 5 V line may not switch it off fully (unsourced; check C14).
- **Let the operating system see each switch,** so software doesn't keep using a part that is switched off (unsourced).
- **Never cut the LoRa radio's antenna instead of its power,** which can damage the radio (unsourced).
- Task T1 lists the switches as a requirement; the handheld adds Wi-Fi and GNSS to that list.

### Battery

- **A battery the user swaps by hand:** a protected 18650 lithium-ion cell in a spring-loaded bay at the back, or a camera battery such as Canon's LP-E6.
  Choose one: the LP-E6 is a two-cell pack at about twice an 18650's voltage, so each needs a different power design (unsourced).
- **Swapping while it runs:** a small built-in backup cell keeps the device on during a swap, joined to the main battery by an "ideal diode" power-path controller that takes power from whichever source is available (unsourced).
  The backup cell needs its own charging and protection (unsourced).
- **Power budget:** the Pi 5 can draw a lot of current, so the converter from the battery's voltage to 5 V, and the battery's life, are the main design work (check C13).
- **EU rules:** from 2027-02-18, batteries in portable products must be removable and replaceable by the user, which this design meets ([FEASIBILITY.md](FEASIBILITY.md#eu-battery-rules)).

## Operating system

The proposal runs a small Linux system built for privacy, not Android.
Which one the first prototype runs is decision [D6](ROADMAP.md#d6-operating-system-of-the-first-prototype).

- **The project was set up to build hardware for an operating system based on Android,** and doesn't plan operating-system work of its own ([ROADMAP.md](ROADMAP.md#not-planned)).
  A Linux system for the handheld would be the project's own software to keep updated.
- **Android on a Pi 5:** a community build of Android 17 exists, but its security rules (SELinux) are off, it doesn't support encrypting user data, and it may not be used commercially ([BOARDS.md](BOARDS.md#raspberry-pi-5-and-compute-module-5)).
  So it can't give the proposal's encrypted storage yet.
- **Alpine Linux** calls itself a security-oriented, lightweight distribution, and publishes images for the Pi 3 to the Pi 5.
- **Buildroot** builds a small embedded Linux system from source, including the kernel and the bootloader.
- FoxieOS can't use a Linux handheld; whether it supports a device from this project is its own decision D9 ([DESIGN.md](DESIGN.md#related-repositories)).

Sources: [Alpine Linux][alpine-about], [Alpine downloads][alpine-downloads], [Buildroot][buildroot].

### The proposed software

Each item is work for whoever builds the operating system; the hardware only has to allow it.

- **Encrypted storage:** on Linux, LUKS through the `cryptsetup` tool encrypts the whole storage, and asks for a passphrase at every start.
  Android encrypts each user's files instead (file-based encryption) since Android 7, and doesn't allow whole-disk encryption on new devices since Android 10.
- **A random MAC address:** Android uses a random address for each Wi-Fi network by default since Android 10, and from Android 12 changes it again in some cases.
  On Linux this is a setting of the program that manages the network (unsourced).
- **Messaging over the internet:**
  - **Briar** sends messages directly between devices, over Tor, Wi-Fi or Bluetooth on Android.
    Its Linux app is a beta, and lacks Bluetooth and adding contacts nearby.
  - **Session** sends messages over onion-routed paths, needs no phone number, and has a Linux app.
  - PGP and XMPP programs that run in a terminal are an option too (unsourced).
- **Messaging over LoRa:** Meshtastic already encrypts messages.
  - Channels use AES with a shared key of 128 or 256 bits; the default channel's key is public, so a private channel needs its own key.
  - Direct messages use a key pair for each device and AES-256.
  - Meshtastic states its limits: message headers aren't encrypted, and there is no forward secrecy.
  - **A home-made AES-256 script isn't recommended:** encryption written from scratch is easy to get wrong, and it wouldn't talk to other Meshtastic devices (unsourced).

Sources: [cryptsetup][cryptsetup], [Android encryption][aosp-encryption], [Android MAC randomization][aosp-mac], [Briar Desktop][briar-desktop], [Session][session], [Meshtastic encryption][mt-encryption].

## What it costs the user

- **Size and weight:** with a removable 18650 battery, an external antenna, a USB Wi-Fi adapter and a screw-together case, the device is closer to a thick handheld radio than a slim phone.
- **No mainstream apps:** banking apps, WhatsApp, Instagram and Google's services won't run on it.
  Even on an Android-based system, apps that rely on Google's checks may not work ([FEASIBILITY.md](FEASIBILITY.md#apps-and-google-services)).
- **Careful use:** no hardware protects a user who signs in to accounts in their own name, uses their home Wi-Fi, or carries the device switched on everywhere (unsourced).
  That belongs in a user guide, not in the hardware.

## Open questions

- Which operating system the first prototype runs (decision D6).
- Whether the Pi 5 or a CM5 on the project's own carrier board, and how long the battery lasts (check C13).
- Whether cutting power alone switches a part off fully, and whether `meshtasticd` can use a GPS receiver (check C14).
- Whether handing a handheld to someone outside the maintainers makes the project a manufacturer (check C12).

## Sources

All checked on 2026-11-23.

### Hardware

- [Compute Module 5][rpi-cm5]: variants with and without wireless, memory, storage, price and production until 2036.
- [Raspberry Pi hardware documentation][rpi-hw]: the Pi 5's 5 V supply, power button and USB current limit on a 3 A supply; ⚠ the exact power figures weren't read from the page (check C13).
- [Meshtastic Linux hardware][mt-linux]: `meshtasticd` over SPI and USB, the SX1262 recommendation, tested and unsupported radio boards.
- [Meshtastic position settings][mt-position]: sharing positions, and GPS modules on a node's pins.

### Software

- [Meshtastic encryption][mt-encryption]: channel and direct-message encryption, and their limits.
- [Alpine Linux][alpine-about] and [Alpine downloads][alpine-downloads]: how Alpine describes itself, and its Raspberry Pi images.
- [Buildroot][buildroot]: what Buildroot builds.
- [cryptsetup][cryptsetup]: the LUKS disk-encryption tool.
- [Android encryption][aosp-encryption]: file-based encryption, and whole-disk encryption not allowed on new devices.
- [Android MAC randomization][aosp-mac]: random MAC addresses by Android version.
- [Briar Desktop][briar-desktop]: the Linux beta and what it lacks next to Android.
- [Session][session]: onion routing, no phone number, and its desktop apps.

[rpi-cm5]: https://www.raspberrypi.com/products/compute-module-5/
[rpi-hw]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html
[mt-linux]: https://meshtastic.org/docs/software/linux/hardware/
[mt-position]: https://meshtastic.org/docs/configuration/radio/position/
[mt-encryption]: https://meshtastic.org/docs/overview/encryption/
[alpine-about]: https://www.alpinelinux.org/about/
[alpine-downloads]: https://www.alpinelinux.org/downloads/
[buildroot]: https://buildroot.org/
[cryptsetup]: https://gitlab.com/cryptsetup/cryptsetup
[aosp-encryption]: https://source.android.com/docs/security/features/encryption
[aosp-mac]: https://source.android.com/docs/core/connect/wifi-mac-randomization-behavior
[briar-desktop]: https://briarproject.org/download-briar-desktop/
[session]: https://getsession.org/
