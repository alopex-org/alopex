# Development boards

**Status: research.**
A development board is a small computer board sold for trying out a chip.
This page compares boards for the bench work in roadmap task [T2](ROADMAP.md#t2-development-board-bring-up), where the project first gets Android running on hardware, and proposes which to buy.
The focus is on RISC-V boards: boards whose processor uses the open RISC-V design, which any chip maker may use.
Arm boards, the kind almost all phones use, are covered for comparison, because their Android support is older and more complete.
This expands the [Development board](FEASIBILITY.md#development-board) section of the feasibility study.
It was written for the earlier phone plan; the cyber-deck's main board is open (roadmap decision [D1](ROADMAP.md#d1-route-to-a-prototype)) and runs a Linux distribution ([D6](ROADMAP.md#d6-operating-system-of-the-first-prototype)), so these boards are candidates for the bench, judged on their Linux support, not a choice.
Technical words are explained in the [glossary](GLOSSARY.md).

**How to read it:**

- Sources were checked on 2026-11-20 and 2026-11-21.
- Each section ends with the sources behind it, and the [Sources](#sources) section lists them all.
- ⚠ marks a claim that isn't confirmed, or that sources disagree on; check it before relying on it.
- "(unsourced)" marks a statement from general knowledge that wasn't checked against a source.
- Prices are list prices on the day they were checked, not quotes.

## In short

- Android 17 now runs on two RISC-V boards, but only as an early version for developers.
- Google itself has stepped back from RISC-V for now, and no RISC-V chip with a mobile-network modem was found, so a RISC-V device would start as Wi-Fi only.
- Among Arm boards, NXP's are the most up to date and the best documented for security.
- The proposal, made for the earlier phone plan: buy a SpacemiT K3 Pico-ITX (RISC-V) to get Android running, and an NXP i.MX 95 board to practise the security steps.

## Summary

- **Android 17 runs on two RISC-V boards,** the SpacemiT K3 Pico-ITX and Alibaba's A210 EVB.
  The company BayLibre built it for the RISE project and released it in October 2026, with source code, ready-made images and open graphics drivers.
  RISE calls it a developer release, not ready for products or certified.
- **Google's own RISC-V support in Android is incomplete.**
  Google's shared Android kernel (GKI) dropped RISC-V in 2024, and Google's last published status, from 2025, runs Android on RISC-V only in virtual devices.
  So a RISC-V device needs a kernel kept outside GKI, as the RISE release does.
- **No public secure-boot documentation was found for any RISC-V board,** and the RISE release turns verified boot off on the A210.
- **No RISC-V chip with a mobile-network modem and an Android software package (BSP) was found,** so a RISC-V device would start as Wi-Fi only ([decision D2](ROADMAP.md#d2-cellular-or-wi-fi-only)).
- **Among Arm boards, only NXP ships its own Android 17 release,** on kernel 6.18, with public secure-boot guides for its chips.
  TI and MediaTek ship Android 16, and the Rockchip and Qualcomm boards list Android 12 to 15.
- **Proposed for T2:** the SpacemiT K3 Pico-ITX for the Android bring-up, with an NXP i.MX 95 board alongside for verified-boot and secure-boot practice ([Recommendation](#recommendation-for-t2)).

## What "open-source ready" means here

What makes a board suitable for the project's bench work.
A board suits it when it meets most of these:

1. **Android builds from published source code.**
   The kernel, the device files and the Android layers can be downloaded and built without an agreement that keeps the result private.
   Closed firmware is common; what matters is that the build itself needs nothing private.
2. **Its Android version is close to the current one,** on a kernel that still gets updates.
   Android 17 is the current release; on Arm its GKI version is `android17-6.18`.
3. **The [mainline kernel](GLOSSARY.md#software-for-hardware), Linux as its own developers release it, supports the board and its graphics chip,** with an open driver in the kernel and in [Mesa](GLOSSARY.md#chips-and-boards).
   The board can then outlive its maker's software package (BSP), as the Fairphone 5 is starting to ([Phones as development devices](#phones-as-development-devices)).
4. **Secure boot is documented publicly,** with tools anyone can get, so fusing can be practised without a licence from the chip maker.
5. **The chip stays on sale for years,** ideally with a published promise of how long.

For a RISC-V board, the chip should also support [RVA23](GLOSSARY.md#chips-and-boards), the set of RISC-V features that both Android 17 and Alibaba's Android 16 work expect.

Sources: [Android common kernels][aosp-common-kernels], [RISE Android 17 announcement][rise-android17], [The Register on Alibaba][reg-alibaba].

## Comparison

| Board | Chip | Android | Mainline Linux | Secure-boot guide |
|---|---|---|---|---|
| [SpacemiT K3 Pico-ITX](#spacemit-k3-pico-itx) | SpacemiT K3 (RISC-V) | 17, developer release (RISE) | Board; GPU binding only | ⚠ Not found |
| [Alibaba A210 EVB](#alibaba-a210-evb) | A210 (RISC-V) | 17, developer release (RISE) | Not found | ⚠ Not found |
| [Banana Pi BPI-F3, MusePi Pro](#older-risc-v-ports) | SpacemiT K1 (RISC-V) | ⚠ 16 (BayLibre) | Boards; GPU binding | Not checked |
| [Lichee Pi 4A, BeagleV Ahead](#older-risc-v-ports) | T-Head TH1520 (RISC-V) | AOSP main, version not stated | Boards; GPU binding | Not checked |
| [NXP i.MX 95 EVK, FRDM-IMX95](#nxp-imx-8m-plus-and-imx-95) | i.MX 95 | 17, kernel 6.18 (NXP) | Boards and GPU | Public |
| [NXP i.MX 8M Plus EVK](#nxp-imx-8m-plus-and-imx-95) | i.MX 8M Plus | 17, kernel 6.18 (NXP) | Board and GPU | Public |
| [BeaglePlay](#beagleplay-and-ti-am62x) | TI AM625 | 16, kernel 6.12 (TI) | Board and GPU | Public; ⚠ tool access |
| [Raspberry Pi 5, CM5](#raspberry-pi-5-and-compute-module-5) | BCM2712 | 17, community build | Pi 5 and GPU | Public, with a tool |
| [Radxa Rock 5B](#rockchip-rk3588-boards) | RK3588 | 12 (Radxa) | Board and GPU | Vendor guide; closed tool |
| [MediaTek Genio EVKs](#mediatek-genio-boards) | Genio 510, 700, 1200 | 16 on a 14 vendor layer, kernel 5.15 | Boards and GPU | Not checked |
| [Khadas VIM3](#aosp-reference-boards) | Amlogic A311D | 16, kernel 6.12 | Board and GPU | Not checked |
| [Qualcomm QCS6490 boards](#qualcomm-qcs6490-boards) | QCS6490 | 12 to ⚠ 15 | Boards and GPU | Licensed users only |

How to read the columns:

- **Android:** the newest Android version available for the board, and who made it.
- **Mainline Linux:** whether the board is described in the mainline Linux kernel (Linux 7.4-rc3 on 2026-11-21), and whether its graphics chip (GPU) has an open driver there.
  "GPU binding only" means the kernel knows the graphics chip, but the chip's description doesn't switch it on yet.
- **Secure-boot guide:** whether instructions for turning on secure boot are public.

None of these boards has a mobile-network modem.

Sources: the sections below.

## RISC-V boards

### Android on RISC-V

Where Android on RISC-V stands, from Google and from others.

- **Google's position:**
  - In 2024 Google removed RISC-V support from its Android common kernel and GKI.
    Google said Android would keep supporting RISC-V, but wasn't ready to provide a single supported image for all vendors.
  - Google's `android-riscv64` project last reported its status for the second quarter of 2025: Android boots to the home screen in Cuttlefish virtual devices.
    It says the NDK's ABI for RISC-V is not defined yet.
  - ⚠ No later statement from Google, and no RISC-V GKI branch, was found (check C9).
- **RISE's Android 17 release:**
  - RISE, an industry project for RISC-V software, released Android 17 v1.0 on 2026-10-14 for the SpacemiT K3 Pico-ITX and the Alibaba A210 EVB.
    BayLibre did the engineering, as RISE project RP024, with SpacemiT and Alibaba's DAMO Academy as partners.
  - It runs on an Android Mainline kernel, Linux 7.1, in a separate branch for each chip vendor, outside Google's GKI.
  - On both boards, Android boots, Wi-Fi and Bluetooth work, the browser shows a basic web page, and graphics run on Mesa and Imagination's upstream kernel driver.
  - The boot chain is U-Boot and OpenSBI, the RISC-V firmware layer under the kernel.
  - It is not free of closed parts: the K3 can use an existing vendor firmware image for its embedded controller, and the A210 keeps a vendor first-stage loader.
  - RISE calls it "an open source developer release", not a production-ready or certified Android build.
  - ⚠ The release doesn't say whether audio, video, the camera, SELinux enforcing mode or a TEE work (check C9).
  - BayLibre says the code is written to upstreamable quality, for AOSP and the Linux kernel; whether Google accepts it is not known.
  - **Next:** continuous builds and tests in the RISE Board Farm, starting with the A210, and further work on Android's C library (Bionic), runtime (ART) and Chrome.
- **Alibaba's Android 16:** in May 2026 Alibaba's DAMO Academy said it had Android 16 running on its XuanTie 9-series RISC-V chips, using the RVA23 profile, without naming the chip.
  As heise reports it, Alibaba claims compatibility with Android's specifications for verified boot (AVB), GKI, GSI and VINTF; this was not checked.
  It was shared with Alibaba's first strategic customers; no public source was found.

Sources: [Android Authority on RISC-V][aa-riscv], [Google android-riscv64][google-riscv64], [RISE Android 17 announcement][rise-android17], [BayLibre on Android 17][baylibre-android17], [RISE Android manifest][rise-manifest], [RISE Android 17 v1.0 release][rise-release], [The Register on Alibaba][reg-alibaba], [heise on RISC-V][heise-riscv].

### SpacemiT K3 Pico-ITX

The RISC-V board with the newest Android, and the one the Android 17 release was tested on.

- **Chip:** the SpacemiT K3, an RVA23 chip with SpacemiT X100 cores.
- **Android:** RISE's Android 17 release, the board RISE tested on hardware.
  The release's flashing flow over USB was tested on the board; recovery through a second copy of the first-stage loader is unverified.
- **Boot chain:** U-Boot v2026.07 and OpenSBI v1.8, in RISE's branches for the K3.
- **GPU:** a PowerVR BXM-4-64, which Mesa lists as conformant to Vulkan 1.2.
  RISE's build uses its own Mesa branch for Android 17 with Imagination's GPU.
- **Mainline Linux:** a device tree for the board, and the K3's GPU in the PowerVR binding, but no GPU node in the K3's device tree yet.
- ⚠ **Secure boot:** no public documentation found for the K3 (check C9).
- ⚠ **Price and availability:** not found (check C9).

**Verdict:** the newest Android on any RISC-V board, built from open source code and tested on real hardware, with mainline Linux support under way.
It is a developer release on a kernel outside GKI, and its secure boot is undocumented.

Sources: [RISE Android manifest][rise-manifest], [BayLibre on Android 17][baylibre-android17], [Linux: SpacemiT device trees][linux-spacemit], [Linux: PowerVR binding][linux-powervr], [Mesa PowerVR driver][mesa-powervr].

### Alibaba A210 EVB

Alibaba's RISC-V evaluation board, the second board in the Android 17 release.

- **Android:** RISE's Android 17 release.
  RISE's own notes say a full hardware validation report for current A210 boards is still pending, and that page rendering in the browser still needs a test on the board.
- **Verified boot:** the validated configuration has U-Boot's AVB verification turned off; the images still carry AVB metadata.
- **Boot chain:** U-Boot v2024.10 and OpenSBI v1.5, in RISE's branches, after a vendor first-stage loader.
- **Mainline Linux:** no device tree for the A210 was found.
- ⚠ **Availability:** RISE has A210 boards in its Board Farm; whether anyone can buy one was not found (check C9).

**Verdict:** a second Android 17 platform, less tested than the K3, and with verified boot off.

Sources: [RISE Android manifest][rise-manifest], [RISE Android 17 announcement][rise-android17], [Linux device trees][linux-dts].

### Older RISC-V ports

Earlier RISC-V boards with older or less complete Android versions.

- **SpacemiT K1** (Banana Pi BPI-F3, MusePi Pro):
  - ⚠ A BayLibre Android 16 BSP for both boards, found only in a third party's copy of BayLibre's manifests (check C9).
  - Mainline Linux has device trees for both boards, and the K1's PowerVR BXE-2-32 GPU in the binding.
- **T-Head TH1520** (Lichee Pi 4A, BeagleV Ahead):
  - Alibaba's XuanTie team maintains an AOSP port for both boards, built on AOSP's main branch; the Android version is not stated.
  - Mainline Linux has device trees for both, and the TH1520's PowerVR BXM-4-64 GPU in the binding.
- **StarFive JH7110:** an Android 14 port on kernel 6.1, unchanged since 2023.

Sources: [K1 Android manifest copy][k1-manifest], [XuanTie AOSP port][thead-aosp], [StarFive AOSP device][starfive-aosp], [Linux: SpacemiT device trees][linux-spacemit], [Linux: T-Head device trees][linux-thead], [Linux: PowerVR binding][linux-powervr].

## Arm boards, for comparison

Arm boards have older and more complete Android support, so they show what a finished chip maker's release looks like.

### NXP i.MX 8M Plus and i.MX 95

NXP's Android release android-17.0.0_1.0.0, of 2026-11-03, covers the i.MX 8M Mini, Nano, Plus and Quad, the i.MX 8ULP, 8QuadMax and 8QuadXPlus, and the i.MX 95, 952 and 937.

- **Quality:** general availability on the i.MX 8M Plus EVK, the i.MX 95 19x19 EVK and the FRDM-IMX95; the FRDM-IMX937 is in beta.
  An EVK (evaluation kit) is the chip vendor's own reference board.
- **Versions:** based on android-17.0.0_r1, with Linux 6.18.37 merged with the AOSP kernel, a GKI 6.18.32 image from AOSP's `android17-6.18` branch, U-Boot v2026.04 and the Trusty TEE.
- **Source:** NXP delivers most of the release as source code, except some proprietary modules and libraries from third parties.
  The source package is a download that needs an NXP account, and NXP calls it a proprietary source package.
  ⚠ Whether its licence lets the project publish what it builds from it is not known (check C9).
- **GPU in NXP's build:** closed vendor drivers.
  The i.MX 95 has a Mali-G310 with Arm's r56p0 driver; the i.MX 8M Plus has a VeriSilicon (Vivante) GC7000UL with driver 6.4.11.p4.
- **Mainline Linux:** device trees for the i.MX 8M Plus EVK, the i.MX 95 19x19 EVK and the i.MX 95 15x15 FRDM board.
  The i.MX 95's GPU uses the open Panthor driver's binding (`arm,mali-valhall-csf`), and the i.MX 8M Plus's GPU the open Etnaviv driver's (`vivante,gc`).
- **Security features in NXP's build:** verified boot backed by the Trusty TEE, encrypted boot, an OEM-unlock flag kept by software, and A/B updates with secure boot.
- **Known issues:** NXP says the manufacturing-protection features are not ready on the i.MX 95, which affects secure unlock and secure provisioning.
  The RPMB storage behind verified boot must be set up by hand.
- **Secure boot:** HABv4 on the i.MX 8M chips and AHAB on the i.MX 95; these are NXP's two secure-boot mechanisms.
  - NXP's Android security user's guide (UG10158) walks through AHAB secure boot on the i.MX 95.
  - NXP's open-source SPSDK has worked examples of signed AHAB boot for the i.MX 95.
  - U-Boot's documentation has a HABv4 guide for the i.MX 8M family, and covers AHAB on the i.MX 8 and 9 families.
    Its i.MX 93 guide warns that closing the chip is irreversible, and that a wrong key hash leaves a chip that doesn't boot.
  - ⚠ Whether NXP's code-signing tool (CST) download needs an account was not confirmed (check C9).
- **Availability:** NXP's longevity programme lists the i.MX 8M Plus until March 2036 and the i.MX 95 until May 2041.
  This is how long NXP keeps making the chips, not how long it supports the BSP.
- **BSP support:** Variscite, a module maker, estimates about two years of support for each of its own i.MX Android BSP versions.
- **Cost:** not checked (check C9).

**Verdict:** the Arm BSP closest to the current Android release, with public secure-boot guides and the longest published availability.
Its weak points are the closed GPU drivers, the proprietary source package and the i.MX 95's unfinished manufacturing-protection features.

Sources: [NXP RN00201][nxp-rn00201], [NXP Android page][nxp-android], [NXP UG10158][nxp-ug10158], [SPSDK i.MX 95 examples][spsdk-imx95], [NXP product longevity][nxp-longevity], [Linux device trees][linux-dts], [Linux: i.MX 95][linux-imx95], [Linux: i.MX 8M Plus][linux-imx8mp], [Linux: Mali CSF binding][linux-mali-csf], [U-Boot HABv4 guide for i.MX 8M][uboot-hab-8m], [U-Boot AHAB introduction][uboot-ahab-intro], [U-Boot AHAB guide for i.MX 93][uboot-ahab-93], [Variscite Android lifecycle][variscite-lifecycle].

### BeaglePlay and TI AM62x

BeaglePlay is a BeagleBoard.org board on TI's AM625 chip.

- **Open hardware:** certified by OSHWA (certificate US002174, 2023), with the hardware and documentation under CC BY-SA 4.0 and the software under the GPL.
- **Android:** TI's Processor SDK Android 11.00.01, of February 2026, brings Android 16 on Linux 6.12 and U-Boot 2025.01 to TI's AM62x starter kits and to BeaglePlay.
  It refreshes release 11.00.00 of October 2025.
- **Source:** a public `repo` manifest on git.ti.com; TI's build guide shows no account step.
- **Security features in TI's build:** custom AVB keys, KeyMint and Gatekeeper (Android's key-storage and lock-screen services) running in the OP-TEE TEE, and locking and unlocking the device.
  Release 11.00.00 added verified boot with OP-TEE and rollback protection.
- **GPU:** a PowerVR AXE-1-16M.
  TI's Android build uses Imagination's prebuilt, closed driver libraries.
  Mainline Linux binds the GPU to the open PowerVR driver (`ti,am62-gpu`); Mesa develops Vulkan for it, but lists it as not yet conformant.
- **Mainline Linux:** a device tree for BeaglePlay.
- **Secure boot:** AM62x chips come as GP parts, which have no secure boot, or as HS-FS parts.
  HS-FS parts enforce secure boot once the customer's keys are programmed into their fuses with TI's OTP keywriter, which turns them into HS-SE parts.
  - ⚠ Whether BeaglePlay's AM625 is a GP or an HS-FS part was not found (check C9).
  - ⚠ TI's public guide doesn't say how to obtain the keywriter (check C9).
- **Support:** TI's BeaglePlay page says TI offers no ongoing direct design support for the board.
- **Cost:** TI's page lists no price; about a hundred dollars (unsourced, check C9).

**Verdict:** the cheapest Arm board with an official Android build, and certified open hardware.
It is one Android release behind, and its fusing path isn't fully public.

Sources: [OSHWA certificate][oshwa-beagleplay], [TI Android 11.00.01 release notes][ti-android-1101], [TI Android 11.00.00 release notes][ti-android-1100], [TI Android build guide][ti-android-build], [TI AM62x vendor repository][ti-am62x-vendor], [TI keywriter guide][ti-keywriter], [TI BeaglePlay page][ti-beagleplay], [Linux device trees][linux-dts], [Linux: PowerVR binding][linux-powervr], [Mesa PowerVR driver][mesa-powervr].

### Raspberry Pi 5 and Compute Module 5

Raspberry Pi offers no official Android.

- **Community Android:** KonstaKANG's AOSP 17 build for the Pi 5, the Pi 500 and the Compute Module 5 (CM5), dated 2026-10-30, runs Linux 6.18.38 and Mesa 26.2.6.
  - It is based on the author's public Raspberry Vanilla source, and adds features of its own.
  - The GPU (V3D) works with OpenGL and Vulkan, through Mesa.
  - SELinux is permissive, and encrypting user data is not supported.
  - Its added parts are under a non-commercial licence, so the build may not be used commercially.
- **Mainline Linux:** device trees for the Pi 5, with the GPU bound to the open V3D driver (`brcm,2712-v3d`).
  No mainline device tree for the CM5 was found.
- **Secure boot:** documented publicly.
  - The hash of the customer's RSA key is stored in the chip's one-time-programmable (OTP) memory; on the Pi 5's BCM2712 the same key also signs the bootloader in EEPROM.
  - Raspberry Pi's Secure Boot Provisioner automates provisioning, and is open source under the Apache 2.0 licence.
    It needs a provisioning host, a Pi 5 is recommended, and a CM5 also needs an IO board.
  - Some steps are permanent, and losing the private key ends trusted bootloader updates for the device.
- **Availability:** Raspberry Pi says both the Pi 5 and the CM5 stay in production until at least January 2036.
- **Cost:** the bare CM5 module from $67.50, more with an IO board; the Pi 5 with 16 GB at $305.

**Verdict:** a cheap way to practise fusing with public documents and an open tool.
The Android build is one developer's, not production quality, and not for commercial use.

Sources: [KonstaKANG AOSP 17][konstakang-aosp17], [Linux device trees][linux-dts], [Linux: BCM2712][linux-bcm2712], [Raspberry Pi security architecture][rpi-security], [Raspberry Pi Secure Boot Provisioner][rpi-provisioner], [rpi-sb-provisioner source][rpi-provisioner-src], [Raspberry Pi 5][rpi5], [Compute Module 5][rpi-cm5].

### Rockchip RK3588 boards

Popular, powerful Arm boards from several makers, such as Radxa, with good mainline Linux support but old Android versions.

- **Android:** Radxa lists Android 12 for the Rock 5B and 5B+, Android 12 and 14 for the Rock 5C, and Android 14 for its RK3576 boards.
  Other vendors ship Android 14 on kernel 6.1 for the RK3588, for example Advantech.
- **Mainline Linux:** device trees for the Rock 5B and 5B+, with the Mali GPU bound to the open Panthor driver (`rockchip,rk3588-mali`).
  Collabora listed Vulkan 1.4 conformance on the RK3588's GPU among its 2026 work, and says chips with mainline support need no device-specific images.
- **Secure boot:**
  - The chip's boot ROM checks the public key against a hash in its fuses.
  - There is a single root key hash, which can't be revoked or rotated, and only RSA-2048 and RSA-4096 keys.
  - Rockchip published a secure-boot developer guide, but its signing tool is a closed binary.
  - Pengutronix wrote an open replacement, `rkimage`, used with the `rksecure` command of the barebox bootloader.
- **Cost:** hundreds of dollars per board (unsourced).

**Verdict:** strong mainline support, but vendor Android three to five releases behind.
The only open secure-boot tooling comes from a third party.

Sources: [Radxa support matrix][radxa-matrix], [Advantech RK3588 Android 14][advantech-rk3588], [Linux device trees][linux-dts], [Linux: Mali CSF binding][linux-mali-csf], [Collabora on Rockchip][collabora-rockchip], [Pengutronix on RK3588 secure boot][pengutronix-rk3588].

### MediaTek Genio boards

MediaTek's Arm boards for connected devices, whose Android needs agreements with MediaTek.

- **Android from MediaTek:** its IoT Android 16 release covers the Genio 360, 420, 510, 520, 700, 720 and 1200.
  - Kernels: 6.6 on the Genio 360; 6.1 on the 420, 520 and 720; 5.15 on the 510, 700 and 1200.
  - These are "vendor freeze" builds: Android 16 on a vendor layer based on Android 14.
  - MediaTek sends the release to holders of a licence and service agreement, and its developer centre requires a non-disclosure agreement.
- **AOSP from BayLibre:** BayLibre maintains an AOSP SDK for the Genio 350, 510 and 700, with the source on its GitLab.
  - It comes under MediaTek's AIoT software licence agreement.
  - Most modules are under open-source licences, but some repositories may need a non-disclosure agreement.
  - ⚠ Its Android version is not stated on the page (check C9).
- **Mainline Linux:** device trees for the Genio 510, 700 and 1200 EVKs.
  CNX Software reports that the Genio 1200 boards boot mainline without out-of-tree patches, with the Mali-G57 GPU on the open Panfrost driver, and that the 510 and 700 boot recent mainline too.
- **Secure boot:** not checked.

**Verdict:** good mainline progress, but MediaTek's Android needs agreements that may keep it private, and sits on an Android 14 vendor layer.

Sources: [MediaTek IoT Android 16 release notes][genio-android16], [Genio AOSP SDK][genio-aosp], [Linux device trees][linux-dts], [CNX Software on Genio mainline][cnx-genio].

### AOSP reference boards

Boards that Google's Android project names as examples, without supporting them.

- AOSP lists the DragonBoard 845c, the Qualcomm RB5 and the Khadas VIM3 as reference boards, but says they are not supported or tested in AOSP.
  The board makers provide the BSPs.
- **Khadas VIM3:** in December 2025 a post on the Khadas forum published an Android 16 build from BayLibre's `yukawa-android-16` manifest.
  - It runs kernel 6.12 by default, with a mainline kernel as an option.
  - It drives HDMI output only.
  - The VIM3 uses Amlogic's A311D, and mainline Linux has a device tree for it, with its Mali GPU enabled.
- **DragonBoard 845c and RB5:** their current Android status was not checked.

**Verdict:** familiar to AOSP developers, but none comes with a commitment from AOSP, and the VIM3's build is HDMI-only.

Sources: [AOSP reference boards][aosp-boards], [Khadas forum][khadas-vim3-a16], [Linux device trees][linux-dts].

### Qualcomm QCS6490 boards

The QCS6490 belongs to the chip family of the Fairphone 5 and of the Quectel SG560D module, so bring-up on it would carry over to task T3.

- **Boards and Android:**
  - Thundercomm's C6490 Development Kit lists Android 12, at $1,399.
  - Thundercomm's RUBIK Pi 3 is a cheaper board on the same chip.
    ⚠ Its documentation page lists "multiple OS" but no Android version; an Android image for it and its price were not confirmed (check C5).
  - Qualcomm lists Android for the chip; its documented stack for its own RB3 Gen 2 board is Qualcomm Linux, on Linux 6.18.
- ⚠ How Qualcomm or the board makers distribute the Android BSP source, and on what terms, was not found (check C5).
- **Mainline Linux:** device trees for the RB3 Gen 2, the RUBIK Pi 3 and the Fairphone 5.
- **Secure boot:** images are signed with Qualcomm's SecTools; ⚠ its guides are for licensed users only (check C5).

**Verdict:** the closest to a phone, but with closed signing tools and unclear BSP terms.
Worth buying only if check C5 shows the tools and BSP are within reach.

Sources: [Thundercomm C6490 Development Kit][thundercomm-c6490], [Thundercomm RUBIK Pi 3][rubikpi3], [Qualcomm: Android on Dragonwing][qc-android-dw], [Qualcomm kernel docs][qc-kernel], [Linux device trees][linux-dts], [Qualcomm: sign and flash the images][qc-sign], [Quectel SG560D][quectel-sg560d], [CNX Software on the Fairphone 5][cnx-fp5].

## Phones as development devices

Could the project use a phone instead of a board?
A phone has the parts a board lacks: a modem, cameras and a battery.
But the project can't practise fusing on one, because its maker already holds the secure-boot key.

- **Fairphone 5:**
  - An official LineageOS device on LineageOS 24.0, built on the vendor's 5.4 kernel for the QCM6490.
  - At FOSDEM 2026, Luca Weiss of Fairphone presented the phone's mainline Linux status, as his own view.
    Most functions work, among them 3D graphics, Wi-Fi, Bluetooth, GPS, SMS, mobile data and the sensors.
    Audio, the cameras and calls work partly, and NFC doesn't work yet.
  - It shows how a phone with a modem can move from a vendor kernel to mainline.
- **PinePhone:** GloDroid, an AOSP port for single-board computers and phones, has a PinePhone port on Android 15, last released in early 2025.
  Pine64 discontinued the PinePhone Pro in 2025, and ⚠ reportedly halted production of all its Linux devices in 2026 (check C8).

**Verdict:** the Fairphone 5 is the best place to watch a phone move to mainline Linux, but neither phone replaces a board for secure-boot practice.

Sources: [LineageOS wiki data for the FP5][lineage-fp5], [LineageOS build targets][lineage-targets], [Fairphone at FOSDEM 2026][fosdem-fp-mainline], [GloDroid PinePhone port][glodroid-pinephone], [Pine64][pine64-aug2025], [Tom's Hardware][toms-pine64].

## Recommendation for T2

Which boards to buy for task T2, as proposed for the earlier phone plan, to get Android running.
Task T2 now tries candidate boards for the cyber-deck with a Linux distribution, starting from [SHORTLIST.md](SHORTLIST.md); this recommendation stays as background, not a buying plan.
The maintainers decide when buying the boards.
Check C9 confirms the details first.

1. **Getting Android running: the SpacemiT K3 Pico-ITX.**
   - The current Android release on RISC-V, built from open source code, tested on this board, with regular automatic testing planned.
   - Its GPU is one Mesa lists as conformant, and mainline Linux already has the board's device tree.
   - Weak points: a developer release, a kernel outside GKI, no public secure-boot documentation, and an unknown price and availability (check C9).
   - The A210 EVB is the alternative if it can be bought, though it is less tested and runs with verified boot off.
2. **Practising verified boot and secure boot: an NXP i.MX 95 board,** the 19x19 EVK or the FRDM-IMX95.
   - The Arm board on the same Android release, with public secure-boot (AHAB) guides and examples, and on sale until May 2041.
   - It shows what a finished chip maker's software package looks like, as a reference for the RISC-V work.
   - BeaglePlay is a cheaper Arm alternative, one release behind, if check C9 shows its chip can be fused.
3. **Fusing practice:** a second i.MX 95 board, or a Raspberry Pi 5, which Raspberry Pi's own tool fuses over USB without extra hardware.
   As task T2 says, fuse only a board bought for that purpose, with a maintainer's go-ahead for each step.
4. **Before task T3:** a QCS6490 board only if check C5 shows that Qualcomm's signing tools and Android BSP are within reach of a small buyer.

## Sources

Checked on 2026-11-20, except the RISC-V, Linux, LineageOS and GloDroid sources, checked on 2026-11-21.

### RISC-V

- [Android Authority on RISC-V][aa-riscv]: RISC-V removed from Android's common kernel, and Google's statement.
- [Google android-riscv64][google-riscv64]: Google's 2025 status, Cuttlefish only, and the undefined NDK ABI.
- [RISE Android 17 announcement][rise-android17] and [BayLibre on Android 17][baylibre-android17]: the release, its boards, what works, its status and the next steps.
- [RISE Android manifest][rise-manifest] and [RISE Android 17 v1.0 release][rise-release]: versions, closed parts, AVB on the A210, and the validation notes.
- [The Register on Alibaba][reg-alibaba] and [heise on RISC-V][heise-riscv]: Alibaba's Android 16 on XuanTie chips.
- [K1 Android manifest copy][k1-manifest]: ⚠ the K1's Android 16 BSP.
- [XuanTie AOSP port][thead-aosp]: the TH1520 port.
- [StarFive AOSP device][starfive-aosp]: the JH7110 port.

### NXP

- [NXP RN00201][nxp-rn00201]: the Android 17 release, its boards, quality, versions, GPU drivers, security features and known issues.
- [NXP Android page][nxp-android]: the release's packages, the account requirement and the proprietary source package.
- [NXP UG10158][nxp-ug10158]: AHAB secure boot on the i.MX 95.
- [SPSDK i.MX 95 examples][spsdk-imx95]: signed AHAB boot examples.
- [NXP product longevity][nxp-longevity]: the i.MX 8M Plus until March 2036, the i.MX 95 until May 2041.
- [Variscite Android lifecycle][variscite-lifecycle]: estimated support for each of Variscite's BSP versions.
- [U-Boot HABv4 guide for i.MX 8M][uboot-hab-8m], [U-Boot AHAB introduction][uboot-ahab-intro] and [U-Boot AHAB guide for i.MX 93][uboot-ahab-93]: the public guides and their warnings.

### TI and BeaglePlay

- [OSHWA certificate][oshwa-beagleplay]: BeaglePlay certified as open hardware, and its licences.
- [TI Android 11.00.01 release notes][ti-android-1101]: Android 16, Linux 6.12, U-Boot 2025.01, the supported boards and the security features.
- [TI Android 11.00.00 release notes][ti-android-1100]: verified boot with OP-TEE and rollback protection.
- [TI Android build guide][ti-android-build]: the public `repo` manifest.
- [TI AM62x vendor repository][ti-am62x-vendor]: the prebuilt PowerVR libraries in TI's Android 16 build.
- [TI keywriter guide][ti-keywriter]: HS-FS and HS-SE parts, and programming the customer's keys.
- [TI BeaglePlay page][ti-beagleplay]: no price, and no ongoing design support from TI.
- [Mesa PowerVR driver][mesa-powervr]: which PowerVR GPUs are conformant.

### Raspberry Pi

- [KonstaKANG AOSP 17][konstakang-aosp17]: the community Android 17 build, what works, and its licence restriction.
- [Raspberry Pi security architecture][rpi-security]: the customer key's hash in OTP memory and the signed bootloader.
- [Raspberry Pi Secure Boot Provisioner][rpi-provisioner] and [rpi-sb-provisioner source][rpi-provisioner-src]: the tool, its hardware needs, its permanent steps and its licence.
- [Raspberry Pi 5][rpi5] and [Compute Module 5][rpi-cm5]: prices and production until at least January 2036.

### Rockchip, MediaTek and the reference boards

- [Radxa support matrix][radxa-matrix]: Android versions for Radxa's boards.
- [Advantech RK3588 Android 14][advantech-rk3588]: Android 14 on kernel 6.1 for the RK3588.
- [Collabora on Rockchip][collabora-rockchip]: Vulkan conformance work on the RK3588, and mainline images.
- [Pengutronix on RK3588 secure boot][pengutronix-rk3588]: the RK3588's root of trust, the closed signing tool and the open replacement.
- [MediaTek IoT Android 16 release notes][genio-android16]: the Genio chips, kernels, vendor-freeze builds and how the release is distributed.
- [Genio AOSP SDK][genio-aosp]: BayLibre's AOSP SDK and its licence terms.
- [CNX Software on Genio mainline][cnx-genio]: the Genio boards on mainline Linux.
- [AOSP reference boards][aosp-boards]: the three reference boards, not supported or tested in AOSP.
- [Khadas forum][khadas-vim3-a16]: the VIM3's Android 16 build.

### Qualcomm and phones

- [Thundercomm C6490 Development Kit][thundercomm-c6490]: Android 12, and the price.
- [Thundercomm RUBIK Pi 3][rubikpi3]: the board's documentation, with no Android version stated.
- [Qualcomm: Android on Dragonwing][qc-android-dw]: Android listed for the QCS6490.
- [Qualcomm kernel docs][qc-kernel]: Qualcomm Linux on Linux 6.18 for the RB3 Gen 2.
- [Qualcomm: sign and flash the images][qc-sign]: ⚠ SecTools, with guides only for licensed users.
- [Quectel SG560D][quectel-sg560d] and [CNX Software on the Fairphone 5][cnx-fp5]: the QCM6490 and QCS6490 chip family.
- [LineageOS wiki data for the FP5][lineage-fp5] and [LineageOS build targets][lineage-targets]: the Fairphone 5 on LineageOS 24.0 and its kernel.
- [Fairphone at FOSDEM 2026][fosdem-fp-mainline]: the Fairphone 5's mainline Linux status.
- [GloDroid PinePhone port][glodroid-pinephone]: the PinePhone on Android 15.
- [Pine64][pine64-aug2025] and [Tom's Hardware][toms-pine64]: the PinePhone Pro discontinued, and ⚠ the production halt.

### Linux and Android kernels

- [Android common kernels][aosp-common-kernels]: the `android17-6.18` branch.
- [Linux device trees][linux-dts]: the mainline device trees for the boards above (Linux 7.4-rc3).
- [Linux: SpacemiT device trees][linux-spacemit] and [Linux: T-Head device trees][linux-thead]: the RISC-V boards.
- [Linux: i.MX 95][linux-imx95], [Linux: i.MX 8M Plus][linux-imx8mp] and [Linux: BCM2712][linux-bcm2712]: the GPU nodes.
- [Linux: Mali CSF binding][linux-mali-csf] and [Linux: PowerVR binding][linux-powervr]: the GPU bindings.

[aa-riscv]: https://www.androidauthority.com/android-drop-risc-v-kernel-3438330/
[google-riscv64]: https://github.com/google/android-riscv64
[rise-android17]: https://riseproject.dev/2026/10/20/android-17-available-on-rva23-with-rise/
[baylibre-android17]: https://baylibre.com/blog/android-17-comes-to-risc-v/
[rise-manifest]: https://github.com/riseproject-dev/android_manifest
[rise-release]: https://github.com/riseproject-dev/android_manifest/releases/tag/android-17-v1.0
[reg-alibaba]: https://www.theregister.com/systems/2026/05/27/alibaba-gets-android-16-running-on-risc-v/5246710
[heise-riscv]: https://www.heise.de/en/news/Alibaba-optimizes-Android-16-for-RISC-V-chips-11308808.html
[k1-manifest]: https://github.com/fardiahmed/android_manifest
[thead-aosp]: https://github.com/T-Head-Semi/riscv-aosp
[starfive-aosp]: https://github.com/starfive-tech/aosp-device
[nxp-rn00201]: https://www.nxp.com/docs/en/release-note/RN00201.pdf
[nxp-android]: https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/android-os-for-i-mx-applications-processors:IMXANDROID
[nxp-ug10158]: https://www.nxp.com/docs/en/user-guide/UG10158-AUTO.pdf
[spsdk-imx95]: https://github.com/nxp-mcuxpresso/spsdk/tree/master/examples/ahab/imx95
[nxp-longevity]: https://www.nxp.com/products/product-information/product-longevity:PRDCT_LONGEVITY_HM
[variscite-lifecycle]: https://dev.variscite.com/software-and-security/software-lifecycle/android-lifecycle/
[uboot-hab-8m]: https://github.com/u-boot/u-boot/blob/master/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
[uboot-ahab-intro]: https://github.com/u-boot/u-boot/blob/main/doc/imx/ahab/introduction_ahab.rst
[uboot-ahab-93]: https://docs.u-boot.org/en/latest/imx/ahab/guides/mx93_secure_boot.html
[oshwa-beagleplay]: https://certification.oshwa.org/us002174.html
[ti-android-1101]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_01/docs/devices/AM62X/android/Release_Specific_Release_Notes.html
[ti-android-1100]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_00/docs/devices/AM62X/android/Release_Specific_Release_Notes.html
[ti-android-build]: https://software-dl.ti.com/processor-sdk-android/esd/AM62X/11_00_01/docs/android/Overview_Building_the_SDK.html
[ti-am62x-vendor]: https://git.ti.com/cgit/android/vendor-ti-am62x/tree/rgx_um_am62x_64?h=d-android16-release
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
[rubikpi3]: https://www.thundercomm.com/rubik-pi-3/en/
[qc-android-dw]: https://www.qualcomm.com/developer/software/android-on-dragonwing
[qc-kernel]: https://dragonwingdocs.qualcomm.com/System/Kernel
[qc-sign]: https://dragonwingdocs.qualcomm.com/System/Security/sign-and-flash-the-images
[quectel-sg560d]: https://www.quectel.com/product/5g-sg560d-smart-module-series/
[cnx-fp5]: https://www.cnx-software.com/2023/08/31/fairphone-5-smartphone-comes-with-8-years-of-software-updates-with-qualcomm-qcm6490-industrial-iot-processor/
[lineage-fp5]: https://github.com/LineageOS/lineage_wiki/blob/main/_data/devices/FP5.yml
[lineage-targets]: https://github.com/LineageOS/hudson/blob/main/lineage-build-targets
[fosdem-fp-mainline]: https://archive.fosdem.org/2026/events/attachments/ZNAAZX-mainline_kernel_for_fairphones_-_2026_update/slides/266938/fosdem_20_rsemaak.pdf
[glodroid-pinephone]: https://github.com/GloDroidCommunity/pine64-pinephone
[pine64-aug2025]: https://pine64.org/2025/08/14/august_2025_short_update/
[toms-pine64]: https://www.tomshardware.com/pc-components/dram/pine64-halts-all-linux-device-production-until-at-least-mid-2027-as-memory-shortage-bites
[aosp-common-kernels]: https://source.android.com/docs/core/architecture/kernel/android-common
[linux-dts]: https://github.com/torvalds/linux/tree/master/arch/arm64/boot/dts
[linux-spacemit]: https://github.com/torvalds/linux/tree/master/arch/riscv/boot/dts/spacemit
[linux-thead]: https://github.com/torvalds/linux/tree/master/arch/riscv/boot/dts/thead
[linux-imx95]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx95.dtsi
[linux-imx8mp]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8mp.dtsi
[linux-bcm2712]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
[linux-mali-csf]: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/gpu/arm%2Cmali-valhall-csf.yaml
[linux-powervr]: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/gpu/img%2Cpowervr-rogue.yaml
