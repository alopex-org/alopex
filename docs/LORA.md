# LoRa mesh radio

**Status: research.**
A LoRa radio is a core part of the device, decided on 2026-11-21 and kept for the cyber-deck.
Some of this research was done for a phone, and applies to the cyber-deck where the two are alike.
It lets people send short messages with no mobile network or Wi-Fi: each device passes messages on to the next, forming a mesh network such as Meshtastic or MeshCore.
This page covers the mesh networks, how a LoRa radio could be built into the device, and what it adds to certification.
Which network to use is roadmap decision [D4](ROADMAP.md#d4-lora-mesh-network), and the radio is a requirement in task [T1](ROADMAP.md#t1-hardware-requirements).
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-21.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it.
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.

## Summary

- **LoRa is a long-range, low-power radio in bands that need no licence,** 868 MHz in Europe and 915 MHz in North America.
  It carries short messages over kilometres, slowly: a few hundred bits to a few kilobits per second (unsourced).
- **Three mesh networks run on the same LoRa chips:** Meshtastic, MeshCore and Reticulum.
  They can't talk to each other, so the device either picks one or lets the user switch.
- **No phone was found with a LoRa radio built into its own circuit board.**
  The phones and handhelds sold with LoRa so far attach a separate radio that talks to the phone over Bluetooth.
  A device with the radio built in would be new, and a reason to choose it.
- **The proposed design is a small separate processor (a microcontroller) with its own LoRa chip,** connected to the device's main processor by UART or USB.
  It runs the mesh network's software itself, keeps the mesh working while the main processor sleeps, and can run Meshtastic's or MeshCore's software ([Integrating the radio](#integrating-the-radio)).
- **The LoRa radio needs its own certification for short-range devices:** ETSI EN 300 220 under the Radio Equipment Directive in Europe, and FCC Part 15 in the United States.
  In Europe it may also transmit only for a limited share of the time, the duty cycle ([Certification](#certification-and-band-rules)).
- **It costs little on its own,** and doesn't depend on decision D2 (mobile phone or Wi-Fi only): a Wi-Fi-only device with LoRa can still send messages without a network.

## Terms

The technical terms used here (LoRa, LoRaWAN, mesh network, companion device, SX1262, duty cycle, SRD and more) are explained in the [glossary](GLOSSARY.md).

## The mesh networks

How the three networks compare.
"Routing" is how a message finds its way; a "hop" is one step from one device to the next.

| | Meshtastic | MeshCore | Reticulum |
|---|---|---|---|
| Routing | Managed flooding; route-aware direct messages being added | Source routing through repeaters | Its own transport-agnostic routing (unsourced) |
| Hop limit | 3 by default, at most 7 | ⚠ up to 64 | — |
| Firmware licence | GPL-3.0 | MIT, with ⚠ closed binaries for paid features | Custom "Reticulum License", ⚠ not open source by the OSI definition |
| Android app | Open source, with an AIDL service other apps can bind to (⚠ secondary source) | Companion apps (⚠ check their licences, C11) | Sideband and others (unsourced) |
| Runs on a Linux host | Yes: `meshtasticd` drives a radio over SPI or a USB adapter | ⚠ not found | Yes, it is a Python program (unsourced) |

- **Meshtastic** is the largest and best known.
  Each message is passed to every neighbour ("flooding"), which needs no planning and suits groups that form on the spot.
  But flooding uses more airtime as the network grows, which matters under Europe's limits on how long a device may transmit.
- **MeshCore** sends messages along routes through fixed repeaters.
  That works better in a city with repeaters set up in advance, but needs those repeaters to be there.
- **Reticulum** is the most general, carrying any kind of traffic over any kind of link.
  But according to a FOSDEM 2026 talk, its change of licence keeps it out of Debian and F-Droid, and it would need a legal check before the device could include it.

Sources: [Seeed Studio][seeed-compare], [Xebia][xebia-mc], [simeononsecurity][sos-compare], [CNX Software on MeshCore][cnx-meshcore], [MeshCore site][meshcore-site], [Meshtastic firmware][mt-firmware], [Meshtastic Android API][mt-android-api], [Meshtastic Linux hardware][mt-linux], [FOSDEM 2026 Reticulum talk][fosdem-rns], [Reticulum licence][rns-license].

## Devices that already combine a phone and LoRa

What already exists, and why a built-in radio would still be new.

- **SpecFive Spectre Pro** (late 2025): an Android 12 phone with a LoRa mesh node attached to its back, talking to the phone over Bluetooth, for about $200–$270.
- **Magtastic** and similar projects: a Meshtastic node clipped to a phone's back.
- **Standalone handhelds,** such as a MeshCore device on a LILYGO board and the Tanmatsu's LoRa add-on, are separate devices, not phones.
- **Fairphone** users have asked for LoRa in the Fairphone forum; ⚠ no plan was found.

None has the radio on the phone's own board, sharing its battery, antenna design and operating system.

Sources: [Hackster on the Spectre Pro][hackster-spectre], [CNX Software on the Spectre Pro][cnx-spectre], [Hackster on Magtastic][hackster-magtastic], [Hackster on a MeshCore handheld][hackster-mc-phone], [Fairphone forum][fp-forum].

## Integrating the radio

How the LoRa radio could be connected inside the device.
Two designs were considered.

### A microcontroller with its own LoRa chip (proposed)

A small, low-power processor (a microcontroller such as an nRF52840 or ESP32-S3) with an SX1262 LoRa chip, on the device's board and connected to the main processor by UART or USB (unsourced).

- **The mesh keeps working while the main processor sleeps.**
  The small processor passes messages on and receives them using a few milliamps, and wakes the main processor only for messages meant for its user (unsourced).
- **It runs the networks' own software unchanged.**
  Both Meshtastic and MeshCore support nRF52840 and ESP32 boards with an SX1262, so the device could come with one and let users install the other (unsourced; check C10).
- **On Android, it shows up as a companion device** on a serial port, which the existing Meshtastic and MeshCore apps already talk to over a USB cable ⚠ (check C11).
- **It keeps the radio's software apart** from the main processor: a fault in the mesh software can't reach the main operating system, and the small processor can be updated on its own.
- **Cost:** a second processor and its software, which the project would also have to keep updated.

### The LoRa chip on the main processor's SPI bus

The SX1262 connects straight to the main processor, and a background program such as `meshtasticd` runs it.

- Simpler hardware, with one processor fewer.
- The mesh stops whenever the operating system puts the main processor to sleep, unless it is kept awake, which costs battery (unsourced).
- `meshtasticd` is made for Linux, so it suits a Linux main board; on Android it would need adapting, and nothing similar was found for MeshCore.

### What both need

- Its own antenna for the LoRa band, separate from the mobile-network antennas, tuned for each band the device is used in: 868 MHz and 915 MHz need different tuning (unsourced).
- A hardware switch or a software setting that turns the LoRa transmitter off, like the privacy switches in task T1.
- Software and permissions for the radio on the main operating system; for FoxieOS this would fall under its decision D9.

Sources: [Meshtastic Linux hardware][mt-linux], [Meshtastic Android API][mt-android-api], [lupyuen's Linux SX1262 driver][lupyuen-sx1262].

## Certification and band rules

The rules a LoRa radio has to follow before a device with it can be sold, and while it is in use.

- **Europe:** LoRa at 868 MHz falls under the rules for short-range devices (SRD): ETSI EN 300 220, a standard under the Radio Equipment Directive.
  Each slice of the band (sub-band) limits the power and the share of time a device may transmit: 1% on 868.0–868.6 MHz, 0.1% on 868.7–869.2 MHz, and 10% at up to 500 mW on 869.4–869.65 MHz.
  ⚠ The sources differ on some band edges and power limits; check the current standard (C10).
- **United States:** 902–928 MHz under FCC Part 15, with no limit on transmitting time but rules on how the signal is sent (frequency hopping or digital modulation) (unsourced).
- **A certified LoRa module** can reduce the testing, as for cellular modules ([FEASIBILITY.md](FEASIBILITY.md#radio-and-network-certification)), but the finished device is still tested with all its radios together (unsourced).
- **Time limits and the mesh:** passing on other people's messages uses the device's own transmitting time, so the software must stay within the limits for the region the user picks.
  Whoever uses the transmitter answers for this, so the prototype's software must enforce the region's limits (unsourced).

Sources: [TTN EU868 parameters][ttn-eu868], [TTN duty cycle][ttn-duty], [CEPT ERC/REC 70-03 annex 1][cept-srd].

## Open questions

- Which network to ship by default, or whether to ship both (decision D4).
- Whether the companion apps work over a cable as well as Bluetooth (check C11).
- Which certified LoRa modules fit the device's main board and battery (check C10).

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
