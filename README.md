# aptly-toolset

## 使い方
```
repolistに追加したいmirrorレポジトリの情報を書く
./create_add_mirror.sh
./add_mirror.sh
./update_all_mirror.sh
./snapshot_all_mirror.sh
./publish_ubuntu_snapshot.sh YYYYMMDD
```

## aptly 入門

Aptly tips
----

* Ubuntu 16.04のデフォルト/etc/apt/sources.list

```
 cat /etc/apt/sources.list
# 

# deb cdrom:[Ubuntu-Server 16.04.1 LTS _Xenial Xerus_ - Release amd64 (20160719)]/ xenial main restricted

# deb cdrom:[Ubuntu-Server 16.04.1 LTS _Xenial Xerus_ - Release amd64 (20160719)]/ xenial main restricted

# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb http://us.archive.ubuntu.com/ubuntu/ xenial main restricted
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates main restricted
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://us.archive.ubuntu.com/ubuntu/ xenial universe
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial universe
deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates universe
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu 
## team, and may not be under a free licence. Please satisfy yourself as to 
## your rights to use the software. Also, please note that software in 
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://us.archive.ubuntu.com/ubuntu/ xenial multiverse
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial multiverse
deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates multiverse
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb http://us.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src http://us.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu xenial partner
# deb-src http://archive.canonical.com/ubuntu xenial partner

deb http://security.ubuntu.com/ubuntu xenial-security main restricted
# deb-src http://security.ubuntu.com/ubuntu xenial-security main restricted
deb http://security.ubuntu.com/ubuntu xenial-security universe
# deb-src http://security.ubuntu.com/ubuntu xenial-security universe
deb http://security.ubuntu.com/ubuntu xenial-security multiverse
# deb-src http://security.ubuntu.com/ubuntu xenial-security multiverse
```

* Aptlyのインストール

/etc/apt/sources.listの一番下に下記を追記します。

```
vim /etc/apt/sources.list
deb http://repo.aptly.info/ squeeze main

sudo apt-get update
〜〜〜〜〜
       中略
〜〜〜〜〜
W: GPG error: http://repo.aptly.info squeeze InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 9E3E53F19C7DE460
W: The repository 'http://repo.aptly.info squeeze InRelease' is not signed.
N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

上記エラーを解決するためにgpg keyを登録します。
```
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460
Executing: /tmp/tmp.tSjkVi84mo/gpg.1.sh --keyserver
keys.gnupg.net
--recv-keys
9E3E53F19C7DE460
gpg: requesting key 9C7DE460 from hkp server keys.gnupg.net
gpg: key 9C7DE460: public key "Andrey Smirnov <me@smira.ru>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
```

もう一度、apt-get updateをしてみましょう。
```
sudo apt-get update
〜〜〜〜〜
       中略
〜〜〜〜〜
Get:2 http://repo.aptly.info squeeze InRelease [4,887 B]
Fetched 4,887 B in 5s (850 B/s)
Reading package lists... Done
```

aptlyをインストール
```
sudo apt-get install aptly
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  aptly
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 5,033 kB of archives.
After this operation, 0 B of additional disk space will be used.
Get:1 http://repo.aptly.info squeeze/main amd64 aptly amd64 0.9.7 [5,033 kB]
Fetched 5,033 kB in 7s (679 kB/s)
Selecting previously unselected package aptly.
(Reading database ... 126102 files and directories currently installed.)
Preparing to unpack .../archives/aptly_0.9.7_amd64.deb ...
Unpacking aptly (0.9.7) ...
Processing triggers for man-db (2.7.5-1) ...
Setting up aptly (0.9.7) ...
```

* aptlyを使う前にgpg keyをセットアップ

```
コマンドが入っているか確認
gpg --version
gpg (GnuPG) 1.4.20
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: ~/.gnupg
Supported algorithms:
Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2

※入っていなければ下記コマンドでインストール
sudo apt-get install gnupg
```
keyを生成する
```
gpg --gen-key
gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

