# Ubuntu zRAM Setup

This script automates the removal of the slower virtual memory `swapfile` and installs/configures **zRAM as swap**, which provides faster and more modern memory swapping for Linux and Ubuntu-based systems.

## 🚀 Features

- Removes the old and slow `swapfile`
- Enables **ZRAM** as swap using `zram-config`
- Installs and activates **EarlyOOM** (a mechanism that prevents system freezes due to low memory)

## 🛠️ Requirements

- Ubuntu 24.04 and later or derivatives (Kubuntu, Linux Mint, Zorin OS...)


## 📦 Installation and Usage

1. Clone the repository or download the script and save it to your ***Downloads folder**:

```bash
cd ~/Downloads
wget https://github.com/diogopessoa/ubuntu-zram-setup/blob/main/ubuntu-zram-setup.sh
```

2. Make the script executable:
```bash
chmod +x ubuntu-zram-setup.sh
```
   
3. Run the script as root:

```bash
sudo ./ubuntu-zram-setup.sh
```

## 🧪 Post-Execution Checks

You can use the following commands to verify everything was configured correctly:

```bash
zramctl
swapon --show
systemctl status zram-config
systemctl status earlyoom
```

## 📂 License

MIT — feel free to use, modify, and contribute!
