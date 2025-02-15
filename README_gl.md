<!--
NOTA: Este README foi creado automáticamente por <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
NON debe editarse manualmente.
-->

# flohmarkt para YunoHost

[![Nivel de integración](https://apps.yunohost.org/badge/integration/flohmarkt)](https://ci-apps.yunohost.org/ci/apps/flohmarkt/)
![Estado de funcionamento](https://apps.yunohost.org/badge/state/flohmarkt)
![Estado de mantemento](https://apps.yunohost.org/badge/maintained/flohmarkt)

[![Instalar flohmarkt con YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=flohmarkt)

*[Le este README en outros idiomas.](./ALL_README.md)*

> *Este paquete permíteche instalar flohmarkt de xeito rápido e doado nun servidor YunoHost.*  
> *Se non usas YunoHost, le a [documentación](https://yunohost.org/install) para saber como instalalo.*

## Vista xeral

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


**Versión proporcionada:** 0.8.0~ynh1

**Demo:** <https://flohmarkt.ween.de/>

## Capturas de pantalla

![Captura de pantalla de flohmarkt](./doc/screenshots/screenshot.png)

## Documentación e recursos

- Web oficial da app: <https://codeberg.org/flohmarkt/flohmarkt>
- Documentación oficial para usuarias: <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- Documentación oficial para admin: <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- Repositorio de orixe do código: <https://codeberg.org/flohmarkt/flohmarkt>
- Tenda YunoHost: <https://apps.yunohost.org/app/flohmarkt>
- Informar dun problema: <https://github.com/YunoHost-Apps/flohmarkt_ynh/issues>

## Info de desenvolvemento

Envía a túa colaboración á [rama `testing`](https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing).

Para probar a rama `testing`, procede deste xeito:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
ou
sudo yunohost app upgrade flohmarkt -u https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
```

**Máis info sobre o empaquetado da app:** <https://yunohost.org/packaging_apps>
