# new in 0.0~ynh8

## urlwatch

This version configures the regular execution of `urlwatch` to find differences in flohmarkts user database.

The job is called from /etc/cron.hourly/ every hour.

If `urlwatch` finds a difference in the user database stored in CouchDB for a flohmarkt instance it'll send an email to the administrator.

## new setting "admin_mail"

The email address of the administrator is stored inside a new setting admin_mail. The upgrade will guess a default:

* it'll try to read the email of the flohmarkt admin from couchdb
* if it fails for some reason it'll use 'admin@<your main domain>'

You'll get WARNINGs during the upgrade if the default has been guessed for your settings.

If you do not like the default you can change it from the command line like this:

```sh
yunohost app setting <my flohmarkt app id> admin_mail -v <email to send change notification to>
```

You can find `<my flohmarkt app id>` by executing `yunohost app list` and looking for the blocks containing `name: flohmarkt`. The line `id:` contains the `<my flohmarkt app id>` you're looking for.

Usually this will be `flohmarkt`.
