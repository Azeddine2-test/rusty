# SA:O compatibility and server startup

## Required server package

This gamemode targets the MTA:SA resource model. San Andreas Online (formerly MTA:SA Neon) is an MTA-derived fork, but the project explicitly distributes a separate dedicated server package. Host this gamemode with the matching SA:O server package; do not assume a standard MTA server is equivalent to the SA:O server runtime.

Official project: https://github.com/Dryxio/san-andreas-online
Windows x64 server package: https://github.com/Dryxio/san-andreas-online/releases/latest/download/MTA-Neon-Server-Windows-x64.zip

## Resource naming

The main gamemode resource is named `Rusty`. Its directory, startup entry in `mtaserver.conf`, and ACL resource object must all use that exact name.

## Validation status

Static repository checks can verify resource paths and configuration references, but cannot prove that a dedicated SA:O server boots or that a client connects. Final validation requires extracting the official SA:O server package, installing the repository resources in its `mods/deathmatch/resources` directory (preserving the resource folder layout), then starting the server and reviewing its console and `logs/scripts.log`. Test client connection and gameplay before production.

Do not change `minclientversion` or anti-cheat settings without confirming the exact SA:O server/client build requirements; those values can block connections or weaken security.
