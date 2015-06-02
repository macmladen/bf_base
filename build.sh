#!/bin/sh
# needed for local drush visibility
PATH="/Users/mladen/Sites/drush:$PATH"
# Build script to build BF Base based on OpenAtrium 2.x
# Make sure the correct number of args was passed from the command line
if [ $# -eq 0 ]; then
  echo "Usage $0 [-d] target_build_dir"
  exit 1
fi
DEV_BUILD=0
PANOPOLY_DEV=0
while getopts ":dp" opt; do
  case $opt in
    d) # dev arguments
      DRUSH_OPTS='--working-copy --no-gitinfofile --no-cache'
      DEV_BUILD=1
      ;;
    p) # use panopoly-dev
      PANOPOLY_DEV=1
      ;;
    r) # release arg
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))
TARGET=$1
# Make sure we have a target directory
if [ -z "$TARGET" ]; then
  echo "Usage $0 target_build_dir"
  exit 2
fi
CURDIR=`pwd -P`
ORIG_TARGET=$TARGET
TARGET=$TARGET"__build"
CALLPATH=`dirname "$0"`
ABS_CALLPATH=`cd "$CALLPATH"; pwd -P`

echo '_____________'
echo '| ___ |  ___|'
echo '| |_| | |__| '
echo '| |_| | |    '
echo '|_____|_|    '
echo '   BF base   '
echo '================'

set -e
if [ $DEV_BUILD -eq 1 ]; then
  echo "*** DEVELOPMENT BUILD ***"
fi
echo "Building to build dir: $TARGET"
#-- Verify.make is not available in standard drush
#echo 'Verifying make...'
#drush verify-makefile
# Remove current drupal dir
if [ -e "$TARGET" ]; then
  echo 'Removing old build directory...'
  rm -rf "$TARGET"
fi
# Do the build
if [ $DEV_BUILD -eq 1 ]; then
# Dev version
  #
  # THIS -dev OPTION IS NOT DONE! Just copied from OpenAtrium for future reference
  #
  DRUSH_OPTS='--working-copy --no-gitinfofile --no-cache'
  # first build core
  MAKEFILE='drupal-org-core.make'
  echo "Building Drupal core..."
  drush make --prepare-install $DRUSH_OPTS "$ABS_CALLPATH/$MAKEFILE" "$TARGET"
  # now get the latest profile distro
  # now build the dev version
  cd "$TARGET"
  MAKEFILE='scripts/oa-drush-dev.make'
  if [ $PANOPOLY_DEV -eq 1 ]; then
    MAKEFILE='scripts/oa-drush-panopoly-dev.make'
  fi
  echo "Building the profile -dev version..."
  # Patch to add github remotes instead of drupal.
  drush make --yes --no-core $DRUSH_OPTS "$ABS_CALLPATH/$MAKEFILE" --contrib-destination=profiles/bf_base
  # Remove drupal remotes.
  if [ -e "profiles/bf_base" ]; then
    cd "profiles/bf_base"
    echo "Downloading latest profile..."
    git init .
    git remote add --track 7.x-2.x origin http://git.drupal.org/project/bf_base.git
    git fetch
    git checkout 7.x-2.x
  fi
  cd $CURDIR
else
# Release version
  MAKEFILE='build-bf_base.make'
  DRUSH_OPTS='--no-cache --prepare-install'
  echo 'Running drush make...'
  drush make $DRUSH_OPTS "$ABS_CALLPATH/$MAKEFILE" "$TARGET"
fi
set +e
# check to see if drush make was successful by checking for panopoly_core module
if [ -e "$TARGET/profiles/bf_base/modules/contrib/panopoly/panopoly_core" ]; then
  #
  # This part restores if destination already contained installed sites
  #
  # Restore previous sites folder if build was successful
  if [ -e "$ORIG_TARGET/sites" ]; then
    echo "Restoring sites folder from: $ORIG_TARGET/sites"
    rm -rf "$TARGET/sites"
    mv "$ORIG_TARGET/sites" "$TARGET/sites"
  fi

  echo "Moving files to: $ORIG_TARGET"
  if [ -e "$ORIG_TARGET" ]; then
    rm -rf "$ORIG_TARGET"
  fi
  if [ -e "$ORIG_TARGET" ]; then
    echo "Error removing old files.  Please fix permissions."
    exit 1
  fi
  mv $TARGET $ORIG_TARGET
  DRUPAL=`cd "$ORIG_TARGET"; pwd -P`

  echo "Active site now in: $DRUPAL"

  # Copy libraries from profile into site libraries
  # Modules properly using Library API don't need this, but many modules
  # don't support libraries in the profile (like WYSIWYG)
  echo "Copying library files."
  rsync -r $DRUPAL/profiles/openatrium/libraries/ $DRUPAL/sites/all/libraries/

  if [ ! -e "$DRUPAL/sites/default/settings.php" ]; then
    echo "No settings.php file found"
    echo "Please run the install.php script to install Drupal and Open Atrium"
    exit 1
  fi

  # Clear caches and Run updates
  cd "$DRUPAL"
  echo 'Running updates...'
  drush updb -y;
  # @TODO Figure out why this cc all is needed
  drush cc drush;
  echo 'Reverting all features...'
  drush fra -y;
  echo 'Clearing caches...'
  drush cc all;
  echo 'Build completed successfully!'
else
  echo 'Error in build.'
  exit 2
fi
