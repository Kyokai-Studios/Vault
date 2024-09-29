# **Vault**

Ce projet implémente un **système de gestion des comptes joueurs** en Lua, conçu pour être utilisé dans une ressource FiveM. Il permet de gérer plusieurs monnaies (dollars, euros, etc.), avec des fonctionnalités telles que l'ajout, le retrait, et le transfert d'argent entre joueurs.

## **Table des matières**
1. [Fonctionnalités principales](#fonctionnalités-principales)
2. [Installation](#installation)
3. [Utilisation](#utilisation)
4. [Documentation des fonctions](#documentation-des-fonctions)
5. [Exemple de configuration](#exemple-de-configuration)
6. [Contribuer](#contribuer)
7. [Licence](#licence)

---

## **Fonctionnalités principales**

- Gestion de comptes pour chaque joueur via un identifiant unique.
- Prise en charge de plusieurs devises (e.g. Dollar, Euro).
- Ajout, retrait, et transfert d'argent entre joueurs.
- Sauvegarde automatique des données dans un fichier JSON.


## **Installation**

### **1. Prérequis**
- **FiveM**: Ce script est conçu pour être utilisé dans un serveur FiveM.

### **2. Ajout au manifeste**
Dans votre fichier `fxmanifest.lua`, ajoutez les scripts nécessaires :
```lua
server_script '@Vault/src/*.lua'
```

### **3. Configuration**
Copiez et configurez le fichier `Config.lua` selon vos besoins, en définissant les devises et leurs montants initiaux.

### **4. Sauvegarde des données**
Les données des joueurs sont enregistrées dans un fichier JSON (`player_data.json`) dans le répertoire de la ressource.

---

## **Documentation des fonctions**

### **1. Classe `PlayerAccount`**

#### **`PlayerAccount:new(identifier)`**
- **Description**: Crée un nouveau compte joueur avec un solde initial pour chaque devise.
- **Paramètres**:
  - `identifier` : Chaîne de caractères, identifiant unique du joueur.
- **Retour** : Instance de `PlayerAccount`.

#### **`PlayerAccount:newFromData(identifier, savedData)`**
- **Description**: Crée un compte joueur à partir de données sauvegardées.
- **Paramètres** :
  - `identifier` : Chaîne de caractères, identifiant unique du joueur.
  - `savedData` : Table, données sauvegardées du joueur.
- **Retour** : Instance de `PlayerAccount`.

#### **`PlayerAccount:getBalance(currency)`**
- **Description**: Retourne le solde pour une devise spécifique.
- **Paramètres** :
  - `currency` : Chaîne de caractères, la devise à consulter.
- **Retour** : Nombre, solde du joueur pour cette devise.

#### **`PlayerAccount:addMoney(currency, amount)`**
- **Description**: Ajoute de l'argent à une devise spécifique du compte joueur.
- **Paramètres** :
  - `currency` : Chaîne de caractères, la devise dans laquelle ajouter l'argent.
  - `amount` : Nombre, montant à ajouter.

#### **`PlayerAccount:removeMoney(currency, amount)`**
- **Description**: Retire un montant spécifique d'une devise.
- **Paramètres** :
  - `currency` : Chaîne de caractères, la devise à retirer.
  - `amount` : Nombre, montant à retirer.

#### **`PlayerAccount:transferMoney(toPlayer, currency, amount)`**
- **Description**: Transfère de l'argent à un autre joueur.
- **Paramètres** :
  - `toPlayer` : Instance de `PlayerAccount`, le compte joueur destinataire.
  - `currency` : Chaîne de caractères, devise du transfert.
  - `amount` : Nombre, montant du transfert.

### **2. Classe `PlayerManager`**

#### **`PlayerManager:getPlayerAccount(identifier)`**
- **Description**: Retourne le compte joueur associé à un identifiant. Si le compte n'existe pas, il est créé.
- **Paramètres** :
  - `identifier` : Chaîne de caractères, identifiant unique du joueur.
- **Retour** : Instance de `PlayerAccount`.

#### **`PlayerManager:addMoney(identifier, currency, amount)`**
- **Description**: Ajoute un montant à une devise spécifique pour un joueur.
- **Paramètres** :
  - `identifier` : Chaîne de caractères, identifiant unique du joueur.
  - `currency` : Chaîne de caractères, devise dans laquelle ajouter de l'argent.
  - `amount` : Nombre, montant à ajouter.

#### **`PlayerManager:removeMoney(identifier, currency, amount)`**
- **Description**: Retire un montant spécifique d'une devise pour un joueur.
- **Paramètres** :
  - `identifier` : Chaîne de caractères, identifiant unique du joueur.
  - `currency` : Chaîne de caractères, devise à retirer.
  - `amount` : Nombre, montant à retirer.

#### **`PlayerManager:transferMoney(fromIdentifier, toIdentifier, currency, amount)`**
- **Description**: Transfère un montant spécifique d'une devise entre deux joueurs.
- **Paramètres** :
  - `fromIdentifier` : Chaîne de caractères, identifiant du joueur source.
  - `toIdentifier` : Chaîne de caractères, identifiant du joueur destinataire.
  - `currency` : Chaîne de caractères, devise du transfert.
  - `amount` : Nombre, montant du transfert.

---

## **Exemple de configuration**

```lua
Config = {
    Currencies = {
        ["dollar"] = {
            name = "Dollar",
            symbol = "$",
            initialAmount = 1000
        },
        ["euro"] = {
            name = "Euro",
            symbol = "€",
            initialAmount = 500
        }
    },
    DefaultCurrency = "dollar",
    Chat = true -- Active les messages dans le chat pour les transferts
}
```

---

## **Contribuer**

Les contributions sont les bienvenues ! Si vous souhaitez ajouter des fonctionnalités, corriger des bugs ou améliorer la documentation, n'hésitez pas à ouvrir une issue ou une pull request.

---

## **Licence**

Ce projet est sous licence [GNU AGPLv3](https://choosealicense.com/licenses/agpl-3.0/).
```