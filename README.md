<div align="center">


# luci-app-jodu52140-status


[![Version](https://img.shields.io/badge/version-2.0-blue.svg)]()
[![OpenWrt Compatible](https://img.shields.io/badge/OpenWrt-Compatible-success.svg)]()
[![ImmortalWrt Compatible](https://img.shields.io/badge/ImmortalWrt-Compatible-success.svg)]()

A lightweight LuCI web interface for OpenWrt that monitors and controls the **JODU52140** 5G ODU (Outdoor Unit) directly from your router — no need to log into the ODU's own web portal separately.

The router bridges to the ODU over Telnet, pulls live baseband diagnostics, and can push AT commands for cell locking, all from a dashboard inside LuCI.

</div>


## Features

- **Native 5G Dashboard:** view all key stats without opening the ODU's own portal
- **Cell control:** lock the modem to a specific **NR-ARFCN / PCI** via `AT` commands, or unlock back to auto
- **Signal & quality metrics:** RSRP, RSRQ, SINR, BLER, band, bandwidth, modulation, MIMO — for both Primary and Secondary (Carrier Aggregation) cells
- **Device health:** CPU load, memory, temperature, uptime
- **Traffic counters:** live RX/TX byte totals
- **One-click reboot** of the ODU
- **Neighbor cell scan** run in the background, with results polled separately
- **Scheduled reboot** via router cron
- **Auto-provisioning:** on first connect, the router installs a small reporting daemon on the ODU itself so stats can be polled over HTTP

## Prerequisites

- OpenWrt/ImmortalWrt router with the ODU connected and reachable (default `192.168.225.1`)
- Telnet enabled on the ODU (used by the router to provision and control it)

## Installation


```sh
cd /tmp && uclient-fetch -O luci-app-jodu52140-status-2.0-r1.apk https://github.com/anishthevictorious/luci-app-jodu52140-status/releases/download/2.0-r1/luci-app-jodu52140-status-2.0-r1.apk && apk add --allow-untrusted ./luci-app-jodu52140-status-*.apk
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

Config lives in `/etc/config/jodu52140` (UCI):


### Cell Locking (PCI/ARFCN)

Enter the NR-ARFCN and PCI of the tower you want to lock to, then apply — the modem will drop and re-lock to that cell. Clear the fields to return to automatic tower selection.


> [!CAUTION]
> ### Educational & Research Disclaimer
>
> This project is not affiliated with, endorsed by, or authorized by Jio or Qualcomm.
>
> Features such as cell locking, rebooting, and diagnostic AT commands interact directly with the ODU's modem over Telnet. Using AT commands to change cellular connectivity parameters (like PCI/ARFCN locking) is done at your own risk — incorrect values may cause temporary loss of connectivity until reset. The developers are not responsible for connection drops, device misconfigurations, or service interruptions caused by third-party modems or network operators.

