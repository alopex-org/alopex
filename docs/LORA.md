# LoRa mesh radio

**Status: research.**
A LoRa radio is planned as a core part of the device: it lets people send messages with no cellular network, Wi-Fi or carrier, over a mesh network such as Meshtastic or MeshCore.
This document covers the mesh networks, how a LoRa radio could be built into the device, and what it adds to certification.
The choice of network is roadmap decision [D4](ROADMAP.md#d4-lora-mesh-network), and the radio is a requirement in task [T1](ROADMAP.md#t1-hardware-requirements).

Sources were checked on 2026-11-21.
Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
⚠ marks a claim that is unconfirmed or disputed; check it before relying on it.
"(unsourced)" marks a statement from general knowledge that was not checked against a source.

## Summary

- **LoRa is a long-range, low-power radio in licence-free bands,** 868 MHz in Europe and 915 MHz in North America.
  It carries short messages over kilometres, at a few hundred bits to a few kilobits per second (unsourced).
- **Three mesh networks run on the same LoRa chips:** Meshtastic, MeshCore and Reticulum.
  They can't talk to each other, so the device either picks one or can switch between them.
- **No phone was found with a LoRa radio built into its board.**
  The phones and handhelds sold with LoRa so far attach a separate node that talks to the phone over Bluetooth.
  A device with the radio on its own board would be new, and a reason to choose it.
- **The proposed design is a small microcontroller with its own LoRa chip,** connected to the phone's processor over UART or USB.
  It runs the mesh firmware itself, keeps the mesh working while the phone sleeps, and can run Meshtastic or MeshCore firmware ([Integration](#integrating-the-radio)).
- **The LoRa radio adds a short-range-device certification,** ETSI EN 300 220 under the Radio Equipment Directive in Europe and FCC Part 15 in the United States, and a duty-cycle limit in Europe ([Certification](#certification-and-band-rules)).
- **It costs little on its own,** and doesn't depend on decision D2: a Wi-Fi-only device with LoRa can still message off-grid.

## Terms

| Term | Meaning |
|---|---|
| LoRa | Semtech's long-range, low-power radio modulation for licence-free sub-GHz bands |
| LoRaWAN | A network protocol for sensors that report to gateways; not a mesh, and not what this document is about |
| Mesh network | A network in which each node relays messages for the others, with no central infrastructure |
| Companion device | A LoRa node that a phone app controls over Bluetooth, USB or serial |
| SX1262 | A common Semtech LoRa transceiver chip, supported by all three networks (unsourced) |
| Duty cycle | The share of time a device may transmit on a band, set by band rules |
| SRD | Short-range device: the EU category for licence-free low-power radios such as LoRa |

## The mesh networks

| | Meshtastic | MeshCore | Reticulum |
|---|---|---|---|
| Routing | Managed flooding; route-aware direct messages being added | Source routing through repeaters | Its own transport-agnostic routing (unsourced) |
| Hop limit | 3 by default, at most 7 | ⚠ up to 64 | — |
| Firmware licence | GPL-3.0 | MIT, with ⚠ closed binaries for paid features | Custom "Reticulum License", ⚠ not open source by the OSI definition |
| Android app | Open source, with an AIDL service other apps can bind to (⚠ secondary source) | Companion apps (⚠ check their licences, C11) | Sideband and others (unsourced) |
| Runs on a Linux host | Yes: `meshtasticd` drives a radio over SPI or a USB adapter | ⚠ not found | Yes, it is a Python program (unsourced) |

- **Meshtastic** is the largest and best known, and its floods work with no planning, which suits ad-hoc groups.
  Floods use more airtime as the network grows, which matters under Europe's duty-cycle limits.
- **MeshCore** routes through fixed repeaters, which scales better in a city with planned infrastructure, but needs those repeaters to be there.
- **Reticulum** is the most general, carrying any traffic over any link, but its licence change keeps it out of Debian and F-Droid, by a FOSDEM 2026 talk, and would need a legal check before shipping it.

Sources: [Seeed Studio][seeed-compare], [Xebia][xebia-mc], [simeononsecurity][sos-compare], [CNX Software on MeshCore][cnx-meshcore], [MeshCore site][meshcore-site], [Meshtastic firmware][mt-firmware], [Meshtastic Android API][mt-android-api], [Meshtastic Linux hardware][mt-linux], [FOSDEM 2026 Reticulum talk][fosdem-rns], [Reticulum licence][rns-license].

## Devices that already combine a phone and LoRa

- **SpecFive Spectre Pro** (late 2025): an Android 12 phone with a LoRa mesh node attached to its back, talking to the phone over Bluetooth, for about $200–$270.
- **Magtastic** and similar projects: a Meshtastic node clipped to a phone's back.
- **Standalone handhelds,** such as a MeshCore device on a LILYGO board and the Tanmatsu's LoRa add-on, are separate devices, not phones.
- **Fairphone** users have asked for LoRa in the Fairphone forum; ⚠ no plan was found.

None has the radio on the phone's own board, sharing its battery, antenna design and operating system.

Sources: [Hackster on the Spectre Pro][hackster-spectre], [CNX Software on the Spectre Pro][cnx-spectre], [Hackster on Magtastic][hackster-magtastic], [Hackster on a MeshCore handheld][hackster-mc-phone], [Fairphone forum][fp-forum].

## Integrating the radio

Two designs were considered.

### A microcontroller with its own LoRa chip (proposed)

A small microcontroller, such as an nRF52840 or ESP32-S3, with an SX1262, on the device's board and connected to the main processor over UART or USB (unsourced).

- **The mesh keeps working while the phone sleeps,** relaying and receiving messages at a few milliamps, and wakes the phone only for its user (unsourced).
- **It runs the networks' own firmware unchanged.**
  Both Meshtastic and MeshCore support nRF52840 and ESP32 boards with an SX1262, so the device could ship one and let users flash the other (unsourced; check C10).
- **Android sees it as a companion device** on a serial port, which the existing Meshtastic and MeshCore apps already speak to over USB serial ⚠ (C11).
- **It isolates the radio's firmware** from the main processor: a fault in the mesh firmware can't reach Android, and the microcontroller can be updated on its own.
- **Cost:** a second processor and its firmware to maintain and update; the manufacturer would answer for those updates under the EU rules too.

### The LoRa chip on the main processor's SPI bus

The SX1262 connects straight to the main processor, and a Linux daemon such as `meshtasticd` drives it.

- Simpler hardware, with one processor fewer.
- The mesh stops whenever Android suspends the processor, unless it is kept awake, which costs battery (unsourced).
- `meshtasticd` is built for Linux, not Android, so it would need porting; no MeshCore equivalent was found.

### What both need

- A sub-GHz antenna and its own RF design, separate from the cellular antennas, for each band the device is sold in: 868 MHz and 915 MHz need different tuning (unsourced).
- A hardware switch or software control that turns the LoRa transmitter off, in line with the privacy switches in task T1.
- An Android app and permissions for the radio; for FoxieOS this would fall under its decision D9.

Sources: [Meshtastic Linux hardware][mt-linux], [Meshtastic Android API][mt-android-api], [lupyuen's Linux SX1262 driver][lupyuen-sx1262].

## Certification and band rules

- **Europe:** LoRa at 868 MHz falls under the SRD rules: ETSI EN 300 220, a harmonised standard under the Radio Equipment Directive.
  Each sub-band limits power and duty cycle: 1% on 868.0–868.6 MHz, 0.1% on 868.7–869.2 MHz, and 10% at up to 500 mW on 869.4–869.65 MHz.
  ⚠ The sources differ on some band edges and power limits; check the current standard (C10).
- **United States:** 902–928 MHz under FCC Part 15, with no duty-cycle limit but frequency-hopping or digital-modulation rules (unsourced).
- **A certified LoRa module** can reduce the testing, as for cellular modules ([FEASIBILITY.md](FEASIBILITY.md#radio-and-network-certification)), but the finished device is still tested with all its radios together (unsourced).
- **Duty cycle and the mesh:** firmware that relays others' messages uses the device's own airtime, so the firmware must stay within the limits for the region the user picks.
  The manufacturer answers for this, so the shipped firmware must enforce the region's limits (unsourced).

Sources: [TTN EU868 parameters][ttn-eu868], [TTN duty cycle][ttn-duty], [CEPT ERC/REC 70-03 annex 1][cept-srd].

## Open questions

- Which network to ship by default, or whether to ship both (decision D4).
- Whether the companion apps work over a wired serial link as well as Bluetooth (C11).
- Which certified LoRa modules fit a phone's board and battery (C10).

## Sources

All checked on 2026-11-21.

### Mesh networks

- [Seeed Studio, March 2026][seeed-compare]: routing of Meshtastic and MeshCore.
- [Xebia][xebia-mc]: hop limits, from a team that switched in January 2026.
- [simeononsecurity][sos-compare]: comparison of the three networks.
- [CNX Software on MeshCore][cnx-meshcore]: MeshCore's design, and ⚠ a reader's claim of closed parts.
- [MeshCore site][meshcore-site]: MIT licence.
- [Meshtastic firmware][mt-firmware]: GPL-3.0 licence.
- [Meshtastic Android API][mt-android-api]: the app's bound service, ⚠ via a secondary source.
- [Meshtastic Linux hardware][mt-linux]: `meshtasticd`, SPI and USB radios.
- [FOSDEM 2026 Reticulum talk][fosdem-rns] and [Reticulum licence][rns-license]: the licence change.

### Devices

- [Hackster on the Spectre Pro][hackster-spectre] and [CNX Software on the Spectre Pro][cnx-spectre]: design and price.
- [Hackster on Magtastic][hackster-magtastic], [Hackster on a MeshCore handheld][hackster-mc-phone], [Fairphone forum][fp-forum].
- [lupyuen's Linux SX1262 driver][lupyuen-sx1262]: an SX1262 driven from Linux, and its limits.

### Band rules

- [TTN EU868 parameters][ttn-eu868] and [TTN duty cycle][ttn-duty]: EU sub-bands and limits.
- [CEPT ERC/REC 70-03 annex 1][cept-srd]: the SRD band table.

[seeed-compare]: https://www.seeedstudio.com/blog/2026/03/23/meshcore-vs-meshtastic/
[xebia-mc]: https://xebia.com/blog/meshtastic-to-meshcore/
[sos-compare]: https://simeononsecurity.com/articles/meshtastic-vs-meshcore-vs-reticulum-comparison-guide/
[cnx-meshcore]: https://www.cnx-software.com/2025/07/19/meshcore-lightweight-alternative-to-meshtastic-for-lora-based-off-grid-messaging/
[meshcore-site]: https://meshcore.io
[mt-firmware]: https://github.com/meshtastic/firmware
[mt-android-api]: https://meshtastic.github.io/Meshtastic-Android/core/service/org.meshtastic.core.service/index.html
[mt-linux]: https://meshtastic.org/docs/software/linux/hardware/
[fosdem-rns]: https://fosdem.org/2026/events/attachments/9NCWUR-reticulum_community_meetup_implementations_migration_and_future/slides/262533/reticulum_dimz1j8.pdf
[rns-license]: https://git.hackliberty.org/Git-Mirrors/Reticulum/src/branch/master/docs/source/license.rst
[hackster-spectre]: https://www.hackster.io/news/spec5-s-spectre-pro-is-an-android-smartphone-with-off-grid-lora-mesh-connectivity-baf7d9a3bb23
[cnx-spectre]: https://www.cnx-software.com/2025/11/04/200-specfive-spectre-pro-android-12-smartphone-integrates-lora-mesh-connectivity/
[hackster-magtastic]: https://www.hackster.io/news/joseph-digiovanni-s-magtastic-literally-sticks-a-meshtastic-node-on-the-back-of-your-phone-c8a2e6b34ead
[hackster-mc-phone]: https://www.hackster.io/news/you-can-now-buy-a-meshcore-smartphone-d50105def46b
[fp-forum]: https://forum.fairphone.com/t/lora-and-meshtastic/132463
[lupyuen-sx1262]: https://www.github.com/lupyuen/lora-sx1262
[ttn-eu868]: https://thethingsnetwork.org/docs/lorawan/regional-parameters/eu868
[ttn-duty]: https://www.thethingsnetwork.org/docs/lorawan/duty-cycle/index.html
[cept-srd]: https://efis.cept.org/adhoc_grabber.jsp?annex=10
