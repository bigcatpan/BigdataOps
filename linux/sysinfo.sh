#!/bin/bash
##################################################################################
# File Name: sysinfo.sh
# Version: v1.0
# Author:bigcatpan
# Function: 打印硬件产品信息、Linux操作系统发行版、CPU、线程、缓存、内存、磁盘、网络等系统信息。
##################################################################################
echo -e "---------- os product ----------"
dmidecode |grep "Product Name"| awk '{$1=$1};1'

echo -e "---------- os release ----------"
cat /etc/redhat-release
cat /etc/issue | grep Linux

echo -e "---------- cpu physical ----------"
cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l

echo -e "---------- cpu info ----------"
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq | awk '{$1=$1};1'

echo -e "---------- cpu processor ----------"
cat /proc/cpuinfo | grep "processor" | uniq | wc -l

echo -e "---------- cpu threads ----------"
lscpu | grep "^Thread(s) per core"
lscpu | grep "^Core(s) per socket"
echo "virtual threads:    `nproc`"

echo -e "---------- L1d cache ---------- "
lscpu | grep -i 'L1d 缓存\|L1d cache' | awk '{printf "%-20s\n",$3}'

echo -e "---------- L1i cache ----------"
lscpu | grep -i 'L1i 缓存\|L1i cache' | awk '{printf "%-20s\n",$3}'

echo -e "---------- L2 cache ----------"
lscpu | grep -i 'L2 缓存\|L2 cache' | awk '{printf "%-20s\n",$3}'

echo -e "---------- L3 cahce ----------"
lscpu | grep -i 'L3 缓存\|L3 cache' | awk '{printf "%-20s\n",$3}'

echo -e "---------- os BIT ----------"
getconf LONG_BIT
uname -m

echo -e "---------- os memory ----------"
free -h

echo -e "---------- os disk ----------"
df -h

echo -e "---------- parted ----------"
parted -l | grep /dev

echo -e "---------- os network ----------"
ls /sys/class/net/

echo -e "---------- virtual network ----------"
ls /sys/devices/virtual/net/

echo -e "---------- devices  network ----------"
ls /sys/class/net/ | grep -v "`ls /sys/devices/virtual/net/`"