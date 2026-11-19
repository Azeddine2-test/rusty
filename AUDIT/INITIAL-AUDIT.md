# Audit initial — StoneAge / MTA

Date: 2026-11-19
Branch: audit/cleanup-phase-1

## Scope and safety

- Audit statique du dépôt GitHub, sans exécution du serveur MTA.
- Branche de sauvegarde créée avant nettoyage : `backup/pre-cleanup-2026-11-19`.
- Branche de travail : `audit/cleanup-phase-1`.
- Aucun script de gameplay, fichier de configuration, police, ressource active, modèle DFF/TXD ou fichier de données n'est supprimé dans cette première passe.

## Inventaire

- 1 635 fichiers suivis dans l'arbre Git analysé.
- 36 fichiers `meta.xml` repérés.
- 223 fichiers Lua repérés.
- 184 groupes de fichiers ayant un contenu identique (SHA identique). Ce chiffre ne signifie pas 184 erreurs : les ressources MTA peuvent embarquer volontairement les mêmes polices, drapeaux, sons, textures ou dépendances localement.

## Nettoyage prudent effectué dans cette branche

Suppression des artefacts clairement non chargés par les `meta.xml` concernés ou des fichiers Windows temporaires :

- `[STONE-AGE]/[GAMEMODE]/StoneAge/group_system/groupsystem_client -backup.lua`
- `[STONE-AGE]/[GAMEMODE]/StoneAge/tools/jq_client - Copia.lua`
- `[STONE-AGE]/[GAMEMODE]/[login]/login/images/intro - Copia.png` (copie exacte de `StoneAge/images/dead.png`, et non déclarée par le meta.xml login)
- `[STONE-AGE]/[GAMEMODE]/[plugins]/cameratool/c_linear.lua.old`
- `[STONE-AGE]/[addons]/addon_hit/hitmarker - Copia.png`
- `[STONE-AGE]/[addons]/addon_icones_radar/img/siteM16 - Copia.png`
- Les quatre fichiers `Thumbs.db` trouvés dans les ressources StoneAge / GUI Editor / radar / HUD véhicule.
- `[gameplay]/realdriveby.zip.old`

## Éléments volontairement conservés

- Polices identiques dans plusieurs ressources : chaque ressource peut avoir besoin de son propre fichier local et de sa déclaration `meta.xml`.
- Drapeaux présents dans StoneAge et dans l'administration : ressources indépendantes.
- Fichiers DFF/TXD identiques ou proches : certains modèles peuvent volontairement partager un modèle visuel.
- WAV identiques entre dossiers d'armes : les chemins peuvent être des alias de remplacement distincts.
- Fichiers `.psd` : sources graphiques de travail, conservées.
- Fichiers `.bak` dans les remplacements : sauvegardes de modèles, conservées en attendant de vérifier leur provenance.
- `ComandosTemporarios.lua` : conservé, car il est explicitement chargé par le `meta.xml` principal.

## Étape 1 — Cartographie des ressources

Le dépôt contient 36 `meta.xml`. Le meta principal de StoneAge charge notamment :
- scripts de survie, animaux, inventaire, craft, éditeur, menu et outils ;
- système de groupes actif : `gang_utils.lua`, `gang_server.lua`, `groupsystem.lua`, `groupsystem_client.lua` ;
- des modules historiques de groupes sous `group_system/scripts/` sont commentés dans le meta principal.

La cartographie complète doit encore vérifier les dépendances inter-ressources, les exports, les événements et les fichiers référencés dynamiquement.

## Étape 2 — Doublons et fichiers inutiles

La comparaison SHA a identifié de nombreux contenus identiques. Les groupes d'assets partagés n'ont pas été fusionnés ni supprimés. Une suppression n'est sûre que si le fichier n'est pas déclaré par un meta.xml et qu'aucun chemin n'est construit dynamiquement par les scripts.

## Étapes suivantes

1. Terminer l'inventaire de tous les `meta.xml` et des dépendances entre ressources.
2. Rechercher les références statiques et dynamiques aux candidats restants.
3. Auditer les événements réseau côté serveur et les validations d'autorité.
4. Auditer les flux de sauvegarde / chargement (inventaire, craft, constructions, groupes).
5. Contrôler les performances client (render handlers, timers, DX, éléments et données synchronisées).
6. Exécuter des tests MTA et vérifier les logs avant toute fusion vers `main`.

Aucun changement de code de gameplay n'est inclus dans cette première passe.


## Vérification des déclarations meta.xml

- Les 36 fichiers meta.xml ont été recensés et leurs déclarations locales (scripts, fichiers et configurations) ont été comparées à l'arbre du dépôt.
- Trois familles d'erreurs de casse ont été repérées : `StoneAge/images/itens/Sniper.png` (fichier réel en minuscules), `addon_veiculo_hud/ligado.png` (fichier réel `LIGADO.png`) et 10 références audio dans `[replaces]/replaces/meta.xml` (`Sounds/primary` / `Sounds/pistols`, alors que les dossiers réels sont `Sounds/Primary` / `Sounds/Pistols`). Elles ont été corrigées dans cette branche pour la compatibilité avec les systèmes de fichiers sensibles à la casse.
- `ComandosTemporarios.lua` était bien chargé, mais ne faisait qu'enregistrer un `onClientRender` vide ; il a été retiré du meta et supprimé afin d'éviter un handler de rendu inutile par image.
- `addon_hud/scripts/server.lua` était vide (blob Git vide) et seulement déclaré dans le meta ; sa déclaration et le fichier vide ont été retirés.
- Les dossiers `[gameplay]/editor_dump` et `[gameplay]/editor_test` ont des metas proches mais des cartes différentes ; ils sont conservés.

## Limites restantes

Les chemins déclarés dans les meta.xml sont désormais sans autre référence absente détectée par l'analyse statique, à l'exception des corrections de casse ci-dessus qui sont appliquées dans la branche de nettoyage. Les chemins générés dynamiquement par Lua, les exports consommés par d'autres ressources et les ressources démarrées par configuration doivent encore être audités.


## Cartographie des ressources

La cartographie détaillée des 36 ressources déclarées est dans [RESOURCE-MAP.md](RESOURCE-MAP.md). Elle couvre le gamemode, login/personnage, plugins, addons, remplacements, administration et maps de test.

## Première passe sécurité

Les premiers événements distants du craft/construction, du réarmement, des groupes et de la connexion ont été examinés. Plusieurs handlers acceptent des données envoyées par le client sans contrôle visible de l'appelant via `client` ni validation complète des droits. Les détails, fichiers et fonctions sont consignés dans [SECURITY-FINDINGS.md](SECURITY-FINDINGS.md). Aucun correctif de gameplay n'a encore été appliqué.
