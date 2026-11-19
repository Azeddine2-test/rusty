# Cartographie des ressources MTA

Date : 2026-11-19

## Inventaire des meta.xml (36)

- Gamemode principal : `[STONE-AGE]/[GAMEMODE]/Rusty`
- Connexion / personnage : `[login]/login`, `[login]/cloth_model`
- Plugins : `cameratool`, `guieditor`, `slothbot`, `spawns`
- Addons : `addon_admin_painel`, `addon_agua`, `addon_ajuda`, `addon_anti_relog`, `addon_globalchat`, `addon_hit`, `addon_hud`, `addon_icones_radar`, `addon_radar`, `addon_radiacao`, `addon_radial_effect`, `addon_shader`, `addon_tab`, `addon_veiculo_hud`
- Remplacements véhicules : `alpha`, `ambulancia`, `bobcat`, `caminhao`, `camper`, `family`, `ferrari`, `harley`, `nrg`, `police`
- Remplacements armes / objets / sons / constructions : `[STONE-AGE]/[replaces]/replaces`
- Administration : `[admin]/acpanel`, `[admin]/admin`
- Ressources de map/editor : `[gameplay]/editor_dump`, `[gameplay]/editor_test`

## Dépendances explicites observées dans les meta.xml

- Le gamemode Rusty déclare l'export serveur `addGang`.
- Le plugin `slothbot` expose plusieurs fonctions de création et de contrôle des bots.
- L'addon `addon_tab` expose l'API du scoreboard côté client et serveur.
- La ressource admin expose `getPlayerCountry` et plusieurs fonctions HTTP.
- Le gamemode déclare séparément le chargement client et serveur de `bone_attach/attach_func.lua`, ce qui est probablement intentionnel pour le partage des fonctions.

## Points à vérifier ensuite

- Rechercher les appels `exports.<resource>:<function>()` et les `getResourceFromName` dans le code Lua.
- Vérifier les dépendances entre le gamemode, les addons et les remplacements avant tout déplacement ou fusion de ressources.
- Déterminer si les deux maps `editor_dump` et `editor_test` sont encore utilisées en production. Elles ont des fichiers de map différents : elles ne sont donc pas des doublons exacts.
