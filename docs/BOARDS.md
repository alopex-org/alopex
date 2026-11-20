# Development boards

**Status: research.**
A comparison of the development boards, and a few other devices, that could carry the bench work in roadmap task [T2](ROADMAP.md#t2-development-board-bring-up), with a proposed choice.
It expands the [Development board](FEASIBILITY.md#development-board) section of the feasibility study.

Sources were checked on 2026-11-20 and 2026-11-21.
Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
⚠ marks a claim that is unconfirmed or disputed; check it before relying on it.
"(unsourced)" marks a statement from general knowledge that was not checked against a source.
Prices are list prices on the day they were checked, not quotes.

## Summary

- **Only NXP ships a vendor Android release on the current Android version.**
  Its Android 17 release of 2026-11-03 covers the i.MX 8M Plus and i.MX 95 evaluation kits, on kernel 6.18.
- **The other chip vendors are one to five releases behind.**
  TI and MediaTek ship Android 16, MediaTek's on an Android 14 vendor layer; the Rockchip and Qualcomm boards list Android 12 or 14.
- **A community build reaches Android 17 on the Raspberry Pi 5,** but it is one developer's work, not a vendor's.
- **Mainline Linux has device trees for most of these boards, and open drivers for their GPUs,** so the project can compare a vendor kernel with the upstream one.
- **Secure-boot documentation differs most.**
  NXP's i.MX 8M chips and the Raspberry Pi have public guides and tools; Rockchip's signing tool is closed; TI's and Qualcomm's tools sit behind a request or a licence.
- **Proposed for T2:** an NXP i.MX 95 board, with BeaglePlay as the cheaper alternative ([Recommendation](#recommendation-for-t2)).

## What "open-source ready" means here

A board suits the bench work when it meets most of these:

1. **Android builds from published source.**
   The kernel, the device tree and the Android layers can be downloaded and built without an agreement that keeps the result private.
   Closed firmware is common; what matters is that the build itself needs nothing private.
2. **The vendor's Android is close to the current release,** on a kernel from a supported [GKI](FEASIBILITY.md#terms) branch.
   Android 17 is the current release, and its GKI branch is `android17-6.18`.
3. **The [mainline kernel](FEASIBILITY.md#terms) supports the board and its GPU,** with an open driver in the kernel and in [Mesa](FEASIBILITY.md#terms).
   The board can then outlive its vendor's BSP, as the Fairphone 5 is starting to ([Phones as development devices](#phones-as-development-devices)).
4. **Secure boot is documented publicly,** with tools anyone can get, so fusing can be practised without a vendor licence.
5. **The chip stays available for years,** ideally with a published longevity commitment.

Open hardware, with schematics and board layout published under an open licence, is a bonus: it shows how a working board is built (unsourced).

Sources: [NXP RN00201][nxp-rn00201].

## Comparison

| Board | Chip | Vendor Android | Mainline Linux | Secure-boot guide |
|---|---|---|---|---|
| [NXP i.MX 95 EVK, FRDM-IMX95](#nxp-imx-8m-plus-and-imx-95) | i.MX 95 | 17, kernel 6.18 | Boards and GPU | ⚠ Not found |
| [NXP i.MX 8M Plus EVK](#nxp-imx-8m-plus-and-imx-95) | i.MX 8M Plus | 17, kernel 6.18 | Board and GPU | Public |
| [BeaglePlay](#beagleplay-and-ti-am62x) | TI AM625 | 16, kernel 6.12 | Board and GPU | Public; ⚠ tool access |
| [Raspberry Pi 5, CM5](#raspberry-pi-5-and-compute-module-5) | BCM2712 | None; a community 17 | Pi 5 and GPU | Public, with a tool |
| [Radxa Rock 5B](#rockchip-rk3588-boards) | RK3588 | 12 | Board and GPU | Vendor guide; closed tool |
| [MediaTek Genio EVKs](#mediatek-genio-boards) | Genio 510, 700, 1200 | 16, on a 14 vendor layer | Boards and GPU | Not checked |
| [Khadas VIM3](#aosp-reference-boards) | Amlogic A311D | 16, from BayLibre | Board | Not checked |
| [Thundercomm C6490 kit](#qualcomm-qcs6490-boards) | QCS6490 | 12 | Chip; RB3 Gen 2 board | Licensed users only |

"Mainline Linux" means the board has a device tree in the mainline kernel (Linux 7.4-rc3 on 2026-11-21), and its GPU an open driver there.
None of these boards has a cellular modem.

Sources: the sections below.

## NXP i.MX 8M Plus and i.MX 95

NXP's Android release android-17.0.0_1.0.0, of 2026-11-03, covers the i.MX 8M Mini, Nano, Plus and Quad, the i.MX 8ULP, 8QuadMax and 8QuadXPlus, and the i.MX 95, 952 and 937.

- **Quality:** general availability on the i.MX 8M Plus EVK, the i.MX 95 19x19 EVK and the FRDM-IMX95; the FRDM-IMX937 is in beta.
  An EVK (evaluation kit) is the chip vendor's own reference board.
- **Versions:** based on android-17.0.0_r1, with Linux 6.18.37 merged with the AOSP kernel, a GKI 6.18.32 image from AOSP's `android17-6.18` branch, U-Boot v2026.04 and the Trusty TEE.
- **Source:** NXP delivers most of the release as source code, except some proprietary modules and libraries from third parties.
  NXP's Android page offers the source package after a licence step.
  ⚠ Whether downloading it needs an NXP account was not confirmed (check C9).
- **GPU in NXP's build:** closed vendor drivers.
  The i.MX 95 has a Mali-G310 with Arm's r56p0 driver and Vulkan 1.4; the i.MX 8M Plus has a Vivante GC7000UL with driver 6.4.11.p4 and Vulkan 1.3.
- **Mainline Linux:** device trees for the i.MX 8M Plus EVK, the i.MX 95 19x19 EVK and the i.MX 95 15x15 FRDM board.
  The i.MX 95's GPU uses the open Panthor driver's binding (`arm,mali-valhall-csf`), and the i.MX 8M Plus's GPU the open Etnaviv driver's (`vivante,gc`).
- **Security features in NXP's build:** verified boot backed by the Trusty TEE, encrypted boot, an OEM-unlock flag kept by software, and A/B updates with secure boot.
  NXP's Android security user's guide (UG10158) comes in the release's documentation package.
- **Secure boot:** HABv4 on the i.MX 8M chips and AHAB on the i.MX 95; these are NXP's two secure-boot mechanisms.
  - U-Boot's documentation has a public step-by-step HABv4 guide for the i.MX 8M, 8M Mini, 8M Nano and 8M Plus.
  - Its public AHAB guide covers only the i.MX 93.
    It warns that closing the chip is irreversible, and that a wrong key hash leaves a chip that doesn't boot.
  - ⚠ No public AHAB guide for the i.MX 95 was found (check C9).
- **Availability:** NXP's longevity programme lists the i.MX 8M Plus until March 2036 and the i.MX 95 until May 2041.
  NXP says the periods run from launch, and that products are not discontinued automatically when they end.
- **BSP support:** Variscite, a module maker, projects about two years of support for each i.MX Android BSP version.
- **Cost:** not checked (check C9).

**Verdict:** the vendor BSP closest to the current Android release, and the longest published availability.
Its weak points are the closed GPU drivers and third-party modules in NXP's build, and, for the i.MX 95, the missing public AHAB guide.

Sources: [NXP RN00201][nxp-rn00201], [NXP Android page][nxp-android], [NXP product longevity][nxp-longevity], [Linux device trees][linux-dts], [Linux: i.MX 95][linux-imx95], [Linux: i.MX 8M Plus][linux-imx8mp], [Linux: Mali CSF binding][linux-mali-csf], [U-Boot HABv4 guide for i.MX 8M][uboot-hab-8m], [U-Boot AHAB guide for i.MX 93][uboot-ahab-93], [Variscite Android lifecycle][variscite-lifecycle].

## BeaglePlay and TI AM62x

BeaglePlay is a BeagleBoard.org board on TI's AM625 chip.

- **Open hardware:** certified by OSHWA (certificate US002174, 2023), with the hardware and documentation under CC BY-SA 4.0 and the software under the GPL.
- **Android:** TI's Processor SDK Android 11.00.01, of February 2026, brings Android 16 on Linux 6.12 and U-Boot 2025.01 to TI's AM62x starter kits and to BeaglePlay.
  It refreshes release 11.00.00 of October 2025.
- **Source:** a public `repo` manifest on git.ti.com; TI's build guide shows no account step.
- **Security features in TI's build:** custom AVB keys, KeyMint and Gatekeeper (Android's key-storage and lock-screen services) running in the OP-TEE TEE, and locking and unlocking the device.
  Release 11.00.00 added verified boot with OP-TEE and rollback protection.
- **GPU:** a PowerVR AXE-1-16M.
  Mainline Linux binds it to the open PowerVR driver (`ti,am62-gpu`).
  Mesa develops Vulkan for it, but lists it as not yet conformant; Mesa's conformant PowerVR GPUs are the BXM-4-64 and BXS-4-64.
  ⚠ TI's release notes don't say which GPU driver its Android build uses (check C9).
- **Mainline Linux:** a device tree for BeaglePlay.
- **Secure boot:** AM62x chips leave TI's factory as HS-FS parts.
  They enforce secure boot once the customer's keys are programmed into their fuses with TI's OTP keywriter, which turns them into HS-SE parts.
  - ⚠ TI's public guide doesn't say how to obtain the keywriter (check C9).
  - ⚠ Whether BeaglePlay's AM625 is an HS-FS part that can be fused was not found (check C9).
- **Support:** TI's BeaglePlay page says TI offers no ongoing direct design support for the board.
- **Cost:** TI's page lists no price; about a hundred dollars (unsourced, check C9).
- **Speed:** the AM625 is a low-end chip, so Android on it runs slowly (unsourced).

**Verdict:** the cheapest board with an official Android build, and the only certified open hardware here.
It is one Android release behind, and its fusing path isn't fully public.

Sources: [OSHWA certificate][oshwa-beagleplay], [TI Android 11.00.01 release notes][ti-android-1101], [TI Android 11.00.00 release notes][ti-android-1100], [TI Android build guide][ti-android-build], [TI keywriter guide][ti-keywriter], [TI BeaglePlay page][ti-beagleplay], [Linux device trees][linux-dts], [Linux: PowerVR binding][linux-powervr], [Mesa PowerVR driver][mesa-powervr].

## Raspberry Pi 5 and Compute Module 5

Raspberry Pi offers no official Android.

- **Community Android:** KonstaKANG's AOSP 17 build for the Pi 5, the Pi 500 and the Compute Module 5 (CM5), dated 2026-10-30, runs Linux 6.18.38 and Mesa 26.2.6.
  - It is built from the author's published Raspberry Vanilla source.
  - The GPU (V3D) works with OpenGL and Vulkan, through Mesa.
  - SELinux is permissive, and encrypting user data is not supported.
  - It includes parts under a non-commercial licence, so the build may not be used commercially.
- **Mainline Linux:** device trees for the Pi 5, with the GPU bound to the open V3D driver (`brcm,2712-v3d`).
  No mainline device tree for the CM5 was found.
- **Secure boot:** documented publicly.
  - The hash of the customer's RSA key is stored in the chip's one-time-programmable (OTP) memory; on the Pi 5's BCM2712 the same key also signs the bootloader in EEPROM.
  - Raspberry Pi's Secure Boot Provisioner automates provisioning, and is open source under the Apache 2.0 licence.
  - Some steps are permanent, and losing the private key ends trusted bootloader updates for the device.
- **Availability:** Raspberry Pi says both the Pi 5 and the CM5 stay in production until at least January 2036.
- **Cost:** the CM5 from $67.50; the Pi 5 with 16 GB at $305.

**Verdict:** the cheapest way to practise fusing with public documents and an open tool.
The Android build is one developer's, not production quality, and not for commercial use.

Sources: [KonstaKANG AOSP 17][konstakang-aosp17], [Linux device trees][linux-dts], [Linux: BCM2712][linux-bcm2712], [Raspberry Pi security architecture][rpi-security], [Raspberry Pi Secure Boot Provisioner][rpi-provisioner], [rpi-sb-provisioner source][rpi-provisioner-src], [Raspberry Pi 5][rpi5], [Compute Module 5][rpi-cm5].

## Rockchip RK3588 boards

- **Android:** Radxa lists Android 12 for the Rock 5B and 5B+, Android 12 and 14 for the Rock 5C, and Android 14 for its RK3576 boards.
  Other vendors ship Android 14 on kernel 6.1 for the RK3588, for example Advantech.
- **Mainline Linux:** device trees for the Rock 5B and 5B+, with the Mali GPU bound to the open Panthor driver (`rockchip,rk3588-mali`).
  Collabora reported in March 2026 that the RK3588's Mali GPU passed Vulkan 1.4 conformance, and that chips with mainline support need no device-specific images.
- **Secure boot:**
  - The chip's boot ROM checks the public key against a hash in its fuses.
  - There is a single root key hash, which can't be revoked or rotated, and only RSA-2048 and RSA-4096 keys.
  - Rockchip published a secure-boot developer guide, but its signing tool is a closed binary.
  - Pengutronix wrote an open replacement, `rkimage`, used with the `rksecure` command of the barebox bootloader.
- **Cost:** hundreds of dollars per board (unsourced).

**Verdict:** among the best mainline support of the chips here, but vendor Android three to five releases behind.
The only open secure-boot tooling comes from a third party.

Sources: [Radxa support matrix][radxa-matrix], [Advantech RK3588 Android 14][advantech-rk3588], [Linux device trees][linux-dts], [Linux: Mali CSF binding][linux-mali-csf], [Collabora on Rockchip][collabora-rockchip], [Pengutronix on RK3588 secure boot][pengutronix-rk3588].

## MediaTek Genio boards

- **Android from MediaTek:** its IoT Android 16 release covers the Genio 360, 420, 510, 520, 700, 720 and 1200.
  - Kernels: 6.6 on the Genio 360; 6.1 on the 420, 520 and 720; 5.15 on the 510, 700 and 1200.
  - These are "vendor freeze" builds: Android 16 on a vendor layer based on Android 14.
- **AOSP from BayLibre:** BayLibre maintains an AOSP SDK for the Genio 350, 510 and 700, with the source on its GitLab.
  - It comes under MediaTek's AIoT software licence agreement.
  - Most modules are under open-source licences, but some repositories may need a non-disclosure agreement.
  - It has no Google apps.
- **Mainline Linux:** device trees for the Genio 510, 700 and 1200 EVKs.
  CNX Software reports that the Genio 1200 boards boot mainline without out-of-tree patches, with the Mali-G57 GPU on the open Panfrost driver, and that the 510 and 700 boot recent mainline too.
- **Secure boot:** not checked.

**Verdict:** good mainline progress, but the vendor Android sits on an Android 14 vendor layer, and the AOSP route may need a non-disclosure agreement.

Sources: [MediaTek IoT Android 16 release notes][genio-android16], [Genio AOSP SDK][genio-aosp], [Linux device trees][linux-dts], [CNX Software on Genio mainline][cnx-genio].

## AOSP reference boards

- AOSP lists the DragonBoard 845c, the Qualcomm RB5 and the Khadas VIM3 as reference boards, but says they are not supported or tested in AOSP.
  The board makers provide the BSPs.
- **Khadas VIM3:** in December 2025 Khadas support published an Android 16 build from BayLibre's `yukawa-android-16` manifest.
  - It runs kernel 6.12 by default, with a mainline kernel as an option.
  - It drives HDMI output only.
  - The VIM3 uses Amlogic's A311D, and mainline Linux has a device tree for it.
- **DragonBoard 845c and RB5:** their current Android status was not checked.

**Verdict:** familiar to AOSP developers, but none comes with a commitment from AOSP, and the VIM3's build is HDMI-only.

Sources: [AOSP reference boards][aosp-boards], [Khadas forum][khadas-vim3-a16], [Linux device trees][linux-dts].

## Qualcomm QCS6490 boards

The QCS6490 belongs to the chip family of the Fairphone 5 and of the Quectel SG560D module, so bring-up on it would carry over to task T3.

- **Android:** Thundercomm's C6490 Development Kit lists Android 12, at $1,399.
  Qualcomm lists Android for the chip; its documented stack for its own RB3 Gen 2 board is Qualcomm Linux, on Linux 6.18.
- ⚠ How Qualcomm or the board makers distribute the Android BSP, and on what terms, was not found (check C5).
- **Mainline Linux:** device trees for the RB3 Gen 2, Thundercomm's Rubik Pi 3 and the Fairphone 5.
- **Secure boot:** images are signed with Qualcomm's SecTools, whose guides are for licensed users only (check C5).

**Verdict:** the closest to a phone, but the most expensive board here, with the oldest Android and closed signing tools.
Worth buying only if check C5 shows the tools and BSP are within reach.

Sources: [Thundercomm C6490 Development Kit][thundercomm-c6490], [Qualcomm: Android on Dragonwing][qc-android-dw], [Qualcomm kernel docs][qc-kernel], [Linux device trees][linux-dts], [Qualcomm: sign and flash the images][qc-sign], [Quectel SG560D][quectel-sg560d], [CNX Software on the Fairphone 5][cnx-fp5].

## Phones as development devices

A phone has the parts a board lacks: a modem, cameras and a battery.
The project can't practise fusing on one, because its maker holds the secure-boot key.

- **Fairphone 5:**
  - An official LineageOS device on LineageOS 24.0, built on the vendor's 5.4 kernel for the QCM6490.
  - At FOSDEM 2026, Fairphone's Software Longevity Team reported the phone's mainline Linux status.
    Most functions work, among them 3D graphics, Wi-Fi, Bluetooth, GPS, SMS, mobile data and the sensors.
    Audio, the cameras and calls work partly, and NFC doesn't work yet.
  - It shows how a phone with a modem can move from a vendor kernel to mainline.
- **PinePhone and PinePhone Pro:** GloDroid 2.0, an AOSP port for single-board computers and phones, runs on both and on the Raspberry Pi 4.
  - Its manifest doesn't say which Android version it is on.
  - Pine64 discontinued the PinePhone Pro in 2025, and ⚠ reportedly halted production of all its Linux devices in 2026 (check C8).

**Verdict:** the Fairphone 5 is the best place to watch a phone move to mainline Linux, but neither phone replaces a board for secure-boot practice.

Sources: [LineageOS wiki data for the FP5][lineage-fp5], [LineageOS build targets][lineage-targets], [Fairphone at FOSDEM 2026][fosdem-fp-mainline], [GloDroid manifest][glodroid], [Pine64][pine64-aug2025], [Tom's Hardware][toms-pine64].

## Not considered: RISC-V boards

- In 2024 Google removed RISC-V support from its Android common kernel and GKI.
  Google said Android would keep supporting RISC-V, but wasn't ready to provide a single supported image for all vendors.
- heise reports that Alibaba's DAMO Academy ported Android 16 to its XuanTie RVA23 chips in May 2026, claiming compatibility with AVB, GKI, GSI and VINTF.
  Whether that work is upstream is not stated.
- Until Google's GKI covers RISC-V again, a RISC-V board teaches a different bring-up from any device the project could ship soon (unsourced).

Sources: [Android Authority on RISC-V][aa-riscv], [heise on RISC-V][heise-riscv].

## Recommendation for T2

Proposed; the maintainer decides when buying the board.
Check C9 confirms the details first.

1. **Main board: an NXP i.MX 95 board,** the 19x19 EVK or the FRDM-IMX95.
   - The only vendor BSP on the current Android release, at general-availability quality, on a GKI 6.18 kernel.
   - Listed until May 2041.
   - Mainline Linux supports both boards and the GPU, so the project can compare NXP's kernel with mainline.
   - Weak points: closed GPU drivers and third-party modules in NXP's build, and no public AHAB guide for the chip (check C9).
   - If check C9 finds no AHAB guide, the i.MX 8M Plus EVK is the alternative: the same Android 17 release, a public HABv4 guide in U-Boot, and listed until March 2036.
2. **Cheaper alternative: BeaglePlay.**
   Open hardware, with an official Android 16 build, custom AVB keys and device locking.
   It is one release behind, the chip is slow, and its fusing path is unclear (check C9).
3. **For fusing practice:** a second unit of the main board, or a Raspberry Pi CM5, whose fusing is documented publicly with an open tool.
   As task T2 says, fuse only a board bought for that purpose, with the maintainer's go-ahead for each step.
4. **Before task T3:** a QCS6490 board only if check C5 shows that Qualcomm's signing tools and Android BSP are within reach of a small buyer.
   Otherwise the module's evaluation kit in T3 is the first Qualcomm hardware.

## Sources

Checked on 2026-11-20, except the Linux, LineageOS and GloDroid sources, checked again on 2026-11-21.

### NXP

- [NXP RN00201][nxp-rn00201]: the Android 17 release (android-17.0.0_1.0.0, 2026-11-03), its boards, quality, versions, GPU drivers and security features.
- [NXP Android page][nxp-android]: the release's packages, and the licence step before the source download.
- [NXP product longevity][nxp-longevity]: the i.MX 8M Plus until March 2036, the i.MX 95 until May 2041.
- [Variscite Android lifecycle][variscite-lifecycle]: about two years of support for each BSP version.
- [U-Boot HABv4 guide for i.MX 8M][uboot-hab-8m]: the public HABv4 guide for the i.MX 8M family.
- [U-Boot AHAB guide for i.MX 93][uboot-ahab-93]: the public AHAB guide, its irreversible step and its warning.

### TI and BeaglePlay

- [OSHWA certificate][oshwa-beagleplay]: BeaglePlay certified as open hardware, and its licences.
- [TI Android 11.00.01 release notes][ti-android-1101]: Android 16, Linux 6.12, U-Boot 2025.01, the supported boards and the security features.
- [TI Android 11.00.00 release notes][ti-android-1100]: verified boot with OP-TEE and rollback protection.
- [TI Android build guide][ti-android-build]: the public `repo` manifest.
- [TI keywriter guide][ti-keywriter]: HS-FS and HS-SE parts, and programming the customer's keys.
- [TI BeaglePlay page][ti-beagleplay]: no price, and no ongoing design support from TI.
- [Mesa PowerVR driver][mesa-powervr]: which PowerVR GPUs are conformant and which are in development.

### Raspberry Pi

- [KonstaKANG AOSP 17][konstakang-aosp17]: the community Android 17 build, what works, and its licence restriction.
- [Raspberry Pi security architecture][rpi-security]: the customer key's hash in OTP memory, the signed bootloader and the permanent steps.
- [Raspberry Pi Secure Boot Provisioner][rpi-provisioner] and [rpi-sb-provisioner source][rpi-provisioner-src]: the provisioning tool and its licence.
- [Raspberry Pi 5][rpi5] and [Compute Module 5][rpi-cm5]: prices and production until at least January 2036.

### Rockchip, MediaTek and the reference boards

- [Radxa support matrix][radxa-matrix]: Android versions for Radxa's boards.
- [Advantech RK3588 Android 14][advantech-rk3588]: Android 14 on kernel 6.1 for the RK3588.
- [Collabora on Rockchip][collabora-rockchip]: Vulkan 1.4 conformance on the RK3588's GPU, and mainline images.
- [Pengutronix on RK3588 secure boot][pengutronix-rk3588]: the RK3588's root of trust, the closed signing tool and the open replacement.
- [MediaTek IoT Android 16 release notes][genio-android16]: the Genio chips, kernels and vendor-freeze builds.
- [Genio AOSP SDK][genio-aosp]: BayLibre's AOSP SDK and its licence terms.
- [CNX Software on Genio mainline][cnx-genio]: the Genio boards on mainline Linux.
- [AOSP reference boards][aosp-boards]: the three reference boards, not supported or tested in AOSP.
- [Khadas forum][khadas-vim3-a16]: the VIM3's Android 16 build.

### Qualcomm and phones

- [Thundercomm C6490 Development Kit][thundercomm-c6490]: Android 12, and the price.
- [Qualcomm: Android on Dragonwing][qc-android-dw]: Android listed for the QCS6490.
- [Qualcomm kernel docs][qc-kernel]: Qualcomm Linux on Linux 6.18 for the RB3 Gen 2.
- [Qualcomm: sign and flash the images][qc-sign]: SecTools, with guides only for licensed users.
- [Quectel SG560D][quectel-sg560d] and [CNX Software on the Fairphone 5][cnx-fp5]: the QCM6490 and QCS6490 chip family.
- [LineageOS wiki data for the FP5][lineage-fp5] and [LineageOS build targets][lineage-targets]: the Fairphone 5 on LineageOS 24.0 and its kernel.
- [Fairphone at FOSDEM 2026][fosdem-fp-mainline]: the Fairphone 5's mainline Linux status.
- [GloDroid manifest][glodroid]: GloDroid 2.0's ports.
- [Pine64][pine64-aug2025] and [Tom's Hardware][toms-pine64]: the PinePhone Pro discontinued, and ⚠ the production halt.

### Linux

- [Linux device trees][linux-dts]: the mainline device trees for the boards above (Linux 7.4-rc3).
- [Linux: i.MX 95][linux-imx95], [Linux: i.MX 8M Plus][linux-imx8mp] and [Linux: BCM2712][linux-bcm2712]: the GPU nodes.
- [Linux: Mali CSF binding][linux-mali-csf] and [Linux: PowerVR binding][linux-powervr]: the GPU bindings for the i.MX 95, the RK3588 and the AM62x.

### RISC-V

- [Android Authority on RISC-V][aa-riscv]: RISC-V removed from Android's common kernel, and Google's statement.
- [heise on RISC-V][heise-riscv]: Alibaba's Android 16 port.

[nxp-rn00201]: https://www.nxp.com/docs/en/release-note/RN00201.pdf
[nxp-android]: https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/android-os-for-i-mx-applications-processors:IMXANDROID
[nxp-longevity]: https://www.nxp.com/products/product-information/product-longevity:PRDCT_LONGEVITY_HM
[variscite-lifecycle]: https://dev.variscite.com/software-and-security/software-lifecycle/android-lifecycle/
[uboot-hab-8m]: https://github.com/u-boot/u-boot/blob/master/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
[uboot-ahab-93]: https://docs.u-boot.org/en/latest/imx/ahab/guides/mx93_secure_boot.html
[oshwa-beagleplay]: https://certification.oshwa.org/us002174.html
[ti-android-1101]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_01/docs/devices/AM62X/android/Release_Specific_Release_Notes.html
[ti-android-1100]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_00/docs/devices/AM62X/android/Release_Specific_Release_Notes.html
[ti-android-build]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_01/docs/android/Overview_Building_the_SDK.html
[ti-keywriter]: https://software-dl.ti.com/tisci/esd/12_01_02/6_topic_user_guides/key_writer.html
[ti-beagleplay]: https://www.ti.com/tool/BEAGL-PLAY-SBC
[mesa-powervr]: https://docs.mesa3d.org/drivers/powervr.html
[konstakang-aosp17]: https://konstakang.com/devices/rpi5/AOSP17
[rpi-security]: https://www.raspberrypi.com/documentation/security/security-architecture.html
[rpi-provisioner]: https://www.raspberrypi.com/documentation/security/secure-boot-provisioner.html
[rpi-provisioner-src]: https://github.com/raspberrypi/rpi-sb-provisioner
[rpi5]: https://www.raspberrypi.com/products/raspberry-pi-5/
[rpi-cm5]: https://www.raspberrypi.com/products/compute-module-5/
[radxa-matrix]: https://docs.radxa.com/en/software-support-matrix/rockchip
[advantech-rk3588]: https://docs.aim-linux.advantech.com/docs/bsp/rockchip/Android/Android14/RK3588/
[collabora-rockchip]: https://www.collabora.com/news-and-blog/blog/2026/03/02/running-mainline-linux-u-boot-and-mesa-on-rockchip-a-year-in-review/
[pengutronix-rk3588]: https://www.pengutronix.de/en/blog/2026-06-19-rk3588-secure-boot.html
[genio-android16]: https://genio.mediatek.com/doc/android/sw/android/release-notes/iot-android-v16-release-note.html
[genio-aosp]: https://genio.mediatek.com/aosp
[cnx-genio]: https://www.cnx-software.com/2025/11/04/progress-on-upstream-linux-for-mediatek-genio-iot-socs-and-boards/
[aosp-boards]: https://source.android.com/docs/setup/devices
[khadas-vim3-a16]: https://forum.khadas.com/t/vim3-vim3l-aosp-android-16-baklava/26273
[thundercomm-c6490]: https://www.thundercomm.com/product/c6490-development-kit
[qc-android-dw]: https://www.qualcomm.com/developer/software/android-on-dragonwing
[qc-kernel]: https://dragonwingdocs.qualcomm.com/System/Kernel
[qc-sign]: https://dragonwingdocs.qualcomm.com/System/Security/sign-and-flash-the-images
[quectel-sg560d]: https://www.quectel.com/product/5g-sg560d-smart-module-series/
[cnx-fp5]: https://www.cnx-software.com/2023/08/31/fairphone-5-smartphone-comes-with-8-years-of-software-updates-with-qualcomm-qcm6490-industrial-iot-processor/
[lineage-fp5]: https://github.com/LineageOS/lineage_wiki/blob/main/_data/devices/FP5.yml
[lineage-targets]: https://github.com/LineageOS/hudson/blob/main/lineage-build-targets
[fosdem-fp-mainline]: https://archive.fosdem.org/2026/events/attachments/ZNAAZX-mainline_kernel_for_fairphones_-_2026_update/slides/266938/fosdem_20_rsemaak.pdf
[glodroid]: https://github.com/GloDroid/glodroid_manifest
[pine64-aug2025]: https://pine64.org/2025/08/14/august_2025_short_update/
[toms-pine64]: https://www.tomshardware.com/pc-components/dram/pine64-halts-all-linux-device-production-until-at-least-mid-2027-as-memory-shortage-bites
[linux-dts]: https://github.com/torvalds/linux/tree/master/arch/arm64/boot/dts
[linux-imx95]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx95.dtsi
[linux-imx8mp]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8mp.dtsi
[linux-bcm2712]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
[linux-mali-csf]: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/gpu/arm%2Cmali-valhall-csf.yaml
[linux-powervr]: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/gpu/img%2Cpowervr-rogue.yaml
[aa-riscv]: https://www.androidauthority.com/android-drop-risc-v-kernel-3438330/
[heise-riscv]: https://www.heise.de/en/news/Alibaba-optimizes-Android-16-for-RISC-V-chips-11308808.html
