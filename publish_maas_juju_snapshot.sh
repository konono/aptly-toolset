date=$1
key=$(gpg --list-keys $2 |grep pub |awk '{print $2}'|egrep -o '/.*'|sed -e 's@/@@g')
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="xenial" ppa_launchpad_net_maas_stable_xenial-${date} maas/stable/ubuntu/
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="xenial" ppa_launchpad_net_maas_proposed_xenial-${date} maas/proposed/ubuntu/
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="xenial" ppa_launchpad_net_juju_stable_xenial-${date} juju/stable/ubuntu/
sudo aptly publish snapshot -architectures="amd64,source" -component=main -gpg-key="$key" -distribution="xenial" ppa_launchpad_net_juju_proposed_xenial-${date} juju/proposed/ubuntu/
