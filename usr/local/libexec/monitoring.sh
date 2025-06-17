#!/bin/bash
# Architecture
ARCH=$(uname -a)

# CPU
PHYSICAL_CPU=$(lscpu | grep 'Socket(s)' | awk '{print $2}')
VCPU=$(nproc)

# Memory
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PERC=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

# Disk
DISK_USED=$(df -BM --total | grep 'total' | awk '{print $3}' | sed 's/M//g')
DISK_TOTAL=$(df -BG -x 'tmpfs' -x 'devtmpfs' --total | grep 'total' | awk '{print $2}')
DISK_PERC=$(df --total | grep 'total' | awk '{print $5}')

# CPU Load
CPU_LOAD=$(top -bn2 -d 0.5 | grep 'Cpu(s)' | tail -n1 | sed 's/,/ /g' | awk '{print 100 - $8}')

# Last Boot
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')

# LVM Use
LVM_USE=$(lsblk | grep -q 'lvm' && echo "yes" || echo "no")

# TCP Connections
TCP_CONN=$(ss -ta | grep 'ESTAB' | wc -l)

# Users Logged In
USER_LOG=$(who | wc -l)

# Network
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip link | grep 'link/ether' | awk '{print $2}')

# Sudo Commands
SUDO_CMDS=$(journalctl _COMM=sudo -b | grep 'COMMAND' | wc -l)

# Output
echo "   #Architecture: ${ARCH}"
echo "   #CPU physical : ${PHYSICAL_CPU}"
echo "   #vCUP : ${VCPU}"
echo "   #Memory Usage: ${MEM_USED}/${MEM_TOTAL}MB (${MEM_PERC}%)"
echo "   #Disk Usage: ${DISK_USED}/${DISK_TOTAL} (${DISK_PERC})"
echo "   #CPU load: ${CPU_LOAD}%"
echo "   #Last boot: ${LAST_BOOT}"
echo "   #LVM use: ${LVM_USE}"
echo "   #Connections TCP : ${TCP_CONN} ESTABLISHED"
echo "   #User log: ${USER_LOG}"
echo "   #Network: IP ${IP_ADDR} (${MAC_ADDR})"
echo "   #Sudo : ${SUDO_CMDS} cmd"
