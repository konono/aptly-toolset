date=$1
key=$(gpg --list-keys $2 |grep pub |awk '{print $2}'|egrep -o '/.*'|sed -e 's@/@@g')
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="trusty" contrail-3.2.2-{$date} contrail
