aptly publish list -raw|grep $1|grep $2 |awk '{print $2" "$1}'|xargs -I% -t sudo aptly publish drop %
