<div align="center">

# luci-app-jodu52140-status

### Made with Claude as a Personal Fun Project.

[![Version](https://img.shields.io/badge/version-4.0-blue.svg)]()
[![OpenWrt Compatible](https://img.shields.io/badge/OpenWrt-Compatible-success.svg)]()
[![ImmortalWrt Compatible](https://img.shields.io/badge/ImmortalWrt-Compatible-success.svg)]()

A lightweight LuCI web interface for OpenWrt that monitors and controls the **JODU52140** 5G ODU (Outdoor Unit) directly from your router — no need to log into the ODU's own web portal separately.

The router bridges to the ODU over Telnet, pulls live baseband diagnostics, and can push AT commands for cell locking, all from a dashboard inside LuCI.

</div>

---

## Features

- **Native 5G Dashboard:** view all key stats without opening the ODU's own portal
- **Cell control:** lock the modem to a specific **NR-ARFCN / PCI** via `AT` commands, or unlock back to auto — the Unlock button is only enabled when a lock is actually active
- **Neighbor cell scan:** background scan of nearby towers, showing which cell is serving, which is locked, and identifying other-operator cells (Jio / VI / Airtel / BSNL) by MCC-MNC
- **Signal & quality metrics:** RSRP, RSRQ, SINR, BLER, band, bandwidth, modulation, MIMO — for both Primary and Secondary (Carrier Aggregation) cells
- **Device health:** CPU load, memory usage, temperature, uptime
- **Ethernet link status:** WAN port speed, duplex, and link up/down state
- **Traffic counters:** live RX/TX byte totals
- **One-click reboot** of the ODU
- **AT Terminal:** run raw AT commands against the modem from a built-in terminal modal
- **Scheduled reboot** via router cron
- **Configurable Telnet credentials:** ODU IP, username, and password are all set from the Config tab and stored via UCI — no hardcoded credentials in scripts
- **Auto-provisioning:** on first run it telnets into the ODU and installs a small dashboard daemon that exposes stats over HTTP on port 8080

## Prerequisites

- OpenWrt/ImmortalWrt router with the ODU connected and reachable (default `192.168.225.1`)
- Telnet enabled on the ODU (used by the router to provision and control it)

## Installation

```sh
cd /tmp && uclient-fetch -O luci-app-jodu52140-status-4.0-r1.apk https://github.com/anishthevictorious/luci-app-jodu52140-status/releases/download/4.0.r1/luci-app-jodu52140-status-4.0-r1.apk && apk add --allow-untrusted ./luci-app-jodu52140-status-*.apk
```

Clone into your OpenWrt buildroot and build normally:

```sh
git clone https://github.com/anishthevictorious/luci-app-jodu52140-status.git package/luci-app-jodu52140-status
make menuconfig   # enable LuCI -> Applications -> luci-app-jodu52140-status
make package/luci-app-jodu52140-status/compile V=s
```

## Usage & Configuration

Once installed, go to **Status → 5G Dashboard** in LuCI.

On first load, the dashboard connects to the ODU's default IP and provisions the reporting daemon — you'll briefly see an "initializing" state while this happens.

Config lives in `/etc/config/jodu52140` (UCI), and can also be edited directly from the **Settings** tab in the dashboard:


### Cell Locking (PCI/ARFCN)

Enter the NR-ARFCN and PCI of the tower you want to lock to, then apply — the modem will drop and re-lock to that cell. You can also lock directly from a row in the **Neighbor Scan** results. The **Unlock** button only becomes active once a lock is actually saved, and returns the modem to automatic tower selection.

### AT Terminal

Open the terminal modal from the dashboard to send raw AT commands (e.g. `AT+QNWINFO`) directly to the modem and see the response.


> [!CAUTION]
>
> This project is not affiliated with, endorsed by, or authorized by Jio or Qualcomm.
>
> Features such as cell locking, rebooting, and diagnostic AT commands interact directly with the ODU's modem over Telnet. Using AT commands to change cellular connectivity parameters (like PCI/ARFCN locking) is done at your own risk — incorrect values may cause temporary loss of connectivity until reset. The developers are not responsible for connection drops, device misconfigurations, or service interruptions caused by third-party modems or network operators.


