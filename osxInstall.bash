#!/usr/bin/env bash

function die() {
  echo $*
  exit 1
}

if [ $# -ne "1" ]
then
    die "$0: Received $# args... version required"
fi
./installerBuild.bash $* || die "Could not build!!"

VERSION=$1
/Applications/install4j\ 5/bin/install4jc -m macos -r $VERSION ./install/lantern.install4j

name=lantern-$VERSION.dmg
mv install/Lantern.dmg $name
echo "Uploading to http://cdn.getlantern.org/$name..."
aws -putp lantern $name
echo "Uploaded lantern to http://cdn.getlantern.org/$name"
echo "Also available at http://lantern.s3.amazonaws.com/$name"


