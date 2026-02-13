# Born2beroot

Steps to have a Born2beroot compliant virtual machine:

1. Download latest stable debian.
2. Set up a virtual machine with two network interface, a NAT and a Host-only.
3. Install the downloaded debian in it following the rules:
   - hostname: <your_user>42
   - username: <your_user>
   - password and parition: just follow the steps on the pdf
4. Boot up and login as root.
5. `apt install -y curl git`
6. `curl -fsSL https://raw.githubusercontent.com/leoc01/Born2beroot/refs/heads/main/setup.sh -o setup.sh`
7. bash setup.sh _your-intra-user_

The machine is ready.
