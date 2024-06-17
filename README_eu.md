<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# flohmarkt YunoHost-erako

[![Integrazio maila](https://dash.yunohost.org/integration/flohmarkt.svg)](https://dash.yunohost.org/appci/app/flohmarkt) ![Funtzionamendu egoera](https://ci-apps.yunohost.org/ci/badges/flohmarkt.status.svg) ![Mantentze egoera](https://ci-apps.yunohost.org/ci/badges/flohmarkt.maintain.svg)

[![Instalatu flohmarkt YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=flohmarkt)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek flohmarkt YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

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


**Paketatutako bertsioa:** 0.0~ynh8

**Demoa:** <https://flohmarkt.ween.de/>

## Pantaila-argazkiak

![flohmarkt(r)en pantaila-argazkia](./doc/screenshots/screenshot.png)

## :red_circle: Ezaugarri zalantzagarriak

- **Alfa softwarea**: Garapenaren hasierako fasean dago. Ezaugarri aldakor edo ezegonkorrak, erroreak eta segurtasun-arazoak izan ditzazke.
- **Muga arbitrarioak**: Muga arbitrarioak ditu. Irakurri README fitxategia.

## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://codeberg.org/flohmarkt/flohmarkt>
- Erabiltzaileen dokumentazio ofiziala: <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- Administratzaileen dokumentazio ofiziala: <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- Jatorrizko aplikazioaren kode-gordailua: <https://codeberg.org/flohmarkt/flohmarkt>
- YunoHost Denda: <https://apps.yunohost.org/app/flohmarkt>
- Eman errore baten berri: <https://github.com/YunoHost-Apps/flohmarkt_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request`a [`testing` abarrera](https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing).

`testing` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
edo
sudo yunohost app upgrade flohmarkt -u https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>
