#!/usr/bin/env bash

# Run from Catalyst app root (e.g. trunk branch of SVN)
dir=`dirname $BASH_SOURCE`;
cd "$dir/..";
pwd

# The schema class is not withing the acaweb app, as it's also used by other apps
./script/acaweb_create.pl model acamodel DBIC::Schema acaschema create=static dbi:mysql:aca '%' ''


cd -
