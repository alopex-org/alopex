# Glossary: hardware, radios and rules

Plain explanations of the technical words in this project's docs.
Look a word up when you meet it; you don't need to read this page from top to bottom.

Words about GitHub and how the project works (branch, pull request, sign-off, roadmap codes such as D5 or T1) are in the [organization's glossary](https://github.com/alopex-org/.github/blob/main/GLOSSARY.md).
Words about Linux and the cyber-deck's software (kernel, base system, A/B updates, secure boot) are explained in [FoxieOS's glossary](https://github.com/alopex-org/foxieos/blob/main/docs/GLOSSARY.md).

## Making a device

- **Prototype:** a device built in small numbers to try out a design, not sold.
- **Product:** a device sold to the public, which brings legal duties.
  Whether this project aims at a product is roadmap decision D5.
- **Manufacturer:** in EU law, whoever puts a device on the market under their own name.
  They certify it, pay patent licences and supply updates and spare parts for years.
- **Placing on the market:** making a product available for others to use, whether sold or given away.
  Whether handing out prototypes counts is roadmap check C12.
- **ODM (original design manufacturer):** a company that designs and builds devices that other companies sell under their own brand.
- **White-label phone:** an existing ODM phone sold under someone else's name with few changes.
- **Minimum order:** the smallest number of devices a factory will make for one customer.
- **NRE (non-recurring engineering):** the one-off cost of adapting a design, paid once rather than per device.
- **Contract manufacturer:** a factory that builds devices to a customer's design.
- **Partnership:** an existing phone maker sells a phone with the project's operating system, or builds one to its requirements.
- **Main board:** the device's central circuit board, which holds the processor and connects everything else.
- **Bring-up:** getting an operating system to start and work on new hardware for the first time.
- **Bench work:** trying things out on boards and kits on a workbench, before building a device.
- **Cyber-deck:** a custom-built, portable computer, often made for one purpose, with a keyboard, a screen and a rugged or "cyberpunk" look; usually thicker than a phone.
  The word comes from William Gibson's 1984 novel *Neuromancer*.
  This project's device is a hand-held cyber-deck ([CYBERDECK.md](CYBERDECK.md)).
- **Concept render:** a computer-drawn picture of how a device should look, before it is engineered.
- **Mock-up:** a model of a device's shape, without working electronics, for trying how it feels and fits.
- **Carrier board:** the board a compute module plugs into, which connects it to everything else in the device.
- **Compute Module 5 (CM5):** a Raspberry Pi 5 on a small module, made to plug into a carrier board.
- **Slide-out keyboard:** a keyboard hidden under the screen until the screen slides aside; the cyber-deck's screen slides sideways.
- **Rotary encoder:** a knob that turns without end, in clicks, and tells the computer which way and how far.
- **Moving-coil meter:** a gauge with a real needle, moved by a small coil and magnet.
- **18650:** a common size of rechargeable lithium-ion cell, 18 mm across and 65 mm long.
- **Hot swap:** replacing a battery or part while the device keeps running.
- **Power path ("ideal diode"):** the circuit that takes power from whichever battery is present, so one can be pulled without the device switching off.

## Chips and boards

- **Chip vendor:** the company that makes the main chip, such as Qualcomm, MediaTek, NXP or Rockchip.
- **SoC (system on a chip):** the main chip of a phone or board, with the processor, graphics and more in one part.
- **Arm and RISC-V:** two families of processor designs.
  Almost all phones use Arm, whose designs chip makers license from the company Arm; **RISC-V** is an open design that any chip maker may use.
- **RVA23:** the set of RISC-V features that Android expects.
- **Development board:** a small computer board sold for developers to try a chip on, such as a Raspberry Pi.
  None of the boards in this research has a mobile-network modem.
- **Evaluation kit:** a board that a chip or module maker sells for trying its product before designing a device around it.
- **Cellular module (smart module):** a small ready-made board with a processor, memory, storage and a mobile-network modem, sold to be built into other devices.
- **Modem:** the part that talks to the mobile network.
- **TEE (trusted execution environment):** a protected part of the chip that holds keys and secrets.
- **GPU:** the graphics processor.
- **Mesa:** free graphics drivers that can replace a chip vendor's closed ones.
- **Single source:** a part that only one company makes, so a shortage there stops production.
- **eMMC and DRAM:** the storage and the working memory chips in a device.
- **Compute Module:** a Raspberry Pi made as a small plug-in board, for a carrier board designed by someone else.
- **GNSS (global navigation satellite system):** satellite positioning, such as GPS and Galileo; a GNSS receiver tells the device where it is.
- **Wi-Fi adapter (USB):** a small plug-in Wi-Fi radio that can be removed from the device.
- **SMA connector:** a screw-on connector for an external antenna.
- **Hardware switch (kill switch):** a physical switch that cuts the power to a part, such as a radio or the microphone, so software can't turn it back on.
- **18650 cell:** a common cylindrical lithium-ion battery cell, 18 mm wide and 65 mm long; a *protected* cell has a small circuit against over-charging and short circuits.
- **Power path, ideal diode:** the circuit that chooses which battery or charger powers the device; an ideal-diode controller lets power flow from whichever source is available, so a battery can be swapped without a restart.

## Software for hardware

- **BSP (board support package):** a chip vendor's kernel, drivers and firmware for its chip.
  The device's software can only be as up to date as its BSP.
- **Firmware:** the software inside a device's chips, such as the modem.
  Closed firmware gets security fixes only while its maker ships them.
- **Kernel:** the core of the operating system, which talks to the hardware.
  The **mainline kernel** is Linux as its own developers release it, without a vendor's changes.
- **GKI (Generic Kernel Image):** Google's shared Android kernel, with each vendor's drivers loaded as add-ons.
  Each GKI version gets updates until a fixed end date.
- **Device tree:** the files that teach Android how to run on one particular device.
- **Forward port:** moving a device's software onto a newer Android version.
- **Distribution:** a ready-to-install version of an operating system, such as LineageOS or FoxieOS.
- **AOSP:** the free, public part of Android that Google publishes.
- **Developer release:** an early version for developers, not ready for everyday use.
- **Alpine Linux, Buildroot:** a small Linux distribution built for security, and a tool that builds a small Linux system from source for one device.

## Security and keys

- **Secure boot:** the chip starts only firmware signed with a particular key.
  The key's fingerprint (hash) is burned into the chip.
- **Fuses (one-time-programmable fuses, QFPROM):** tiny switches inside a chip that can be set once and never undone.
  Setting them ("blowing" or "fusing" them) turns on secure boot for good.
- **Root of trust:** the first key the chip trusts, from which every later check follows.
- **AVB (Android Verified Boot):** the check at every start-up that the operating system hasn't been changed, against a key.
- **`avb_custom_key`:** the place on a phone where its owner can store their own verified-boot key, so a different operating system can run with the bootloader locked.
- **Bootloader:** the small program that starts the device and checks what it may start.
  **Unlocking** lets it start unsigned software; **relocking** turns the checks back on.
- **Brick:** to make a device unusable, for example by a wrong fusing or relocking step.
- **Dev key:** a key for practice and testing only, never for anything published.
- **Signing tools:** a chip vendor's programs for signing firmware; Qualcomm's are called SecTools.
- **Play Integrity:** Google's check that apps such as banking apps use to decide whether they trust a device.
- **Google Mobile Services (GMS):** Google's own apps and services, which need a licence from Google.
- **Disk encryption, LUKS:** scrambling the stored data so it can't be read without a passphrase; LUKS is the standard way to do it on Linux.
  Android encrypts each user's files instead (file-based encryption).
- **MAC address:** the hardware address a Wi-Fi radio shows to networks; a random one for each network makes the device harder to track.
- **Tor, onion routing:** sending traffic through several relays so that no single one knows both who sends it and where it goes.
- **Forward secrecy:** a property of encryption under which a stolen key can't unlock messages sent earlier.

## Radios and certification

- **Certification:** official testing that a device meets the rules before it can be sold.
- **FCC:** the US authority for radio equipment.
  **Part 15** is its rule for low-power radios that need no licence.
- **CE marking and RED (Radio Equipment Directive):** the EU's mark and law for radio equipment.
- **PTCRB and GCF:** the North American and European certifications that mobile networks require before they accept a phone.
- **Accredited test lab:** a lab officially allowed to carry out certification tests.
- **SAR (specific absorption rate):** how much radio energy the body absorbs from a device.
- **SEP (standard-essential patent):** a patent that every device using a standard, such as LTE or 5G, has to license.
- **FRAND:** "fair, reasonable and non-discriminatory", the terms SEP owners are expected to offer.
- **Royalty:** a fee paid to a patent owner for each device.
- **Antenna and RF design:** the design of the parts that send and receive radio signals.

## LoRa and mesh networks

- **LoRa:** a long-range, low-power radio from the company Semtech, used in bands that need no licence (868 MHz in Europe, 915 MHz in North America).
  It carries short messages over kilometres, slowly.
- **LoRaWAN:** a network for sensors that report to central gateways; not a mesh, and not what this project uses.
- **Mesh network:** a network in which each device passes messages on for the others, with no central infrastructure.
- **Off-grid:** working without the mobile network, Wi-Fi or the internet.
- **Node:** one device in a mesh network.
- **Companion device:** a LoRa node that a phone app controls over Bluetooth, USB or a serial cable.
- **Repeater:** a fixed node that passes messages on, extending the network's reach.
- **Flooding and routing:** two ways of passing messages on.
  Flooding sends a message to every neighbour, which needs no planning but uses more airtime; routing sends it along a chosen path.
- **Hop:** one step of a message from one node to the next.
- **Airtime and duty cycle:** how long a device transmits.
  The duty cycle is the share of time a device may transmit on a band, set by law in Europe.
- **Sub-band:** a slice of a radio band with its own limits.
- **SRD (short-range device):** the EU's category for low-power radios that need no licence, such as LoRa.
  **ETSI EN 300 220** is the EU standard for them.
- **Meshtastic, MeshCore, Reticulum:** three mesh networks that run on LoRa.
  They can't talk to each other.
- **SX1262:** a common LoRa radio chip made by Semtech.
- **Microcontroller (MCU):** a small, low-power processor, such as an nRF52840 or ESP32-S3, that can run the mesh on its own.
- **UART, USB, SPI:** ways of connecting chips to each other.
- **Daemon:** a program that runs in the background, such as `meshtasticd`.

## EU rules

- **Ecodesign rules (Regulation 2023/1670):** EU rules that make phone and tablet makers supply updates and spare parts for years.
- **Batteries Regulation (2023/1542):** EU rules that, from 2027, make batteries in many products replaceable by the user.
- **Cyber Resilience Act (2024/2847):** EU law with security duties for makers of digital products.
- **ENISA:** the EU's cybersecurity agency, which receives the reports the Cyber Resilience Act requires.
- **Software bill of materials (SBOM):** a list of every software part in a product.
- **Delegated act, derogation:** a rule the European Commission adds under a law; an exception to a rule.
- **Blue Guide:** the European Commission's guide to how EU product rules apply.

## Licences

- **Open source:** software whose code anyone may read, change and share, under a licence.
- **GPL, MIT, Apache:** common open-source licences.
  The GPL requires publishing the source code of what you ship; MIT and Apache allow almost anything.
- **OSI:** the organisation that decides which licences count as open source.
- **Certified open hardware (OSHWA):** hardware whose design files are published under an open licence, checked by the Open Source Hardware Association.
- **Confidentiality agreement (NDA):** a contract not to share what a company tells you.
