# Born2beroot

Steps to have a Born2beroot (bonus version) compliant virtual machine 1:
1. Download latest stable debian.
2. Set up a virtual machine with two network interface, a NAT and a Host-only.
3. Install the downloaded debian in it following the rules:
    - hostname: <your_user>42
    - username: <your_user>
    - password and parition: just follow the steps on the pdf
4. Boot up and login as root.
5. `apt install -y curl git`
6. `curl -fsSL https://raw.githubusercontent.com/leoc01/Born2beroot/refs/heads/main/setup.sh | bash`

The machine is almost ready, you just have to install the bonus dependancies. If you are not doing the bonus there will be some extra stuff here that will cause you to fail in the evaluation.
