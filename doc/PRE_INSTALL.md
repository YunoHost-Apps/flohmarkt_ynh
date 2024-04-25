### Exclusive use of couchdb 

flohmarkt expects to install CouchDB from the Apache repository for its own, exclusive use. Installation might break already existing installs of CouchDB.

https://codeberg.org/ChriChri/flohmarkt_ynh/issues/9

### Exclusive use of (sub)domain 

flohmarkt expects to bei installed on its own (sub)domain.

https://codeberg.org/ChriChri/flohmarkt_ynh/issues/4 .

### No integration in yunohost user database"

flohmarkt mainanins its own user database in CouchDB. Users have to register to flohmarkt to get an account. Registration cannot be restricted to yunohost users.

https://codeberg.org/ChriChri/flohmarkt_ynh/issues/5 .

## removing after installation

**Warning:** This will probably break any existing installation of couchdb (there's an couchdb app to install just couchdb and expose its port via nginx reverse-proxy).

## read before test installation

**Another warning:** When installing flohmarkt on a a domain and letting it talk to other ActivityPub instances it will propagate a key associated to your domain. If you remove your flohmarkt from that domain and loose that key other instances might not want to talk to you anymore after you installed flohmarkt again on the same domain generating a new key.

**This is really strictly for testing only - don't install on a production yunohost.**

## Go ahead…

…test, break stuff and open issues on codeberg :) !

# help welcome

You're welcome to take part by opening issues or sending pull requests. You can also reach me on Matrix in [Yunohost Apps development](https://matrix.to/#/%23yunohost-apps:matrix.org) as @chrichri:librem.one .

I also announced this work on the [yunohost forum](https://forum.yunohost.org/t/ynh-flohmarkt-flohmarkt-as-an-app-for-yunohost/28455?u=chrichri).

