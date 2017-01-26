sudo aptly snapshot list -raw |grep xenial|grep $1|grep -e ppa -e xenial|grep -v -e canonica -e juju |tr '\n' ' ' |xargs sudo aptly snapshot merge maas-xenial-proposed-`date "+%Y%m%d"`
