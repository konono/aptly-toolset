date=$1
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="trusty-updates-mitaka" ubuntu-cloud_archive_canonical_com_trusty-updates_mitaka_main-${date} ubuntu${date}
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="trusty-proposed-mitaka" ubuntu-cloud_archive_canonical_com_trusty-proposed_mitaka_main-${date} ubuntu${date}
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="xenial-updates-newton" ubuntu-cloud_archive_canonical_com_xenial-updates_newton_main-${date} ubuntu${date}
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="xenial-proposed-newton" ubuntu-cloud_archive_canonical_com_xenial-proposed_newton_main-${date} ubuntu${date}
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="trusty-updates-ocata" ubuntu-cloud_archive_canonical_com_xenial-updates_ocata_main-${date} ubuntu${date}
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="trusty-proposed-ocata" ubuntu-cloud_archive_canonical_com_xenial-proposed_ocata_main-${date} ubuntu${date}
