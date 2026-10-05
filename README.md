# Incubator

This is a linux-specific setup for the lab
using [Incus](https://linuxcontainers.org/incus/) as the VM manager
and [OpenTofu](https://opentofu.org/) for the VM setup.

### Prerequisites

The configuration has been tested with:

- Linux 7.2.8
- Incus 7.5.1
- OpenTofu 1.13.1

### Setup

1. Install Incus and OpenTofu.
2. Clone the repository.
3. Set up Ubuntu images.
    This is a temporary workaround to [issues](https://discuss.linuxcontainers.org/t/loud-vms-stuck-in-continuous-boot-loop/27287) with the last Incus release.

    ```bash
    cd genie-lab-incus
    mkdir images
    cd images

    # Download ubuntu image and metadata
    # You can also use curl -O instead of wget
    wget https://cloud-images.ubuntu.com/releases/resolute/release/ubuntu-26.04-server-cloudimg-amd64.img
    wget https://cloud-images.ubuntu.com/releases/resolute/release/ubuntu-26.04-server-cloudimg-amd64-lxd.tar.xz
    ```
4. Start the VMs.

    ```bash
    # Must be run at project root
    tofu init
    tofu apply
    ```

    The VMs should take about 30 seconds to boot.
    You can check on them with `incus console <name>`,
    e.g. `incus console router`.
    To see what VMs are running, run `incus list`.

5. Enter the VM. Use `incus exec <name> -- bash`.

    ```bash
    incus exec client -- bash
    ```

    Now you can run `tracepath -n 192.168.101.2`
    to ensure the server and client can reach each other.
