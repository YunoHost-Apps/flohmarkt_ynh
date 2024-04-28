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

#### master and main

The development startet on codeberg on a branch named **main**. That worked all the way until the repository got mirrored to github to be included into the yunohost app catalog. The last change that needed to be done for flohmarkt to appear on the catalog has been to change the name of the branch to **master** for the workflows on github to recognize it for catalog inclusion.

Short: for **historic** reason we use the branch **main** on codeberg and publish the versions for the catalog as **master** on github.

### pushing to github

* make sure the local git and the codeberg git are in sync on their main branch
* tag a new version on codeberg `<major>.<minor>-ynh<X>`, e.g. `0.01-ynh5`. `<major>.<minor>` is the flohmarkt version. `ynhX` is the version of the integration into flohmarkt (this repo).
  * new flohmarkt version: only `manifest.toml` changed to point to the newer source archive
    → change `<major>.<minor>-ynh<X>` according to the new flohmarkt version
  * changes in integration: scripts, conf files or `doc/*` changed
    → increment `<X>` to signal a new version of the yunohost integration
* try to push the local main branch to github which might fail
  * there might for some reason exist an old main branch that had not been deleted after the PR to the github master branch - check carefully and delete the existing main branch
* on github open an PR from the main branch into the master branch
  * the PR can be tested on the CI workflow if a comment containing `!testme` is added to the PR
* the PR will be included after
  * it successfully ran through the CI workflow (results will show up inside the PR)
  * it has been reviewed 

