This is just a little beginning. 

These are my notes about questions and ideas regarding packaging [flohmarkt](https://codeberg.org/flohmarkt/flohmarkt) for yunohost.

You're welcome to take part by opening issues or sending pull requests. You can also reach me on Matrix in [Yunohost Apps development](https://matrix.to/#/%23yunohost-apps:matrix.org) as @chrichri:librem.one .

I also announced this work on the [yunohost forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

## questions

It is recommended to use couchdb from `https://apache.jfrog.io/artifactory/couchdb-deb/` which would need to be included as a repository. It seems that ynh_couchdb provides this.

* Is  it possible to make ynh_couchdb a dependency for my new ynh_flohmarkt?
  * Wrong question: I'll pull in couchdb as a dependency the same way ynh_couchdb does. There'll be a debian package that'll contain a dependency on the couchdb package for ynh_flohmarkt the same as for ynh_couchdb. The last app deinstalled will leave couchdb to `apt autoremove` to clean up.
* It looks like ynh_couchdb should listen externally. I'd prefer to have it listen to 127.0.0.1 only. Is there a way to use the existing packet like this.
  * Whatever ynh_couchdb will configure additionally on the couchdb package should be compatible with whatever ynh_flohmarkt will configure on the couchdb package. Otherwise those two apps should not influence each other.

## ideas

For the time being I'd not like to integrate into ldap. I'd like to let the admin choose whether registration is open to anybody, to yunohost user group (sso) or nobody. _anybody_ and _nobody_ is what flohmarkt already offers.

For 'yunohost user group' I'd like to have the registration urls rewritten by nginx to some `you're not allowed to registered`-page if no user with permission is logged in. Is there an example somewhere or is it even possible at all?

## plan

* use couchdb installation from ynh_couchdb 
  * ~~why shouldn't~~ two apps install the same os dependency: no problem
  * ~~stop the couchdb deb from being de-installed if one of the two apps is de-installed → pseudo deb with depency~~ This is already achived by `ynh_install_extra_app_dependencies` in the install script
  

* email
  * how to make flohmarkt send email per port 25 without login?
  * postfix virtual-user table: allow flohmarkt to send email with 'mail from: <flohmarkt-email>'
    * https://github.com/YunoHost/yunohost/blob/8120ac2b3ff2c32a6a812647712663552cc396a6/src/utils/resources.py#L683
    * define a custom setting `mail_user` and `mail_domain` using ynh_app_setting_set (or .toml?) if necessary

* make first ynh_package
  * nginx just reverse proxy
  * no url filter
  * no userdb integration

* try to get a filter that stops registration
  * in general
  * for users without permission (sso)

* is it possible to have multiple flohmarkt instances in one couchdb
  * database name could contain domain name

* done?
