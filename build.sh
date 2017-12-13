# /usr/bin/env bash

ROOTDIR=`pwd`
CONFIGS="DEBUG RELEASE"

for CONFIG in $CONFIGS; do
    BUILDFOLDER=$ROOTDIR/build/$CONFIG
    DISTFOLDER=$ROOTDIR/dist/$CONFIG

    mkdir -p $BUILDFOLDER $DISTFOLDER    

    cd $BUILDFOLDER

    cmake -DCMAKE_BUILD_TYPE=$CONFIG $ROOTDIR || exit 1

    make
    make install
done
