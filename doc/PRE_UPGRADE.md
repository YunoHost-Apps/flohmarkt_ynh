# new in 0.6.1~ynh1

## new features

* instance name is shown as page title of browsers (make sure to set it in the "Administration" menu)
* visually reworked item page
* most tabs now feature icons
* visually reworked item tags
* sticky menu
* Search Users in Admin View
* The instance name is now shown in the page title. Before it was just "Flohmarkt" for everyone (see "Take Action")
* Most used tags are now shown as clickable buttons on the front page.
* User settings dialog is now split into tabs "Profile" and "Account". "Profile" is for the public-facing unproblematic stuff and "Account" contains the more dangerous actions like "delete account" and "change email" e.t.c
* Item authors may now change the order of the uploaded images.

## breacking changes
* new couchdb database view in this release: yunohost upgrade will run initialize_couchdb.py automatically for you

# new in 0.2.0~ynh1

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

