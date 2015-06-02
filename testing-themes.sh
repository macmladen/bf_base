#!/bin/bash

# Testing themes by setting and then downloading resulting html of home page
dr vset theme_default

# Testing Bartik
dr vset theme_default bartik
curl http://mybfbase.loc > bartik.html

# Testing Seven
dr vset theme_default seven
curl http://mybfbase.loc > seven.html

# Testing Stark
dr vset theme_default stark
curl http://mybfbase.loc > stark.html

# Testing Responsive_bartik
dr vset theme_default responsive_bartik
curl http://mybfbase.loc > responsive_bartik.html

# Testing Adaptive_cat
dr vset theme_default adaptive_cat
curl http://mybfbase.loc > adaptive_cat.html

# Testing Boot_cat
dr vset theme_default boot_cat
curl http://mybfbase.loc > boot_cat.html

# Testing Omega_cat
dr vset theme_default omega_cat
curl http://mybfbase.loc > omega_cat.html

# Testing Omega_ohm
dr vset theme_default omega_ohm
curl http://mybfbase.loc > omega_ohm.html

# Testing Radix_default
dr vset theme_default radix_default
curl http://mybfbase.loc > radix_default.html

# Testing Radix_simplex
dr vset theme_default radix_simplex
curl http://mybfbase.loc > radix_simplex.html

# Testing Radix_spacelab
dr vset theme_default radix_spacelab
curl http://mybfbase.loc > radix_spacelab.html

# Testing Zen_cat
dr vset theme_default zen_cat
curl http://mybfbase.loc > zen_cat.html
