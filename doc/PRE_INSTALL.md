## use of couchdb 

flohmarkt expects to install CouchDB from the Apache repository for its use. Installation of flohmarkt might break already existing installs of CouchDB.

**flohmarkt will probably not install if you're already running an instance of a couchdb**

https://codeberg.org/flohmarkt/flohmarkt_ynh/src/commit/7721103bac61787f31a4b2f2ae695c65d4f26fc9/scripts/install#L9
https://codeberg.org/ChriChri/flohmarkt_ynh/issues/9

## multiple flohmarkt on the same subdomain will not work

flohmarkt **needs its own subdomain** to be installed on. Some of the discussion about this can be found here:

https://codeberg.org/flohmarkt/flohmarkt/issues/251
https://codeberg.org/flohmarkt/flohmarkt_ynh/issues/53

## No integration in yunohost user database

flohmarkt mainanins its own user database in CouchDB. Users have to register to flohmarkt to get an account. Registration cannot be restricted to yunohost users.

https://codeberg.org/ChriChri/flohmarkt_ynh/issues/5 .

## removing

When installing flohmarkt on a a domain and letting it talk to other ActivityPub instances it will propagate a key associated to your domain. If you remove your flohmarkt from that domain and loose that key other instances might not want to talk to you anymore after you installed flohmarkt again on the same domain generating a new key.

## list of instances

We apreciate a lot if you run an instance of flohmarkt and will publish your [instance on the wiki](https://codeberg.org/flohmarkt/flohmarkt/wiki/flohmarkt-instances) if you [open an issue](https://codeberg.org/flohmarkt/flohmarkt/issues) asking us to do so.

If you're looking for another instance to federate with the list on the wiki is a good starting point also.

# help welcome

You're welcome to take part by opening issues or sending pull requests. You can also reach me on Matrix in [Yunohost Apps development](https://matrix.to/#/%23yunohost-apps:matrix.org) as @chrichri:librem.one .

I also announced this work on the [yunohost forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

Look at [DEVELOPMENT.md](doc/DEVELOPMENT.md) for more information.
