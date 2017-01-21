aptly snapshot list -raw |grep trusty|grep -v -e ppa -e cloud_archive|grep $1|tr '\n' ' '|xargs aptly snapshot merge trusty-`date "+%Y%m%d"` 
