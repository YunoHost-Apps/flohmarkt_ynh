<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# flohmarkt pour YunoHost

[![Niveau d’intégration](https://dash.yunohost.org/integration/flohmarkt.svg)](https://dash.yunohost.org/appci/app/flohmarkt) ![Statut du fonctionnement](https://ci-apps.yunohost.org/ci/badges/flohmarkt.status.svg) ![Statut de maintenance](https://ci-apps.yunohost.org/ci/badges/flohmarkt.maintain.svg)

[![Installer flohmarkt avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=flohmarkt)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer flohmarkt rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

## A decentral federated small advertisement platform

flohmarkt provides its own http server that can be used stand-alone to show small ads that registered users may publish. 

Registration works through the server itself and can be switched off (to run a server for e.g. only one person or only the persons that had been registered until that moment).

To register it's necessary to provide an email address to which a confirmation link is send.

Registered users can access a simple form to publish there small ads. The small ads can be looked at by anybody who is able to reach the website.

## Federation

To communicate with someone who published a small ad the server hints to an unregistred user _"To answer this offer please log in or create an account. OR use another fediverse-account"._

The small add visited turns out to be a _note_ in the fediverse. It's url can be opened with your favourite fediverse client at the server you're already registered to. You then can boost the small ad like any other note you read.

Or you can use your account to answer the author of the small ad if - and only if - you mark your note as 'private' aka 'direct'. This way you can contact the person.

It's also possible to follow accounts on flohmarkt servers like any other account in the fediverse to get new small ads published by that account in your timeline.

## Federation between flohmarkts

At time of installation the software asks for the coordinates of the community it should be for and the radius it should be used in.

This is an offer to help make the goods that might be offered travel less far. A flohmarkt can manually federate with other flohmarkts in its range showing all their goods on its page.

This is not ment to be a restriction, but a nudging to build local communities. These would have the advantage that people could trust each other more, because trades face-to-face could be more common.

## More information

Generally the [wiki](https://codeberg.org/flohmarkt/flohmarkt/wiki) is a good source of information.

* [presentation at ChaosCamp 2023](https://media.ccc.de/v/camp2023-57168-flohmarkt#l=eng&t=213)
* [list of known instances on the wiki](https://codeberg.org/flohmarkt/flohmarkt/wiki/flohmarkt-instances)
* [Service compatibility chart](https://codeberg.org/flohmarkt/flohmarkt/wiki/Service-compatibility-chart)


**Version incluse :** 0.0~ynh8

**Démo :** <https://flohmarkt.ween.de/>

## Captures d’écran

![Capture d’écran de flohmarkt](./doc/screenshots/screenshot.png)

## :red_circle: Anti-fonctionnalités

- **Logiciel en version alpha **: Le logiciel est au tout début de son développement. Il pourrait contenir des fonctionnalités changeantes ou instables, des bugs, et des failles de sécurité.
- **Limitations arbitraires **: Contient des limitations arbitraires. Se référer au fichier README.

## Documentations et ressources

- Site officiel de l’app : <https://codeberg.org/flohmarkt/flohmarkt>
- Documentation officielle utilisateur : <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- Documentation officielle de l’admin : <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- Dépôt de code officiel de l’app : <https://codeberg.org/flohmarkt/flohmarkt>
- YunoHost Store : <https://apps.yunohost.org/app/flohmarkt>
- Signaler un bug : <https://github.com/YunoHost-Apps/flohmarkt_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche `testing`](https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing).

Pour essayer la branche `testing`, procédez comme suit :

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
ou
sudo yunohost app upgrade flohmarkt -u https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
```

**Plus d’infos sur le packaging d’applications :** <https://yunohost.org/packaging_apps>