gpg: directory `/home/ubuntu/.gnupg' created
gpg: new configuration file `/home/ubuntu/.gnupg/gpg.conf' created
gpg: WARNING: options in `/home/ubuntu/.gnupg/gpg.conf' are not yet active during this run
gpg: keyring `/home/ubuntu/.gnupg/secring.gpg' created
gpg: keyring `/home/ubuntu/.gnupg/pubring.gpg' created
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection?
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048)
Requested keysize is 2048 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
Key does not expire at all
Is this correct? (y/N) y

You need a user ID to identify your key; the software constructs the user ID
from the Real Name, Comment and Email Address in this form:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"

Real name: Yuki Yamashita
Email address: kono@kononet.net
Comment: This is test key.
You selected this USER-ID:
    "Yuki Yamashita (This is test key.) <kono@kononet.net>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.

You don't want a passphrase - this is probably a *bad* idea!
I will do it anyway.  You can change your passphrase at any time,
using this program with the option "--edit-key".

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

Not enough random bytes available.  Please do some other work to give
the OS a chance to collect more entropy! (Need 284 more bytes)
+++++
..+++++
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
...............................+++++
.+++++
gpg: /home/ubuntu/.gnupg/trustdb.gpg: trustdb created
gpg: key 0BCF2E36 marked as ultimately trusted
public and secret key created and signed.

gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
pub   2048R/0BCF2E36 2017-01-17
      Key fingerprint = 6CED E699 6396 BAEA 0DE6  AB8D 2331 4ACC 0BCF 2E36
uid                  Yuki Yamashita (This is test key.) <kono@kononet.net>
sub   2048R/DBF07D1C 2017-01-17

もしも、more entropy!!!!と言われて終わらない場合は下記コマンドを別窓で実行
sudo apt-get install rng-tools
sudo rngd -r /dev/urandom

keyが作れたらkill -9 でプロセスを殺しましょう
```

gpg keyが作れたらkeyを鍵サーバを登録しましょう

```
gpg --list-keys
/home/ubuntu/.gnupg/pubring.gpg
-------------------------------
pub   2048R/0BCF2E36 2017-01-17
uid                  Yuki Yamashita (This is test key.) <kono@kononet.net>
sub   2048R/DBF07D1C 2017-01-17

gpg --send-keys --keyserver keyserver.ubuntu.com 0BCF2E36
gpg: sending key 0BCF2E36 to hkp server keyserver.ubuntu.com

これでうまくいかない場合は下記方法を試す
gpg -a --export kono@kononet.net > pub.asc

cat pub.asc
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----END PGP PUBLIC KEY BLOCK-----

catした中身をkeyserver.ubuntu.comでペーストしてsubmmit

```

登録できたか、確認してみましょう
```
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 0BCF2E36
[sudo] password for ubuntu:
Executing: /tmp/tmp.88QzUdy3Dy/gpg.1.sh --keyserver
keys.gnupg.net
--recv-keys
0BCF2E36
gpg: requesting key 0BCF2E36 from hkp server keys.gnupg.net
gpg: key 0BCF2E36: public key "Yuki Yamashita (This is test key.) <kono@kononet.net>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
```

では、aptlyでmirror repositoryを立ててみましょう
今回はmaasを立てるので、maasのlocal repositoryを作りましょう

まずはmaasのレポジトリをaptlyサーバに登録します。
```
sudo add-apt-repository ppa:maas/stable
sudo apt-get update

レポジトリが登録されていることを確認します。
cat /etc/apt/sources.list.d/maas-ubuntu-stable-xenial.list
deb http://ppa.launchpad.net/maas/stable/ubuntu xenial main
# deb-src http://ppa.launchpad.net/maas/stable/ubuntu xenial main
```

aptlyでmirror repositoryを作成する

