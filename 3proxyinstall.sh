version=0.9.3
apt-get update && apt-get -y upgrade
apt-get install gcc make git -y
wget --no-check-certificate -O 3proxy-${version}.tar.gz https://github.com/z3APA3A/3proxy/archive/${version}.tar.gz
tar xzf 3proxy-${version}.tar.gz
cd 3proxy-${version}
sed -i '27s/^/#define ANONYMOUS 1\n/' ./src/proxy.h # Определяем анонимность сервера
make -f Makefile.Linux
cd /root/3proxy-${version}/bin
mkdir /etc/3proxy/
mv 3proxy /etc/3proxy/
cd /etc/3proxy/
wget --no-check-certificate https://github.com/EbasH3/3proxy/raw/master/3proxy.cfg
chmod 600 /etc/3proxy/3proxy.cfg
mkdir /var/log/3proxy/
wget --no-check-certificate https://github.com/EbasH3/3proxy/raw/master/.proxyauth
chmod 600 /etc/3proxy/.proxyauth
cd /etc/init.d/
wget --no-check-certificate https://raw.github.com/EbasH3/3proxy/master/3proxy
chmod  +x /etc/init.d/3proxy
update-rc.d 3proxy defaults
sed -i '30s/^/-A ufw-before-input -p icmp --icmp-type echo-request -j DROP\n/' /etc/ufw/before.rules # Определяем анонимность сервера
