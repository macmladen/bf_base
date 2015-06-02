# Build subthemes from base themes
dr adaptivetheme "Adaptive Cat" --description="Adaptive Cat is theme based on Adaptive theme"
dr osub "Omega Ohm" --basetheme=ohm --with-libraries
dr osub "Omega Cat"
dr radix "Radix Default" --description="Radix Default is theme based on Radix with default kit"
dr radix "Radix Simplex" --description="Radix Simplex is theme based on Radix with bootswatch SImplex theme" --bootswatch=simplex
dr radix "Radix Spacelab" --description="Radix Spacelab is theme based on Radix with bootswatch Spacelab theme" --bootswatch=spacelab
dr zen "Zen Cat" --description="Zen Cat is theme based on Zen"
# Bootstrap does not have drush command
cp -a profiles/bf_base/themes/_base/bootstrap/bootstrap_subtheme sites/all/themes/boot_cat
mv sites/all/themes/boot_cat/bootstrap_subtheme.info.starterkit sites/all/themes/boot_cat/boot_cat.info
# Adaptive fails in destination and folder name
mv profiles/bf_base/themes/adaptive-cat sites/all/themes/adaptive_cat

# Install needed gemfiles
bundle install --gemfile=sites/all/themes/radix_default/Gemfile
# Omega libraries are missing
dr make profiles/bf_base/themes/_base/omega/omega/libraries.make --no-core --contrib-destination=profiles/bf_base

# Build css
compass compile -e production --output-style compressed --force sites/all/themes/radix_default/
compass compile -e production --output-style compressed --force sites/all/themes/radix_simplex/
compass compile -e production --output-style compressed --force sites/all/themes/radix_spacelab/
rm -rf .sass-cache