```
aptly mirror create -architectures=amd64 ppa_launchpad_net_maas_xenial_main http://ppa.launchpad.net/maas/stable/ubuntu xenial main
Config file not found, creating default config at /home/ubuntu/.aptly.conf


Looks like your keyring with trusted keys is empty. You might consider importing some keys.
If you're running Debian or Ubuntu, it's a good idea to import current archive keys by running:

  gpg --no-default-keyring --keyring /usr/share/keyrings/debian-archive-keyring.gpg --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import

(for Ubuntu, use /usr/share/keyrings/ubuntu-archive-keyring.gpg)

Downloading http://ppa.launchpad.net/maas/stable/ubuntu/dists/xenial/InRelease...
gpgv: Signature made Wed 23 Nov 2016 10:32:47 PM JST using RSA key ID 684D4A1C
gpgv: Can't check signature: public key not found

Looks like some keys are missing in your trusted keyring, you may consider importing them from keyserver:

gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 04E7FDC5684D4A1C

Sometimes keys are stored in repository root in file named Release.key, to import such key:

wget -O - https://some.repo/repository/Release.key | gpg --no-default-keyring --keyring trustedkeys.gpg --import

Downloading http://ppa.launchpad.net/maas/stable/ubuntu/dists/xenial/Release...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/dists/xenial/Release.gpg...
gpgv: Signature made Wed 23 Nov 2016 10:32:47 PM JST using RSA key ID 684D4A1C
gpgv: Can't check signature: public key not found

Looks like some keys are missing in your trusted keyring, you may consider importing them from keyserver:

gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 04E7FDC5684D4A1C

Sometimes keys are stored in repository root in file named Release.key, to import such key:

wget -O - https://some.repo/repository/Release.key | gpg --no-default-keyring --keyring trustedkeys.gpg --import
```

鍵がないと言われているので、鍵を追加します。
```
gpg --no-default-keyring --keyring trustedkeys.gpg --keyserver keys.gnupg.net --recv-keys 04E7FDC5684D4A1C
gpg: requesting key 684D4A1C from hkp server keys.gnupg.net
gpg: key 684D4A1C: public key "Launchpad PPA for MAAS" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
```

もう一度実行します。
```
aptly mirror create -architectures=amd64 ppa_launchpad_net_maas_xenial_main http://ppa.launchpad.net/maas/stable/ubuntu xenial main
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/dists/xenial/InRelease...
gpgv: Signature made Wed 23 Nov 2016 10:32:47 PM JST using RSA key ID 684D4A1C
gpgv: Good signature from "Launchpad PPA for MAAS"

Mirror [ppa_launchpad_net_maas_xenial_main]: http://ppa.launchpad.net/maas/stable/ubuntu/ xenial successfully added.
You can run 'aptly mirror update ppa_launchpad_net_maas_xenial_main' to download repository contents.

aptly mirror list
List of mirrors:
 * [ppa_launchpad_net_maas_xenial_main]: http://ppa.launchpad.net/maas/stable/ubuntu/ xenial

To get more information about mirror, run `aptly mirror show <name>`.

aptly mirror show ppa_launchpad_net_maas_xenial_main
Name: ppa_launchpad_net_maas_xenial_main
Archive Root URL: http://ppa.launchpad.net/maas/stable/ubuntu/
Distribution: xenial
Components: main
Architectures: amd64
Download Sources: no
Download .udebs: no
Last update: never

Information from release file:
Acquire-By-Hash: yes
Architectures: amd64 arm64 armhf i386 powerpc ppc64el s390x
Codename: xenial
Components: main
Date: Wed, 23 Nov 2016 13:32:45 UTC
Description:  Ubuntu Xenial 16.04

Label: MAAS Stable (release)
Origin: LP-PPA-maas-stable
Suite: xenial
Version: 16.04
```

mirrorが作れました。
では、mirrorをupdateしましょう

```
aptly mirror update ppa_launchpad_net_maas_xenial_main
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/dists/xenial/InRelease...
gpgv: Signature made Wed 23 Nov 2016 10:32:47 PM JST using RSA key ID 684D4A1C
gpgv: Good signature from "Launchpad PPA for MAAS"
Downloading & parsing package files...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/dists/xenial/main/binary-amd64/Packages.gz...
Building download queue...
Download queue: 12 items (6.62 MiB)
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-cli_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-dhcp_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/python3-maas-provisioningserver_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-rack-controller_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-region-controller_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/python3-django-maas_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/python3-maas-client_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-proxy_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-region-api_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-common_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...
Downloading http://ppa.launchpad.net/maas/stable/ubuntu/pool/main/m/maas/maas-dns_2.1.2+bzr5555-0ubuntu1~16.04.1_all.deb...

Mirror `ppa_launchpad_net_maas_xenial_main` has been successfully updated.
```

