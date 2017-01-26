date=$1

for distribution in `aptly mirror list -raw|xargs -I%  aptly mirror show %|grep Distribution|sed -e "s/^.*: \(.*\)/\1/g"|sort -n|uniq|grep -v -e proposed -e "/"|grep xenial`
do
        if [ $distribution = xenial-security ]; then
                sudo aptly publish snapshot -architectures="amd64,source" -component=,,, -gpg-key="300F9C58" -distribution="$l" security_ubuntu_com_${distribution}_main-${date} security_ubuntu_com_${distribution}_restricted-${date} security_ubuntu_com_${distribution}_universe-${date} security_ubuntu_com_${distribution}_multiverse-${date} ubuntu
        else
        	sudo aptly publish snapshot -architectures="amd64,source" -component=,,, -gpg-key="300F9C58" -distribution="$l" jp_archive_ubuntu_com_${distribution}_main-${date} jp_archive_ubuntu_com_${distribution}_restricted-${date} jp_archive_ubuntu_com_${distribution}_universe-${date} jp_archive_ubuntu_com_${distribution}_multiverse-${date} ubuntu
	fi
done
