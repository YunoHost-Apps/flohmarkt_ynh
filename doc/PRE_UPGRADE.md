# new in 0.0~ynh9

Starting with this update the venv of flohmarkt will be updated.

After upgrading the clients might **need to clear their browser cache to avoid broken pages**.

## new features

* i18n
  * status of translations: https://translate.codeberg.org/projects/flohmarkt/#languages
  * you're **welcome to help**
* Share button on mobile devices
* Improved image uploader
* Hashtag support
* prominent 'about' section on landing page
* export and import of account data
* a lot of small improvements

# new in 0.0~ynh8

## urlwatch

This version configures the regular execution of `urlwatch` to find differences in flohmarkts user database.

The job is called from /etc/cron.hourly/ every hour.

If `urlwatch` finds a difference in the user database stored in CouchDB for a flohmarkt instance it'll send an email to an email address saved as a new setting "admin_mail".

## new setting "admin_mail"

The upgrade script will guess a default:

* it'll try to read the email of the flohmarkt admin from couchdb
* if it fails for some reason it'll use 'admin@<your main domain>'

You'll get WARNINGs during the upgrade showing you the address being used. Please check the address!

If you do not like the default you can change it on the new config panel you can find in your yunohost admin webgui on the page of the flohmarkt app.

