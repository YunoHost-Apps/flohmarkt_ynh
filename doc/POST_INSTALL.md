## finishing setup

To finish your flohmarkt setup you'll need to finish the initialization process at its setup URL.

See below the configuration tab in the 🔧 wrench section to find the setup URL.

In case of problems with the configuration panel you can find the setup URL in flohmarkts logfile in /var/log/__APP__/app.log if you look for entries like this. To get the entry into the logfile you should at least open your flohmarkt web page once at [https://__DOMAIN__/](https://__DOMAIN__/).

```
2024-05-06 16:30:24 Flohmarkt is not initialized yet. Please go to 
2024-05-06 16:30:24                 https://__DOMAIN__/setup/SECRET
2024-05-06 16:30:24                 in order to complete the setup process
```
(SECRET is a random string)
