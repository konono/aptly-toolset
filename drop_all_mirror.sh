aptly mirror list|sed "s/^.*\[\(.*\)\].*$/\1/g"|grep -v -e ^$ -e "List" -e "To get"|xargs -I% -t aptly mirror drop %
