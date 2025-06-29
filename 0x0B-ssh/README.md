# 0x0B-SSH Project

## Background
This project focuses on understanding and implementing Secure Shell (SSH) for secure remote access to an Ubuntu 20.04 LTS server. It covers creating SSH key pairs, configuring SSH clients, and automating configurations using Puppet. The project includes tasks to connect to a provided server using a private key, create RSA key pairs, configure passwordless authentication, and manage server access.

## Learning Objectives
By the end of this project, you will be able to explain:
- What is a server and where servers usually live
- What is SSH and its role in secure communication
- How to create an SSH RSA key pair
- How to connect to a remote host using an SSH RSA key pair
- The advantage of using `#!/usr/bin/env bash` over `/bin/bash`

## Requirements
- **Environment**: Ubuntu 20.04 LTS
- **Editors**: vi, vim, emacs
- **Files**: All scripts must be executable, use `#!/usr/bin/env bash` as the shebang, and include a comment on the second line explaining the script's purpose.
- **Repository**: Files must be pushed to the GitHub repository `alx-system_engineering-devops` in the directory `0x0B-ssh`.

## Repository
- **GitHub repository**: `alx-system_engineering-devops`
- **Directory**: `0x0B-ssh`

## Tasks
1. **Use a private key** (`0-use_a_private_key`):
   - Bash script to connect to the server using the private key `~/.ssh/school` with the user `ubuntu`.
   - Uses single-character SSH flags without `-l`.

2. **Create an SSH key pair** (`1-create_ssh_key_pair`):
   - Bash script to create an RSA key pair named `school` with 4096 bits, protected by the passphrase `betty`.

3. **Client configuration file** (`2-ssh_config`):
   - Configure the local SSH client to use `~/.ssh/school` and disable password authentication.

4. **Let me in!**:
   - Add a provided public key to the server’s `~/.ssh/authorized_keys` for the `ubuntu` user.

5. **Client configuration file (w/ Puppet)** (`100-puppet_ssh_config.pp`):
   - Puppet manifest to configure the SSH client to use `~/.ssh/school` and disable password authentication.

## Files
- `0-use_a_private_key`: Script for SSH connection using a private key.
- `1-create_ssh_key_pair`: Script to generate an RSA key pair.
- `2-ssh_config`: SSH client configuration file.
- `100-puppet_ssh_config.pp`: Puppet manifest for SSH client configuration.
- `README.md`: This file, providing project overview and documentation.
