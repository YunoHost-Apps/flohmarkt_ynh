## flohmarkt lives on codeberg

The flohmarkt team decided to use https://codeberg.org/ as its home. As we embrace the yunohost integration of **flohmarkt** we want to keep its development close to the core team in a repository under its organisation on Codeberg.

We acknowledge that this is unusual for an yunohost app and are aware that this decision might lead to problems and additional organizational effort.

But as much as we value yunohost and are willing to accept its decision to live on github we kindly ask everybody to accept and support our decision to organize the flohmarkt project on a different service.

We hope that in the end the proximity between home repository and repository for yunohost integretion will be benefitial. If not there'll always be the option to move the repo completely into the yunohost-apps organization on github.

Your opinion is appreciated on this topic.

## development workflow

**subject to change and discussion - think of this as an RFC**

### development on codeberg

* clone the [repo](https://codeberg.org/flohmarkt/flohmarkt_ynh) on codeberg
* create your working branch
* once done with your changes / additions open a pull request to the main repo
* your request will be reviewed, discussed and probably merged

The codeberg repository is meant to be bleeding edge and we'll try to follow the HEAD of [flohmarkts](https://codeberg.org/flohmarkt/flohmarkt) repository closely.

Once in a while we'll reach the point to tag a new `-ynhX` version for changes of the yunohost integration or we'll want to release a new version of flohmarkt or both.

To do so we'll push the according changes to the [flohmarkt repository at github](https://github.com/YunoHost-Apps/flohmarkt_ynh) to make upgrades available to the yunohost community.

One **pitfall** doing so is that we can't rely on the yunohost CI for testing for our codeberg repository this way. If need'll be and developers would like to use yunohost as their base for active work on flohmarkt we might release another app **flohmarkt-devel_ynh** in future that closely follows the repository we use for development.

### pushing to github

* make sure the local git and the codeberg git are in sync on their main branch
* tag a new version on codeberg `<major>.<minor>-ynh<X>`, e.g. `0.01-ynh5`. `<major>.<minor>` is the flohmarkt version. `ynhX` is the version of the integration into flohmarkt (this repo).
  * new flohmarkt version: only `manifest.toml` changed to point to the newer source archive
    → change `<major>.<minor>-ynh<X>` according to the new flohmarkt version
  * changes in integration: scripts, conf files or `doc/*` changed
    → increment `<X>` to signal a new version of the yunohost integration
* **help needed** make sure the main branch contains the version to publish
* try to push to github and maybe fail:
  * on github the README.md and README_LANG.md files are automatically generated and might have changed
  * check the difference between github and the local git
  * pull the newer versions from github and merge them
* push the update to github
* push the local git to codeberg

#### help wanted

At time of writing the author still is learning about git and didn't know a way to push a branch/tag from their local git repository onto a different branch on a remote repository which would help to
* tag a release version on codeberg
* checkout the version into a local git and
* push that version to github
