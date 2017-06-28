date=$1
key=$(gpg --list-keys $2 |grep pub |awk '{print $2}'|egrep -o '/.*'|sed -e 's@/@@g')
for distribution in `aptly mirror list -raw|xargs -I%  aptly mirror show %|grep Distribution|sed -e "s/^.*: \(.*\)/\1/g"|sort -n|uniq|grep -v -e proposed -e "/"|grep trusty`
do
        if [ $distribution = trusty-security ]; then
                sudo aptly publish snapshot -architectures="amd64,source" -component=,,, -gpg-key="$key" -distribution="$l" security_ubuntu_com_${distribution}_main-${date} security_ubuntu_com_${distribution}_restricted-${date} security_ubuntu_com_${distribution}_universe-${date} security_ubuntu_com_${distribution}_multiverse-${date} ubuntu
        else
		sudo aptly publish snapshot -architectures="amd64,source" -component=,,, -gpg-key="$key" -distribution="$l" jp_archive_ubuntu_com_${distribution}_main-${date} jp_archive_ubuntu_com_${distribution}_restricted-${date} jp_archive_ubuntu_com_${distribution}_universe-${date} jp_archive_ubuntu_com_${distribution}_multiverse-${date} ubuntu
	fi
done
