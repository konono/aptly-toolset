aptly snapshot list -raw |grep xenial|grep -v -e ppa -e cloud_archive|grep $1|tr '\n' ' '|xargs aptly snapshot merge xenial-`date "+%Y%m%d"` 
