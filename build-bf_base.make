api = 2
core = 7.x

; MAKE file for BF Base used by Drupal.org packaging script

; Include the definition for how to build Drupal core directly, including patches:
includes[] = drupal-org-core.make

; Download the BF_base install profile and recursively build all its dependencies:
projects[bf_base][type] = profile
projects[bf_base][download][type] = git
projects[bf_base][download][branch] = "master"
projects[bf_base][download][url] = "https://github.com/macmladen/bf_base.git"