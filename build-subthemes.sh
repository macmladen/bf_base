dr adaptivetheme "Adaptive Cat" --description="Adaptive Cat is theme based on Adaptive theme"
dr osub "Omega Oposum" --basetheme=ohm --with-libraries
dr radix "Radix Default" --description="Radix Default is theme based on Radix with default kit"
dr radix "Radix Simplex" --description="Radix Simplex is theme based on Radix with bootswatch SImplex theme" --bootswatch=simplex
dr radix "Radix Spacelab" --description="Radix Spacelab is theme based on Radix with bootswatch Spacelab theme" --bootswatch=spacelab
dr zen "Zen Cat" --description="Zen Cat is theme based on Zen"

cp -a profiles/bf_base/themes/_base/bootstrap/bootstrap_subtheme sites/all/themes/boot_cat
mv sites/all/themes/boot_cat/bootstrap_subtheme.info.starterkit sites/all/themes/boot_cat/boot_cat.info
