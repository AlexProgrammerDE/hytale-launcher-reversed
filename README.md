# Hytale Launcher - Reverse Engineered

This repository contains reverse-engineered Go source code from the official Hytale game launcher.

## Overview

The Hytale launcher was decompiled from its binary using Ghidra with a Go plugin, then converted from the decompiled C representation back to idiomatic Go source code.

## Architecture

The launcher is a **Wails-based desktop application** that uses:
- **itch.io's Wharf** patching system for efficient incremental game updates
- **OAuth** for authentication
- **AES-GCM** encryption for local data storage
- **OS keyring** integration for credential storage

## Package Structure

| Package | Description |
|---------|-------------|
| `account/` | User account & profile management |
| `app/` | Main Wails application |
| `appstate/` | Persistent state management |
| `auth/` | OAuth authentication flow |
| `build/` | Build info, platform detection |
| `buildscan/` | Installation detection |
| `crypto/` | AES-GCM encryption |
| `deletex/` | Safe file deletion |
| `download/` | HTTP downloads with progress |
| `endpoints/` | API URL generation |
| `eventgroup/` | Concurrent event handling |
| `extract/` | Archive extraction (zip/tar) |
| `fork/` | Process forking |
| `helper/` | Utility functions |
| `hytale/` | Game-specific paths and config |
| `ioutil/` | File I/O utilities |
| `keyring/` | OS credential storage |
| `launch/` | Game process launching |
| `legalfiles/` | EULA/ToS handling |
| `logging/` | Logging utilities |
| `net/` | Network connectivity |
| `news/` | News feed handling |
| `notifications/` | System notifications |
| `oauth/` | OAuth token management |
| `pkg/` | Game/Java/Launcher packages |
| `repair/` | Installation repair |
| `selfupdate/` | Launcher auto-update |
| `session/` | Session management |
| `throttle/` | Request rate limiting |
| `update/` | Update orchestration |
| `updater/` | Update checking |
| `verget/` | Version manifest retrieval |

## API Endpoints

The launcher communicates with these endpoints (domain: `hytale.com`):

| Endpoint | URL Pattern |
|----------|-------------|
| Patch Set | `https://account-data.hytale.com/patches/{os}/{arch}/{channel}/{build}` |
| Launcher Data | `https://account-data.hytale.com/launcher-data` |
| Version Manifest | `https://launcher.hytale.com/version/{platform}/{component}.json` |
| News Feed | `https://launcher.hytale.com/launcher-feed/{release}/feed.json` |

## Update Flow

1. Authenticate via OAuth
2. Fetch patchline info from `/launcher-data`
3. Compare current build vs latest build
4. Download incremental patches (Wharf `.pwr` files)
5. Verify signatures (`.sig` files)
6. Apply patches sequentially
7. Validate installation

## Build

Prerequisites:
- Go (see `go.mod`)
- Node.js 20+

Local build:

```bash
make build
```

Platform notes:
- Linux:
  - Debian/Ubuntu (apt):
    ```bash
    sudo apt-get update
    sudo apt-get install -y libgtk-3-dev libwebkit2gtk-4.0-dev libglib2.0-dev build-essential
    ```
  - Fedora/RHEL (dnf):
    ```bash
    sudo dnf install -y gtk3-devel webkit2gtk4.0-devel glib2-devel gcc-c++
    ```
  - Arch (pacman):
    ```bash
    sudo pacman -S --needed gtk3 webkit2gtk glib2 base-devel
    ```
  - openSUSE (zypper):
    ```bash
    sudo zypper install -y gtk3-devel webkit2gtk3-devel glib2-devel gcc-c++
    ```
- macOS:
  - Xcode Command Line Tools:
    ```bash
    xcode-select --install
    ```
  - Homebrew (if you need it):
    ```bash
    brew install go node
    ```
- Windows:
  - Visual Studio Build Tools (C++ workload):
    ```powershell
    choco install -y visualstudio2022buildtools visualstudio2022-workload-vctools
    ```
    ```powershell
    winget install --id Microsoft.VisualStudio.2022.BuildTools -e
    ```
  - Go/Node.js (if needed):
    ```powershell
    choco install -y golang nodejs-lts
    ```
    ```powershell
    winget install --id GoLang.Go -e
    winget install --id OpenJS.NodeJS.LTS -e
    ```

## Disclaimer

This code is provided for educational and research purposes only. All rights to Hytale belong to Hypixel Studios.

## Stats

- **70 Go source files**
- **31 packages**
- **~7,500 lines of code**
