#!/bin/sh

sudo urpmi.update -a
sudo urpmi createrepo yum-metadata-parser rpm-build

[ ! -d rpm ] && \
	mkdir -p rpm/{RPMS,SRPMS,SPECS,BUILD,TMP,SOURCES}

if [ ! -d repository ]; then
	mkdir -p repository
fi

echo "%_topdir ##PATH##/rpm
%_tmppath ##PATH##/rpm/tmp
%vendor Gandi" | sed -e "s,##PATH##,$HOME,g"> ~/.rpmmacros

echo "buildarchtranslate: i386: i586
buildarchtranslate: i486: i586
buildarchtranslate: i586: i586
buildarchtranslate: i686: i586" > ~/.rpmrc

[ -e gandi-hosting-vm2.spec ] && \
    cp gandi-hosting-vm2.spec ~/rpm/SPECS/
