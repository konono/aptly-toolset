#!/bin/bash
LANG=C

i=0
vars=$@

set -- $vars
origin_mirror=$1
origin_version=$2
origin_repo=$3
declare -a array=()
array+=($@)
i=0
ppaflag=$(echo $origin_mirror | grep -o -c ppa)

if [ $ppaflag = "1" ]; then
    mirror_prefix=$(echo $origin_mirror | sed -e 's/^.*\/\/\(.[^/]*\)\/\([a-z]*\)\/\([a-z]*\).*$/\1_\2_\3_/g' | tr "." "_")
    #mirror_prefix=$(echo $origin_mirror | sed -e 's/^.*\/\/\(.[^/]*\)\/\([a-z]*\)\/.*$/\1_\2_/g' | tr "." "_")
else
    mirror_prefix=$(echo $origin_mirror | sed -e 's/^.*\/\/\(.[^/]*\).*$/\1_/g' | tr "." "_")
fi

version=$(echo $origin_version | sed -e 's/^\(.*\)\/\(.*\)$/\1_\2/g')
if [ $ppaflag = "0" ]; then
	check=`echo $version |cut -c ${#version}`
	if [ $check != "_" ]; then
    		version=${version}_
	fi
fi
for e in ${array[@]}; do
    vars=`echo $vars|sed -e "s@$e@@g"`
    let i++
    if [ $i -eq 2 ]; then
        break
    fi
done
repo=`echo $vars|sed -e "s/\ /_/g"`

echo aptly mirror create -architectures=amd64 ${mirror_prefix}${version}${repo} $@
