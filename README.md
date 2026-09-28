# Andraste OTA host

Public host for Andraste over-the-air updates. The CYD reads `update.json` (the manifest) and pulls the firmware from this repo's Releases. The Andraste **source** lives in a separate private repo.

- `update.json` — `{version, url}` the device compares against its running version.
- Releases — the `firmware.bin` assets the device downloads.
