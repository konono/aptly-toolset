date=$1
key=$(gpg --list-keys $2 |grep pub |awk '{print $2}'|egrep -o '/.*'|sed -e 's@/@@g')
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="trusty-updates-mitaka" ubuntu-cloud_archive_canonical_com_trusty-updates_mitaka_main-${date} ubuntu
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="trusty-proposed-mitaka" ubuntu-cloud_archive_canonical_com_trusty-proposed_mitaka_main-${date} ubuntu
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="xenial-updates-newton" ubuntu-cloud_archive_canonical_com_xenial-updates_newton_main-${date} ubuntu
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="xenial-proposed-newton" ubuntu-cloud_archive_canonical_com_xenial-proposed_newton_main-${date} ubuntu
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="trusty-updates-ocata" ubuntu-cloud_archive_canonical_com_xenial-updates_ocata_main-${date} ubuntu
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="trusty-proposed-ocata" ubuntu-cloud_archive_canonical_com_xenial-proposed_ocata_main-${date} ubuntu
