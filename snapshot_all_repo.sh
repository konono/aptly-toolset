aptly repo list -raw| xargs -I% -t aptly snapshot create %-`date "+%Y%m%d"` from repo %
