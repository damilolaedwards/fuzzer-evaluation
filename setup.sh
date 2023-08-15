#!/bin/bash
# shellcheck source=/dev/null
set -e

# set hostname
echo "Setting hostname..."
echo "cloudfuzz" >/etc/hostname
hostname -F /etc/hostname

echo "Installing prereqs..."
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y jq unzip s3cmd tmux python3-pip python3-venv

echo "Downloading doctl..."
curl -fsSL -o /tmp/doctl-1.92.0-linux-amd64.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.92.0/doctl-1.92.0-linux-amd64.tar.gz
echo "Extracting doctl..."
tar -xzf /tmp/doctl-1.92.0-linux-amd64.tar.gz -C /tmp
echo "Installing doctl..."
mv /tmp/doctl /usr/local/bin
echo "Cleaning up..."
rm /tmp/doctl-1.92.0-linux-amd64.tar.gz

echo "Downloading echidna..."
curl -fsSL -o /tmp/echidna.tar.gz https://github.com/crytic/echidna/releases/download/v2.1.1/echidna-2.1.1-Ubuntu-22.04.tar.gz
echo "Extracting echidna..."
tar -xzf /tmp/echidna.tar.gz -C /tmp
echo "Installing echidna..."
cp /tmp/echidna /usr/local/bin
rm /tmp/echidna.tar.gz

echo "Installing solc..."
python3 -m venv ~/venv
source ~/venv/bin/activate
pip3 install solc-select slither-analyzer crytic-compile
solc-select install 0.8.6
solc-select use 0.8.6

echo "[$(date)] Install foundry"
curl -L https://foundry.paradigm.xyz | bash
export PATH="$PATH:$HOME/.foundry/bin"
foundryup
sudo mv .foundry/bin/* /usr/bin/

echo "[$(date)] Install medusa"
curl -fsSL https://github.com/crytic/medusa/releases/download/v0.1.0/medusa-linux-x64.zip -o medusa.zip
unzip medusa.zip
chmod +x medusa
sudo mv medusa /usr/local/bin

echo "[$(date)] Install gambit"
curl -fsSL https://github.com/Certora/gambit/releases/download/v1.0.0/gambit-linux-v1.0.0
mv gambit-linux-v1.0.0 gambit
chmod +x gambit
sudo mv gambit /usr/local/bin