## status

These are my notes about questions and ideas regarding packaging [flohmarkt](https://codeberg.org/flohmarkt/flohmarkt) for yunohost.

### installs, but only installs

I've only been working on the install script, yet. 'Remove' fails or only partly removes what had been installed.

### remove manually

**Warning:** This will probably break any existing installation of couchdb (there's an couchdb app to install just couchdb and expose its port via nginx reverse-proxy).

To remove the stuff installed by the install script in my testing environment I use `systemctl stop flohmarkt.service; systemctl stop couchdb; yunohost app remove flohmarkt; rm -rf /var/lib/couchdb/; rm -rf /home/yunohost.app/flohmarkt; rm -rf /opt/flohmarkt`.

### Warnings

**Another warning:** When installing flohmarkt on a a domain/path and letting it talk to other ActivityPub instances it will propagate a key associated to your domain. If you remove your flohmarkt from that domain and loose that key other instances might not want to talk to you anymore after you installed flohmarkt again on the same domain/path generating a new key.

**Again:** This might break **couchdb_ynh** if you installed it already. **Don't install if you already use a couchdb in production.**

**This is really strictly for testing only - don't install on a production yunohost.**

### Go ahead…

…test, break stuff and open issues :) !

## help welcome

You're welcome to take part by opening issues or sending pull requests. You can also reach me on Matrix in [Yunohost Apps development](https://matrix.to/#/%23yunohost-apps:matrix.org) as @chrichri:librem.one .

I also announced this work on the [yunohost forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

## roadmap

* ~~use couchdb installation from ynh_couchdb~~: no
  * ~~why shouldn't~~ two apps install the same os dependency: no problem
  * ~~stop the couchdb deb from being de-installed if one of the two apps is de-installed → pseudo deb with depency~~ This is already achived by `ynh_install_extra_app_dependencies` in the install script
  

* email
  * ~~how to make flohmarkt send email per port 25 without login?~~ not: install generates an smpt account for flohmarkt to login with and puts it into flohmarkt.conf
  * ~~postfix virtual-user table: allow flohmarkt to send email with 'mail from: <flohmarkt-email>'~~ works
    * ~~define a custom setting `mail_user` and `mail_domain` using ynh_app_setting_set (or .toml?) if necessary~~ done

* make first ynh_package
  * ~~nginx just reverse proxy~~ done
    * disable http (without s)
  * remove script
  * backup script (export flohmarkt data from couchdb)

### → 0.1 alpha
* disable path selection and mark it that it needs its own domain.
* tag 0.1 alpha
* write limitations in README.md

### → 0.2 beta
* restore script
* upgrade script
* fail2ban config

### later

* couchdb
  * check if already installed
  * if installed by flohmarkt: create couchdb user
  * check if install results in the same configuration as with couchdb_ynh

* try to get a filter that stops registration
  * in general
  * for users without permission (sso)

* is it possible to have multiple flohmarkt instances in one couchdb
  * database name could contain domain name

## ideas

For the time being I'd not like to integrate into ldap. I'd like to let the admin choose whether registration is open to anybody, to yunohost user group (sso) or nobody. _anybody_ and _nobody_ is what flohmarkt already offers.

For 'yunohost user group' I'd like to have the registration urls rewritten by nginx to some `you're not allowed to registered`-page if no user with permission is logged in. Is there an example somewhere or is it even possible at all?