aptlyではsnapshotを取得することができます。

```
aptly snapshot create ppa_launchpad_net_maas_xenial_main-20170117 from mirror ppa_launchpad_net_maas_xenial_main

Snapshot ppa_launchpad_net_maas_xenial_main-20170117 successfully created.
You can run 'aptly publish snapshot ppa_launchpad_net_maas_xenial_main-20170117' to publish snapshot as Debian repository.
```

それでは取得したsnapshotを公開してみましょう。
```
aptly publish snapshot -architectures="amd64" -component=main -gpg-key="0BCF2E36" -distribution="xenial" ppa_launchpad_net_maas_xenial_main-20170117 maas/stable/ubuntu
Loading packages...
Generating metadata files and linking package files...
Finalizing metadata files...
Signing file 'Release' with gpg, please enter your passphrase when prompted:
Clearsigning file 'Release' with gpg, please enter your passphrase when prompted:

Snapshot ppa_launchpad_net_maas_xenial_main-20170117 has been successfully published.
Please setup your webserver to serve directory '/home/ubuntu/.aptly/public' with autoindexing.
Now you can add following line to apt sources:
  deb http://your-server/maas/stable/ubuntu/ xenial main
Don't forget to add your GPG key to apt with apt-key.
```

これで$HOME/.aptly ディレクトリに配置されます。
webサーバとして公開するためにnginxを使ってもいいですが、まずは確認するためにaptlyの機能だけで確認してみましょう。

```
aptly serve
Serving published repositories, recommended apt sources list:

# maas/stable/ubuntu/xenial [amd64] publishes {main: [ppa_launchpad_net_maas_xenial_main-20170117]: Snapshot from mirror [ppa_launchpad_net_maas_xenial_main]: http://ppa.launchpad.net/maas/stable/ubuntu/ xenial}
deb http://yuki-sandbox:8080/maas/stable/ubuntu/ xenial main

Starting web server at: :8080 (press Ctrl+C to quit)...
```

これでブラウザから確認できるはずです。

最後にnginxでの設定を行ってみましょう。
```
sudo apt-get install nginx

rootを変更する
cat /etc/nginx/sites-enabled/default
##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration
#
# Generally, you will want to move this file somewhere, and start with a clean
# file but keep this around for reference. Or just disable in sites-enabled.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	# SSL configuration
	#
	# listen 443 ssl default_server;
	# listen [::]:443 ssl default_server;
	#
	# Note: You should disable gzip for SSL traffic.
	# See: https://bugs.debian.org/773332
	#
	# Read up on ssl_ciphers to ensure a secure configuration.
	# See: https://bugs.debian.org/765782
	#
	# Self signed certs generated by the ssl-cert package
	# Don't use them in a production server!
	#
	# include snippets/snakeoil.conf;

	root /var/www/.aptly/public;   ⇦ここ

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;
        autoindex on;
	server_name _;
        gzip on;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	#
	#location ~ \.php$ {
	#	include snippets/fastcgi-php.conf;
	#
	#	# With php7.0-cgi alone:
	#	fastcgi_pass 127.0.0.1:9000;
	#	# With php7.0-fpm:
	#	fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	#}

	# deny access to .htaccess files, if Apache's document root
	# concurs with nginx's one
	#
	#location ~ /\.ht {
	#	deny all;
	#}
}


# Virtual Host configuration for example.com
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.
#
#server {
#	listen 80;
#	listen [::]:80;
#
#	server_name example.com;
#
#	root /var/www/example.com;
#	index index.html;
#
#	location / {
#		try_files $uri $uri/ =404;
#	}
#}

cp -a ~/.aptly/ /var/www/
rm -rf ~/.aptly
ln -s /var/www/.aptly .aptly

sudo systemctl restart nginx 
```

* ローカルリポジトリの作成
```
aptly repo create -architectures=amd64 -distribution="trusty" -component="main" -comment="contrail3.1 repository" contrail-3.1
aptly repo add contrail-3.1 /home/ubuntu/contrails/debs/.*
```

