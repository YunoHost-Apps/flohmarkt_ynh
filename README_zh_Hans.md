<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 的 flohmarkt

[![集成程度](https://dash.yunohost.org/integration/flohmarkt.svg)](https://dash.yunohost.org/appci/app/flohmarkt) ![工作状态](https://ci-apps.yunohost.org/ci/badges/flohmarkt.status.svg) ![维护状态](https://ci-apps.yunohost.org/ci/badges/flohmarkt.maintain.svg)

[![使用 YunoHost 安装 flohmarkt](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=flohmarkt)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 flohmarkt。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

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


**分发版本：** 0.0~ynh4

**演示：** <https://flohmarkt.ween.de/>

## 截图

![flohmarkt 的截图](./doc/screenshots/screenshot.png)

## 免责声明 / 重要信息

## support

For questions about running flohmarkt on yunohost please use the [yunohost support matrix channel](https://yunohost.org/en/chat_rooms#help-and-support-chat-roo) or the [forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

To get help for **flohmarkt** itself please look at its [wiki](https://codeberg.org/flohmarkt/flohmarkt/wiki), [open an issue](https://codeberg.org/flohmarkt/flohmarkt/issues) with your request or join the [IRC channel flohmarkt](https://web.libera.chat/?nick=GithubGuest?#flohmarkt) on [libera.chat](https://libera.chat/).

## bugs, requesting features

Please use the issue tracker at https://codeberg.org/flohmarkt/flohmarkt_ynh/issues

## upstream repository

The yunohost integration of **flohmarkt** is developed by the flohmarkt organization on https://codeberg.org/ .

Please refer to https://codeberg.org/flohmarkt/flohmarkt_ynh/ to take part in development.

More about development of **flohmarkt**s yunohost integration can be found in [DEVELOPMENT.md](DEVELOPMENT.md)

## :red_circle: 负面特征

- **Alpha software**: Early development stage. May contain changing or unstable features, bugs, and security vulnerability.
- **Arbitrary limitations**: Features arbitrary limitations. Please refer to the README.

## 文档与资源

- 官方应用网站： <https://codeberg.org/flohmarkt/flohmarkt>
- 官方用户文档： <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- 官方管理文档： <https://codeberg.org/flohmarkt/flohmarkt/wiki>
- 上游应用代码库： <https://codeberg.org/flohmarkt/flohmarkt>
- YunoHost 商店： <https://apps.yunohost.org/app/flohmarkt>
- 报告 bug： <https://github.com/YunoHost-Apps/flohmarkt_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
或
sudo yunohost app upgrade flohmarkt -u https://github.com/YunoHost-Apps/flohmarkt_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
