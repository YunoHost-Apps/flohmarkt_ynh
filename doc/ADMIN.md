## support

For questions about running flohmarkt on yunohost please use the [yunohost support matrix channel](https://yunohost.org/en/chat_rooms#help-and-support-chat-roo) or the [forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

To get help for **flohmarkt** itself please look at its [wiki](https://codeberg.org/flohmarkt/flohmarkt/wiki), [open an issue](https://codeberg.org/flohmarkt/flohmarkt/issues) with your request or join the [IRC channel flohmarkt](https://web.libera.chat/?nick=GithubGuest?#flohmarkt) on [libera.chat](https://libera.chat/).

## bugs, requesting features

Please use the issue tracker at https://codeberg.org/flohmarkt/flohmarkt_ynh/issues

## upstream repository

The yunohost integration of **flohmarkt** is developed by the flohmarkt organization on https://codeberg.org/ .

Please refer to https://codeberg.org/flohmarkt/flohmarkt_ynh/ to take part in development.

More about development of **flohmarkt**s yunohost integration can be found in [DEVELOPMENT.md](DEVELOPMENT.md)

## removing this app

When installing flohmarkt on a a domain and letting it talk to other ActivityPub instances it will propagate a key associated to your domain. If you remove your flohmarkt from that domain and loose that key other instances might not want to talk to you anymore after you installed flohmarkt again on the same domain generating a new key.
