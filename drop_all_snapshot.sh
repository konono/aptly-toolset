aptly snapshot list|sed "s/^.*\[\(.*\)\]: Snap.*$/\1/g"|grep -v -e ^$ -e "List" -e "To get"|xargs -I% -t aptly snapshot drop %
