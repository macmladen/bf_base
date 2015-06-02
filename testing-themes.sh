#!/bin/bash
PATH=/Users/mladen/Sites/drush/:$PATH
# Testing themes by setting and then downloading resulting html of home page

# Testing Bartik
drush -r ../mybfbase.loc vset theme_default bartik
curl -Ls http://mybfbase.loc > theme_html/bartik.html
read -n 1

# Testing Seven
drush -r ../mybfbase.loc vset theme_default seven
curl -Ls http://mybfbase.loc > theme_html/seven.html
read -n 1

# Testing Stark
drush -r ../mybfbase.loc vset theme_default stark
curl -Ls http://mybfbase.loc > theme_html/stark.html
read -n 1

# Testing Responsive_bartik
drush -r ../mybfbase.loc vset theme_default responsive_bartik
curl -Ls http://mybfbase.loc > theme_html/responsive_bartik.html
read -n 1

# Testing Adaptive_cat
drush -r ../mybfbase.loc vset theme_default adaptive_cat
curl -Ls http://mybfbase.loc > theme_html/adaptive_cat.html
read -n 1

# Testing Boot_cat
drush -r ../mybfbase.loc vset theme_default boot_cat
curl -Ls http://mybfbase.loc > theme_html/boot_cat.html
read -n 1

# Testing Omega_cat
drush -r ../mybfbase.loc vset theme_default omega_cat
curl -Ls http://mybfbase.loc > theme_html/omega_cat.html
read -n 1

# Testing Omega_ohm
drush -r ../mybfbase.loc vset theme_default omega_ohm
curl -Ls http://mybfbase.loc > theme_html/omega_ohm.html
read -n 1

# Testing Radix_default
drush -r ../mybfbase.loc vset theme_default radix_default
curl -Ls http://mybfbase.loc > theme_html/radix_default.html
read -n 1

# Testing Radix_simplex
drush -r ../mybfbase.loc vset theme_default radix_simplex
curl -Ls http://mybfbase.loc > theme_html/radix_simplex.html
read -n 1

# Testing Radix_spacelab
drush -r ../mybfbase.loc vset theme_default radix_spacelab
curl -Ls http://mybfbase.loc > theme_html/radix_spacelab.html
read -n 1

# Testing Zen_cat
drush -r ../mybfbase.loc vset theme_default zen_cat
curl -Ls http://mybfbase.loc > theme_html/zen_cat.html
read -n 1
