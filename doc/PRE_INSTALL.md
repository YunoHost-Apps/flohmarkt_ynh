## use of couchdb 

flohmarkt expects to install CouchDB from the Apache repository for its use. Installation of flohmarkt might break already existing installs of CouchDB.

**flohmarkt will probably not install if you're already running an instance of a couchdb**

https://codeberg.org/flohmarkt/flohmarkt_ynh/src/commit/7721103bac61787f31a4b2f2ae695c65d4f26fc9/scripts/install#L9
https://codeberg.org/ChriChri/flohmarkt_ynh/issues/9

## choosing a sender email address

flohmarkt will send email and you'll be asked for an address used as the sender in these emails. yunohost will try to configure your chosen address as an allowed sender, but for the time being **this will only work if the sender address is not in use otherwise** - e.g. as an alias.

This [issue](https://codeberg.org/flohmarkt/flohmarkt_ynh/issues/50) contains information about the problem.

## multiple flohmarkt on the same subdomain

The installation will allow you to **test** this. The feature is not well tested, yet, and installing multiple productive flohmarkts in the same domain might not work on the fediverse.

Feedback is more than welcome!

## No integration in yunohost user database

flohmarkt mainanins its own user database in CouchDB. Users have to register to flohmarkt to get an account. Registration cannot be restricted to yunohost users.

https://codeberg.org/ChriChri/flohmarkt_ynh/issues/5 .

## removing

Removing a flohmarkt instance will **delete all of its data** for the time being. If you remove a flohmarkt **we strongly suggest to make a backup** beforehand. This [issue](https://codeberg.org/flohmarkt/flohmarkt_ynh/issues/29) describes how we'll handle `remove` with and without `--purge` in the future.

**Warning:** This might break any existing installation of couchdb (there's an couchdb app to install just couchdb and expose its port via nginx reverse-proxy and possibly other software installing a couchdb). This could happen if you installed the couchdb app after you installed flohmarkt.

https://codeberg.org/flohmarkt/flohmarkt_ynh/src/commit/7721103bac61787f31a4b2f2ae695c65d4f26fc9/scripts/remove#L44

When installing flohmarkt on a a domain and letting it talk to other ActivityPub instances it will propagate a key associated to your domain. If you remove your flohmarkt from that domain and loose that key other instances might not want to talk to you anymore after you installed flohmarkt again on the same domain generating a new key.

## list of instances

We apreciate a lot if you run an instance of flohmarkt and will publish your [instance on the wiki](https://codeberg.org/flohmarkt/flohmarkt/wiki/flohmarkt-instances) if you [open an issue](https://codeberg.org/flohmarkt/flohmarkt/issues) asking us to do so.

If you're looking for another instance to federate with the list on the wiki is a good starting point also.

# help welcome

You're welcome to take part by opening issues or sending pull requests. You can also reach me on Matrix in [Yunohost Apps development](https://matrix.to/#/%23yunohost-apps:matrix.org) as @chrichri:librem.one .

I also announced this work on the [yunohost forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

Look at [DEVELOPMENT.md](doc/DEVELOPMENT.md) for more information.
