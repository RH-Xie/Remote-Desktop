# <your_domain_name> : domain name get from pubyun, example: xxxx.f3322.net
# <your_update_code> : update code from domain name settings
# replace them in line 13 and remove angle brackets <>
# <your_wan_interface> : probably be 'wan' or 'eth0.2', remove angle brackets <>
# replace it in line 1 and remove angle brackets <>

intf="<your_wan_interface>"
ifconfig $intf | grep "inet addr" | awk  '{print $2}' | awk -F: '{print $2}' > /tmp/ip
myip=$(head -1 /tmp/ip)
echo "current IP: ""$myip"
exec=$(ps | grep /etc/ddnscript.sh | wc -l)
if [ $exec -lt 2 ] ; then
    http_code=$(curl -o /dev/null -s -w %"{http_code}" --basic -u root:<your_update_code> "http://members.3322.net/dyndns/update?myip=$myip&hostname=<your_domain_name>")
else
    http_code=201
fi
if [ "$http_code" -eq 200 ] ; then
    logger "update DDNS successfully"
    echo "$myip" > /tmp/dnsip.txt
else
    echo "update DDNS failed: ""$http_code"
    logger "update DDNS success"
    printf " - DDNS LOG - Update failed with HTTPcode: "
fi

