date=$1
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="xenial" ppa_launchpad_net_maas_stable_xenial-${date} maas/stable/ubuntu${date}/
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="xenial" ppa_launchpad_net_maas_proposed_xenial-${date} maas/proposed/ubuntu${date}/
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="xenial" ppa_launchpad_net_juju_stable_xenial-${date} juju/stable/ubuntu${date}/
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="300F9C58" -distribution="xenial" ppa_launchpad_net_juju_proposed_xenial-${date} juju/proposed/ubuntu${date}/
