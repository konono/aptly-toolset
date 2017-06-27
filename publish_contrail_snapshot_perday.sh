date=$1
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="trusty" contrail-3.2.2-{$date} contrail
