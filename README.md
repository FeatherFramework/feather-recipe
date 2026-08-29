# Feather Framework TX Recipe

> This is the official recipe for the Feather Framework

## Features

- Contract-based Core account identity, sessions, RPC, events, providers, policies, and guards
- UUID Character creation, selection, appearance, deletion, spawn, travel, logout, and doctor respawn
- Transactional Inventory with metadata, revisions, equipment, access control, and UUID ownership
- Persistent Weapons equipment, ammunition, condition, repair, and attachments
- Account-based Admin moderation, reports, cases, player notes, inventory inspection, and weapon grants
- Authoritative routing buckets and restart-safe character selection isolation
- Standalone notification, world, PVP, settings, and reusable Toolkit services
- Optional operator-owned GitHub release reporting through Feather Versioner
- Feather Menu and HUD integration

Core, Character, and Admin apply their own versioned database migrations when
the server starts. The recipe bootstraps only Inventory's base catalog tables
and the supported starter items.

The generated startup order loads Core before its providers and consumers,
Routing before Character, PVP before Settings, and Versioner after all checked
framework resources.

## Setup Guide and Requirements

[https://featherframework.net/guide](https://featherframework.net/guide)

## API Documentation and Usage

[https://featherframework.net/api](https://featherframework.net/api)

## Troubleshooting

If you encounter any issues or have questions, post in our [discord](https://discord.gg/zBCPbPJGZw).
You may also open an issue in GitHub.
