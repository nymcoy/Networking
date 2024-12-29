# Networking Project

## Purpose

The primary goal of this project is to simulate a network infrastructure using virtual machines (VMs) to test and validate a setup that allows accessing a home server with a non-static IP via a gateway in the cloud, which has a static IP. This simulation ensures that the home server remains accessible despite changes in its IP address. The included Ansible playbooks are designed to configure this setup within the Vagrant environment.

## Prerequisites

To run this project, you need to have the following software installed:

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (or another Vagrant-compatible provider)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Setup and Usage

### Step 1: Clone the Repository

Clone this repository to your local machine using the following command:

```bash
git clone <repository_url>
```

### Step 2: Navigate to the Project Directory

Go to the project directory:

```bash
cd networking
```

### Step 3: Generate and Create `secrets.yml`

Generate a secure VPN pre-shared key (PSK) and store in `secrets.yml`:

```bash
echo "vpn_psk: \"$(openssl rand -base64 32)\"" > secrets.yml
```

### Step 4: Start the Vagrant Environment

Start the Vagrant environment, which will set up the virtual machines according to the configuration in the `Vagrantfile`:

```bash
vagrant up
```

### Step 5: Test the Setup

To test if the setup works, SSH into the `remote` machine and curl the `gateway`'s IP to get the webpage hosted on the `server`:

```bash
vagrant ssh remote
curl http://192.168.20.2
```

You should see the webpage content hosted on the `server`.

## Troubleshooting

If you encounter any issues, try the following steps:

- Ensure all required software is installed.
- Check the Vagrant status using `vagrant status`.
- Re-provision the VMs using `vagrant provision`.
- Check the StrongSwan connection status on the `gateway` and `server`:

  ```bash
  vagrant ssh gateway
  sudo ipsec status
  ```

  ```bash
  vagrant ssh server
  sudo ipsec status
  ```

- Ping the `gateway` from the `server` to ensure connectivity:

  ```bash
  vagrant ssh server
  ping 192.168.20.2
  ```

For further assistance, refer to the official documentation of [Vagrant](https://www.vagrantup.com/docs) and [Ansible](https://docs.ansible.com/ansible/latest/index.html).

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- The [Vagrant](https://www.vagrantup.com/) and [Ansible](https://www.ansible.com/) teams for their excellent tools.
