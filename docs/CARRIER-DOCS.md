# Documents for designing a carrier board

**Status: reading list.**
A carrier board of the project's own needs the makers' documents for the compute module it carries: how the module is wired, how it is powered, its size, and its certificates.
This page lists those documents for the two modules the research looks at, Raspberry Pi's Compute Module 5 (CM5) and the LattePanda Mu, with links to download them yourself.
It is a list, not a choice: decision [D1](ROADMAP.md#d1-route-to-a-prototype) (route to a prototype) is open, and the research behind both modules is in [CARRIERS.md](CARRIERS.md) and [MU-CARRIERS.md](MU-CARRIERS.md).
Technical words are explained in the [glossary](GLOSSARY.md).

**How to use it:**

- All links were checked on 2026-11-25.
- Download the files to your own computer; don't commit them to this repository ([Licences](#licences)).
  A folder named `reference/` at the top of your clone is ignored by git, so files kept there can't be committed by mistake.
- Makers publish new revisions; the revision is in the file name (`-DS-8-` is revision 8).
  If a direct link stops working, start from the page it came from, listed with each group.
- A few makers' sites refuse downloads that aren't made from a browser; open those links in a browser.

## In short

- **CM5:** the datasheet, Raspberry Pi's IO board as a KiCad design to start from, 3D models of the module, and its certificates.
- **LattePanda Mu:** LattePanda's carrier design guide, the edge-connector pinout, its Lite Carrier as a KiCad design, mechanical drawings and certificates.
- **Connectors:** the drawings for the CM5's two connectors and for the Mu's memory-style socket come from the connector makers, not the module makers.
- **Open designs:** carriers others have published, with their licences, which a design of the project's own could build on within those licences.

## Compute Module 5

Most files come from Raspberry Pi's product information portal; its [CM5 page][pip-cm5] links them all, with the latest revisions.

### Datasheets and guides

- [CM5 datasheet][cm5-ds] (revision 8): pins, power, size, connectors, antenna and the pins that switch off Wi-Fi and Bluetooth.
- [CM5 IO Board datasheet][cm5io-ds] (revision 3): Raspberry Pi's own carrier, with its schematics.
- [CM5 forward guidance][cm5-fwd] (revision 7): what changed from the Compute Module 4, and what a carrier has to allow for.
- [RP1 peripherals][rp1]: the chip behind the CM5's GPIO, UART, SPI and I²C pins.
- [Antenna kit brief][cm5-antenna]: the antenna that keeps the CM5's radio certification.
- Product briefs: [CM5][cm5-brief], [CM5 IO Board][cm5io-brief] and [development kit][cm5-devkit], with the variants and ordering codes.

From: [CM5 page][pip-cm5], [CM5 IO Board page][pip-cm5io], [forward guidance page][pip-fwd].

### Design files

- [CM5 IO Board, revision 2, KiCad][cm5io-kicad-2]: the starting point for a carrier, with the CM5's symbols and footprints (KiCad 9).
- [CM5 IO Board, revision 1, KiCad][cm5io-kicad-1]: the earlier revision, for comparison.
- 3D models: [CM5][cm5-step] and [CM5 Lite][cm5l-step], for the case and for checking clearances.

From: [CM5 design files][pip-cm5-design], [CM5 IO Board design files][pip-cm5io-design].

### Connectors

The CM5 sits on two 100-pin Amphenol connectors on the carrier; which part sets how high it sits.

- `10164227-1001A1RLF`: 1.5 mm stacking height, nothing fits under the module.
- `10164227-1004A1RLF`: 4.0 mm stacking height, 2.5 mm free under the module.
- [Amphenol customer drawing `10164227.pdf`][amph-drawing] (open in a browser).
- [BergStak 0.40 mm datasheet][amph-family], the connector family.
- [Digi-Key: 10164227-1001A1RLF][dk-amph], with CAD models.

The IO board's KiCad files already hold a footprint for the connectors.

Sources: [CM5 datasheet][cm5-ds] for the part numbers and heights.

### Certificates and change notices

- [EU Declaration of Conformity][cm5-doc], [FCC declaration][cm5-fcc] and [CB safety certificate][cm5-cb]: what the module itself is certified for, and so what a device built on it still needs.
- Product change notices on alternative [memory][cm5-pcn47], [eMMC storage][cm5-pcn52] and [SPI flash][cm5-pcn54] chips.

From: [approvals][pip-cm5-approvals], [change notices][pip-cm5-pcn].

### Software

- [Device trees for the CM5][rpi-dts] in Raspberry Pi's kernel (`bcm2712-rpi-cm5*.dts*`): the base for the carrier's own device tree or overlay.
- [Raspberry Pi's compute-module documentation][rpi-cm-docs]: the bootloader, flashing the eMMC, setting up peripherals and device trees, cameras and displays.

### Open CM5 carriers

- [Argo][argo] (CERN-OHL-S-2.0): a battery-powered carrier, with a charger and a converter to 5 V.
- [CM5 MINIMA REV2][minima2] and [REV1][minima1] (CERN-OHL-S-2.0): carriers the size of the module; REV1 has a LoRa module.
- [HackberryPi CM5][hackberry] (MIT): the main board of a hand-held, with its battery circuit.

## LattePanda Mu

LattePanda publishes the Mu's design files, documentation and certificates in three repositories on GitHub.

### Design guide

- [Carrier design guide][lp-guide]: power, power control, the edge connector and socket choice, PCIe, USB 2.0 and 3.2, SATA, HDMI, fan, automatic power-on and the BIOS, one page each.
- [High-speed lane assignment][lp-hsio]: which lanes go to USB, PCIe or SATA.
- The [guide's source pages][lp-docs-src], with their diagrams, for reading offline.
- [Full Eval board user manual][lp-eva-manual] (PDF).

### Design files

Everything here is in the [LattePanda-Mu repository][lp-repo] (MIT).

- [Edge-connector pinout][lp-pinout]: the module's 260 pins, as a spreadsheet and a description.
- [KiCad symbol for the module][lp-lib].
- [Example carriers][lp-examples]: the Lite Carrier in KiCad, with footprints for 4.0 mm and 8.0 mm sockets, and the Full Eval, GPU and Mini carriers.
- [Mechanical files][lp-mech]: the module's dimension drawing (PDF and DXF), 3D models of the module, its heat sinks and the carriers.
- [BIOS notes][lp-bios]: the BIOS variants, which set different lane assignments.

To download the repository without its BIOS and driver files (about 150 MB), in a terminal:

```sh
git clone --filter=blob:none --sparse https://github.com/LattePandaTeam/LattePanda-Mu.git
git -C LattePanda-Mu sparse-checkout set --no-cone '/*' '!/Softwares/' '/Softwares/**/README.md'
```

### Socket

The Mu plugs into a standard (not reverse) 260-pin DDR4 SODIMM socket, the kind used for laptop memory, at least 5.2 mm high.
LattePanda's guide recommends these, each with its own standoff height:

- TE `2309411-1`, 8.0 mm: [TE product page][te-2309411], with the drawing, 3D model and specifications.
- Foxconn `ASAA821-EASB0-7H`, 9.2 mm: [datasheet at LCSC][lcsc-foxconn].
- LOTES `ADDR0110-P005A`, 9.2 mm: [datasheet at LCSC][lcsc-lotes-92].
- LOTES `ADDR0207-P001A`, 5.2 mm: [datasheet at LCSC][lcsc-lotes-52].

The LCSC links open a viewer with a download button; they are a distributor's copies, not the makers' own.
The Lite Carrier's KiCad files already hold a footprint for an 8.0 mm socket.

Sources: [edge-connector design guide][lp-edge] for the socket rules and parts.

### Chip and layout guides

- [Intel N-series datasheet, volume 1][intel-ds] ([page][intel-page]): the processor's interfaces.
- [TI high-speed interface layout guidelines][ti-layout] (SPRAAR7J): routing rules for fast signals such as USB 3 and PCIe, which LattePanda's guide points to.

### Certificates

- [LattePanda Mu][lp-cert-mu]: CE, UKCA, FCC, KC, RoHS and electrical-safety reports.
- [Full Eval Carrier][lp-cert-eva]: the same for LattePanda's largest carrier.

### Open Mu carriers

- [MOKA][moka] (CERN-OHL-S-2.0): a community carrier.
- [Mu_Cyberdeck][mu-cyberdeck] (GPL-3.0): the carrier of a battery-powered cyber-deck.

## Licences

The files keep their makers' terms, which is why they stay out of this repository; link to them instead.

- **Raspberry Pi's documents** are under CC BY-ND 4.0, which allows sharing unchanged copies but not changed ones; the terms for its design files are on its [licensing page][rpi-licensing].
  The 3D models inside the IO board's KiCad files stay under their own makers' terms, as its `README.TXT` says.
- **LattePanda-Mu repository:** MIT.
  The documentation and certificate repositories state no licence.
- **Intel, TI, Amphenol, TE, LOTES and Foxconn documents:** their makers' copyright.
- **Open designs:** a board built on a CERN-OHL-S-2.0 design (Argo, CM5 MINIMA, MOKA) is published under the same licence (unsourced); Argo's author also asks for an agreement before commercial copies ([CARRIERS.md](CARRIERS.md#a-carrier-of-the-projects-own)).
  HackberryPi CM5 is under MIT and Mu_Cyberdeck under GPL-3.0.

[amph-drawing]: https://cdn.amphenol-cs.com/media/wysiwyg/files/drawing/10164227.pdf
[amph-family]: https://cdn.amphenol-cs.com/media/wysiwyg/files/documentation/datasheet/boardwiretoboard/bwb_bergstak_0_40mm_btb.pdf
[argo]: https://github.com/azlan-works/Argo
[cm5-antenna]: https://pip-assets.raspberrypi.com/categories/944-raspberry-pi-compute-module-5/documents/RP-008179-DS-3-antenna-kit-product-brief.pdf
[cm5-brief]: https://pip-assets.raspberrypi.com/categories/944-raspberry-pi-compute-module-5/documents/RP-008181-DS-13-cm5-product-brief.pdf
[cm5-cb]: https://pip-assets.raspberrypi.com/categories/1102-approvals/documents/RP-007524-CF-1-rpi-cm5%20Electrical%20Safety%20CB%20Certificate.pdf
[cm5-devkit]: https://pip-assets.raspberrypi.com/categories/944-raspberry-pi-compute-module-5/documents/RP-008185-DS-6-dev-kit-product-brief.pdf
[cm5-doc]: https://pip-assets.raspberrypi.com/categories/1102-approvals/documents/RP-007496-CF-2-rpi-cm5%20EU%20Declaration%20of%20Conformity%20%28DoC%29.pdf
[cm5-ds]: https://pip-assets.raspberrypi.com/categories/944-raspberry-pi-compute-module-5/documents/RP-008180-DS-8-cm5-datasheet.pdf
[cm5-fcc]: https://pip-assets.raspberrypi.com/categories/1102-approvals/documents/RP-007497-CF-1-rpi-cm5%20FCC%20sDoC.pdf
[cm5-fwd]: https://pip-assets.raspberrypi.com/categories/945-forward-guidance/documents/RP-005110-WP-7-CM5%20Forward%20Guidance.pdf
[cm5-pcn47]: https://pip-assets.raspberrypi.com/categories/1323-pcn/documents/RP-009749-PC-6-PCN%2047_%20CM5%20Alternative%20sources%20of%20RAM.pdf
[cm5-pcn52]: https://pip-assets.raspberrypi.com/categories/1323-pcn/documents/RP-010100-PC-2-PCN%2052_%20CM5%20Alternative%20sources%20of%20eMMC.pdf
[cm5-pcn54]: https://pip-assets.raspberrypi.com/categories/1323-pcn/documents/RP-010141-PC-1-PCN%2054_%20Raspberry%20Pi%20Compute%20Module%205%20Alternative%20sources%20of%20SPI%20flash.pdf
[cm5-step]: https://pip-assets.raspberrypi.com/categories/1096-design-files/documents/RP-007222-DD-2-rpi-cm5%203D_STEP.zip
[cm5io-brief]: https://pip-assets.raspberrypi.com/categories/1097-raspberry-pi-compute-module-5-io-board/documents/RP-008183-DS-2-cm5io-product-brief.pdf
[cm5io-ds]: https://pip-assets.raspberrypi.com/categories/1097-raspberry-pi-compute-module-5-io-board/documents/RP-008182-DS-3-cm5io-datasheet.pdf
[cm5io-kicad-1]: https://pip-assets.raspberrypi.com/categories/1098-design-files/documents/RP-007514-DD-2-rpi-cm5io%20Kicad.zip
[cm5io-kicad-2]: https://pip-assets.raspberrypi.com/categories/1098-design-files/documents/RP-008099-DD-1-CM5%20IO%20Board,%20revision%202,%20KiCAD%20files..zip
[cm5l-step]: https://pip-assets.raspberrypi.com/categories/1096-design-files/documents/RP-007220-DD-1-rpi-cm5lite%203D_STEP.zip
[dk-amph]: https://www.digikey.com/en/products/detail/amphenol-cs-fci/10164227-1001A1RLF/16908921
[hackberry]: https://github.com/CarbonComputers/Hackberry-Pi-CM5
[intel-ds]: https://cdrdv2.intel.com/v1/dl/getContent/759603?fileName=759603-002.pdf
[intel-page]: https://www.intel.com/content/www/us/en/content-details/759603/intel-processor-and-intel-core-i3-and-intel-core-3-n-series-datasheet-volume-1-of-2.html
[lcsc-foxconn]: https://www.lcsc.com/datasheet/C225724.pdf
[lcsc-lotes-52]: https://www.lcsc.com/datasheet/C962120.pdf
[lcsc-lotes-92]: https://www.lcsc.com/datasheet/C962122.pdf
[lp-bios]: https://github.com/LattePandaTeam/LattePanda-Mu/tree/main/Softwares/BIOS
[lp-cert-eva]: https://github.com/LattePandaTeam/LattePanda-Certification/tree/main/Full%20EVA%20Carrier%20for%20LattePanda%20Mu%20%28DFR1141%29
[lp-cert-mu]: https://github.com/LattePandaTeam/LattePanda-Certification/tree/main/LattePanda%20Mu
[lp-docs-src]: https://github.com/LattePandaTeam/Docs/tree/main/docs/content/mu_edition
[lp-edge]: https://docs.lattepanda.com/content/mu_edition/design_guide_edge_connector/
[lp-eva-manual]: https://github.com/LattePandaTeam/Docs/blob/main/docs/assets/images/mu_edition/LattePanda_Mu_EVA_Board_User_Manual.pdf
[lp-examples]: https://github.com/LattePandaTeam/LattePanda-Mu/tree/main/Electricals/Examples
[lp-guide]: https://docs.lattepanda.com/content/mu_edition/design_guide_foreword/
[lp-hsio]: https://docs.lattepanda.com/content/mu_edition/hsio_multiplexing/
[lp-lib]: https://github.com/LattePandaTeam/LattePanda-Mu/tree/main/Electricals/Libraries
[lp-mech]: https://github.com/LattePandaTeam/LattePanda-Mu/tree/main/Mechanicals
[lp-pinout]: https://github.com/LattePandaTeam/LattePanda-Mu/tree/main/Electricals/Pinouts
[lp-repo]: https://github.com/LattePandaTeam/LattePanda-Mu
[minima1]: https://github.com/piecol/CM5_MINIMA_REV1
[minima2]: https://github.com/piecol/CM5_MINIMA_REV2
[moka]: https://github.com/piecol/lattepanda_MOKA
[mu-cyberdeck]: https://github.com/BenMakesEverything/Mu_Cyberdeck
[pip-cm5]: https://pip.raspberrypi.com/categories/944-raspberry-pi-compute-module-5
[pip-cm5-approvals]: https://pip.raspberrypi.com/categories/1102-approvals
[pip-cm5-design]: https://pip.raspberrypi.com/categories/1096-design-files
[pip-cm5-pcn]: https://pip.raspberrypi.com/categories/1323-pcn
[pip-cm5io]: https://pip.raspberrypi.com/categories/1097-raspberry-pi-compute-module-5-io-board
[pip-cm5io-design]: https://pip.raspberrypi.com/categories/1098-design-files
[pip-fwd]: https://pip.raspberrypi.com/categories/945-forward-guidance
[rp1]: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
[rpi-cm-docs]: https://github.com/raspberrypi/documentation/tree/master/documentation/asciidoc/computers/compute-module
[rpi-dts]: https://github.com/raspberrypi/linux/tree/rpi-6.18.y/arch/arm64/boot/dts/broadcom
[rpi-licensing]: https://www.raspberrypi.com/licensing/
[te-2309411]: https://www.te.com/en/product-2309411-1.html
[ti-layout]: https://www.ti.com/lit/an/spraar7j/spraar7j.pdf
