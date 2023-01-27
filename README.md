# Remote Desktop

---

## Intro

<img src="https://s2.loli.net/2022/04/30/NzjwqXL1WsIJAch.jpg" style="zoom:50%;" />

Based on services by [Openwrt](https://openwrt.org/) routers and [pubyun](https://www.pubyun.com/), Windows NT 10.0.

Wrote this when found Openwrt can't update a private ip like 172.19.18.222 to 3322 ddns, while resolving domain names to ips is in fact useful, for what we stay in is just a big "LAN".

This method is tested in campus network(GZHU), but suitable for any DHCP network.

---

## Local

### Windows 10 Server / Enterprise

Skip this step.

### Windows 10 Home

Windows 10 Home doesn't support remote desktop by default, but you can make it available by installing [RDP Wrap](https://github.com/stascorp/rdpwrap).

---

## Router

If you still don't have a dynamic domain by pubyun, go to [pubyun](https://www.pubyun.com/) and get one for free.

### Script

Do the following steps on Openwrt via `ssh` or other tools like Putty.

#### Install curl

```sh
opkg update
opkg install curl
```

#### Setup script

(Assume that you have owned a domain name like `ark1099.f3322.net`)

```sh
cd /etc
vim ddnsscript.sh
```

Copy codes from `ddnsscript.sh` in this repository.

Modify three places in angle bracket `<>`:

`<your_domain_name>` : domain name you acquire on pubyun, example: `xxxx.f3322.net`

`<your_update_code>` : update code from domain name settings

`<your_wan_interface>` : probably be 'wan' or 'eth0.2'. type `ifconfig` to check what ip to be sent.

Then `:wq` and `./ddnsscript.sh` to run once.

(Optional) Or you can first git it on Windows:

```
git clone https://github.com/RH-Xie/Remote-Desktop.git
```

Copy `ddnsscript.sh` to `/etc` **on your Openwrt router** via tools like WinSCP.
`vim` or `vi` to modify your `ddnsscript.sh`.

### CRON (schedual tasks)

If you have successfully updated your ip to pubyun, then setup schedual task on Openwrt.

```
*/20 * * * * /etc/ddnsscript.sh

```

### Port forwarding

Setup port forwarding in firewall with inner port `3389`.
