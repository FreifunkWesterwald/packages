#!/bin/sh

# At first some definitions:

EXPERIMENTAL_SUFFIX='e' #The suffix which is used for the experimental version number
BETA_SUFFIX='b'         #The suffix which is used for the beta version number
EXPERIMENTAL_BRANCH_NAME=`uci get autoupdater.experimental.name`
BETA_BRANCH_NAME=`uci get autoupdater.beta.name`
STABLE_BRANCH_NAME=`uci get autoupdater.stable.name`
CURRENT_BRANCH=`uci get autoupdater.settings.branch`
GLUON_RELEASE=`cat /lib/gluon/release`


EXPERIMENTAL_SUFFIX_LENGTH=${#EXPERIMENTAL_SUFFIX}
BETA_SUFFIX_LENGTH=${#BETA_SUFFIX}

# Extract the experimental suffix from the gluon release string
EXPERIMENTAL_SUFFIX_INDEX=$((${#GLUON_RELEASE}-$EXPERIMENTAL_SUFFIX_LENGTH))
CURRENT_EXPERIMENTAL_SUFFIX="${GLUON_RELEASE:$EXPERIMENTAL_SUFFIX_INDEX:$EXPERIMENTAL_SUFFIX_LENGTH}"

# Extract the beta suffix from the gluon release string
BETA_SUFFIX_INDEX=$((${#GLUON_RELEASE}-$BETA_SUFFIX_LENGTH))
CURRENT_BETA_SUFFIX="${GLUON_RELEASE:$BETA_SUFFIX_INDEX:$BETA_SUFFIX_LENGTH}"

if [ "$CURRENT_EXPERIMENTAL_SUFFIX" == "$EXPERIMENTAL_SUFFIX" ];
    then
        if [ "$CURRENT_BRANCH" != "$EXPERIMENTAL_BRANCH_NAME" ];
        then
            logger -s -t "gluon-branch-changer" -p 5 "Gluon release is $GLUON_RELEASE, autoupdater branch is $CURRENT_BRANCH, change to $EXPERIMENTAL_BRANCH_NAME" #Write info to syslog
            uci set autoupdater.settings.branch=$EXPERIMENTAL_BRANCH_NAME
        fi
elif [ "$CURRENT_BETA_SUFFIX" == "$BETA_SUFFIX" ];
    then
        if [ "$CURRENT_BRANCH" != "$BETA_BRANCH_NAME" ];
        then
            logger -s -t "gluon-branch-changer" -p 5 "Gluon release is $GLUON_RELEASE, autoupdater branch is $CURRENT_BRANCH, change to $BETA_BRANCH_NAME" #Write info to syslog
            uci set autoupdater.settings.branch=$BETA_BRANCH_NAME
        fi
else
    if [ "$CURRENT_BRANCH" != "$STABLE_BRANCH_NAME" ];
    then
        logger -s -t "gluon-branch-changer" -p 5 "Gluon release is $GLUON_RELEASE, autoupdater branch is $CURRENT_BRANCH, change to $STABLE_BRANCH_NAME" #Write info to syslog
        uci set autoupdater.settings.branch=$STABLE_BRANCH_NAME
    fi
fi
