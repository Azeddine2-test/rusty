# Audit sécurité — premières constatations statiques

Date : 2026-11-19
Périmètre : scripts serveur du gamemode StoneAge.
Statut : constatations à confirmer en test contrôlé. Aucun correctif de gameplay n'est appliqué dans cette passe.

## Critique — création de construction pilotée par le client

Fichier : `[STONE-AGE]/[GAMEMODE]/StoneAge/craft/craft_s.lua`
- L'événement réseau `newObject` est enregistré comme événement distant.
- Le handler reçoit directement du client `model, x, y, z, rx, ry, rz, health, nomeitem, salvavel`.
- Il crée l'objet et sa zone de collision, puis peut l'insérer dans `base_objects`.
- Le handler ne vérifie pas l'identité via la variable serveur `client`, ni une liste blanche de modèles/types, ni la possession des matériaux, ni la distance/position, ni les limites de construction.

Le client appelle cet événement dans `craft_c.lua` autour de la ligne 348. À corriger avec une validation serveur autoritaire, sans faire confiance aux paramètres de création envoyés par le client.

## Critique — modification / destruction d'objets via événements distants

Fichier : `craft/craft_s.lua`
- `mudar_senha_porta` reçoit une zone, un ID et un mot de passe, puis met à jour la base sans vérifier le propriétaire ni les droits sur l'objet.
- `onObjectDamage` accepte l'objet, la santé, l'ID et l'élément destinataire depuis le client, puis met à jour la base.
- `onObjectDestroy` accepte un objet et un ID et peut supprimer l'entrée SQL et détruire l'objet sans vérifier le propriétaire, la distance ou la cohérence entre l'ID et l'objet.
- `onCamaDestroy` et `createBlipCama` sont également des événements distants à vérifier.

Ces handlers doivent identifier l'appelant avec `client`, puis recharger l'objet depuis les données serveur et vérifier propriétaire / droits / proximité avant toute mutation.

## Élevé — équipement d'arme

Fichier : `survivorSystem.lua`, fonction `rearmPlayerWeapon`
- L'événement distant `onPlayerRearmWeapon` reçoit `weaponName` et `slot`.
- Le handler appelle `takeAllWeapons(source)` avant d'avoir validé que l'arme et le slot appartiennent à une liste autorisée.
- La vérification des munitions et des catégories doit être faite avant toute modification d'équipement.

Le client doit seulement demander une action ; le serveur doit choisir l'arme autorisée à partir de l'inventaire sauvegardé du joueur.

## Élevé — événements de groupes

Fichier : `group_system/gang_server.lua`
- Les événements distants `onPlayerJoinGang` et `onPlayerLeaveGang` reçoivent un nom de groupe du client et modifient le compteur de membres sans vérifier que l'appelant a réellement rejoint / quitté ce groupe.
- Plusieurs événements distants doivent être revus pour vérifier l'appelant et son compte avant toute action.

## Moyen à élevé — SQL construit par concaténation

Fichier : `group_system/gang_utils.lua`
- Plusieurs requêtes `executeSQLInsert/Select/Query/Update/Delete` concatènent directement `gangName`, `memberAccount`, `addedBy` ou le JSON des sous-chefs.
- Si ces valeurs peuvent être influencées par un joueur, cela crée un risque d'injection SQL et de corruption des données.
- Migrer vers `dbQuery` / `dbExec` avec paramètres liés, ou valider/échapper strictement les valeurs selon l'API utilisée.

## Élevé — événement de connexion / inscription à vérifier

Fichier : `login.lua`
- `onPlayerDayZLogin` et `onPlayerDayZRegister` sont enregistrés comme événements distants.
- Les fonctions `playerLogin(username, pass, player)` et `playerRegister(username, pass, player)` utilisent le paramètre `player` pour faire apparaître et initialiser un joueur.
- Il faut confirmer qui déclenche ces événements et s'assurer que le joueur fourni correspond toujours à `client`, avec une authentification réussie côté serveur.

## Ordre de correction proposé

1. Sécuriser `newObject`, destruction et modification de constructions.
2. Sécuriser l'authentification et l'initialisation du joueur.
3. Sécuriser le réarmement et les autres événements d'inventaire.
4. Remplacer les requêtes SQL concaténées du système de groupes.
5. Tester chaque flux en jeu et vérifier la persistance des bases / inventaires.

Aucun de ces constats n'a été exploité en jeu ; il s'agit d'une revue de code statique.
