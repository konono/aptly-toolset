aptly repo create -architectures=amd64 -distribution="trusty" -component="main" -comment="contrail3.1 repository" contrail-3.1
aptly repo add contrail-3.1 /home/ubuntu/contrails/debs/.*
