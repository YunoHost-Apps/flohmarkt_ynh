# new in 0.6.1~ynh2

No new features.

Fixed a bug in the generation of the urlwatch configuration: on yunohosts with mulitple flohmarkt installations the second and any further installation used a wrong url path to access flohmarkts couchdb.

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

## new in flohmarkt 0.10.0

* currencies can now be optionally limited by the admin. if a comma-separated set of currencies is chosen, the currency field of the new-item or edit-item dialogs will show up as a drop-down instead of a free-text field
* reworked item page
* item page now features other items of the same user
* improved input form validation in many contexts
* move tagline into navigation bar in order to make better use of screen space
* use a new version of tobii, the image viewer we use for showing item pictures, thus enhancing tobii's accessibility features
* work on han chinese by @poesty

## new in flohmarkt 0.10.1

* small fixes for 0.10.0
* accessibility refinements
* few bugfixes
* performance improvements for start page

## new in flohmarkt 0.12.1

### General

* More flexible tabs on the main page
* Tabs can now be reordered
* Admins are free to select the default tab for their instance
* About-Text can be shown as a tab.

### Backend

* Support of the nodeinfo protocol to facilitate easier discovery of instances and
* have usage metrics.
* Correct behaviour where the markdown of federated posts would not be shown correctly.
* More reliable backgroundjob-architecture for email-sending

### Frontend

* Avatars of users without avatar image are now displayed with the account name's
* first letter to make them more easily distinguishable at first glance.
* A new button to display the ALT text on item images.
* Printouts of item pages now omits screen elements that are not relevant to the item.
* Opengraph metadata for rendering previews of flohmarkt links
* Back-to-top button
* Performance increase for low-end devices

### Downstream

* Python dependencies have been modified so flohmarkt can be run with python 3.13. Now it can
* be deployed on the recently released debian 13 (codename: trixie).

### Translations

* Portuguese Backend translation
* Bavarian translation (LOL)
* Many many many updates on the existing translations

**And many many many more fixes and tweaks.**

### **IMPORTANT:**

This version features changes to the database layout, so it is required to run your initialize_couchdb.py script if you manage your instance manually (on yunohost the update script will do this for you)

### Thanks to everyone involved in this release:

midzer, grindhold, Stefan Ruppert, Yonggan, ghose, ivangj, lavacat, AntoninDelFabbro, Kepi, Poesty Li, poVoq, Diminoit, EdwardBrok, EvilCartyen, EvilOlaf, FabioL, Fitik, angelangelangel, geoma, idesmi, mondstern, pepijn aaaaand stdevel
