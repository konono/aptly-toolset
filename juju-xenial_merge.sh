sudo aptly snapshot list -raw |grep xenial|grep $1|grep -e ppa -e xenial|grep -v -e canonica -e maas -e secu|tr '\n' ' ' |xargs sudo aptly snapshot merge juju-xenial-`date "+%Y%m%d"`
