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
    * ~~disable http (without s)~~ this is a general yunohost setting
  * ~~remove script~~
  * backup script
    * export flohmarkt data from couchdb
    * backup yunohost.app/$app
    * check whether app settings are stored by yunohost framework (password, etc.)

### → 0.1 alpha
* ~~disable path selection and mark it that it needs its own domain.~~
* tag 0.1 alpha
* write limitations in README.md (copy from `antifeatures` in manifest.toml)
* fail2ban configuration

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


