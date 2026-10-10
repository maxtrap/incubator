# Incubator

This is a Linux-specific setup for doing network tests on a client-router-server
architecture.
Is uses [Incus](https://linuxcontainers.org/incus/) as the VM manager
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
    cd incubator
    mkdir images
    cd images

    # Download ubuntu image and metadata
    # You can also use curl -O instead of wget
    wget https://cloud-images.ubuntu.com/releases/resolute/release/ubuntu-26.04-server-cloudimg-amd64.img
    wget https://cloud-images.ubuntu.com/releases/resolute/release/ubuntu-26.04-server-cloudimg-amd64-lxd.tar.xz

    # Import the image
    incus image import ubuntu-26.04-server-cloudimg-amd64-lxd.tar.xz \
        ubuntu-26.04-server-cloudimg-amd64.img --alias ubuntu-26.04-lab
    ```
4. Start the VMs.

    ```bash
    # Must be run at project root
    tofu init
    tofu apply -var name=hello
    ```

    Replace `hello` with your desired project name.
    This name will be used as a prefix for everything the lab makes.

    The VMs should take about 30 seconds to boot.
    You can check on them with `incus console <name>`,
    e.g. `incus console hello-router`.
    To see what VMs are running, run `incus list`.

5. Enter a VM. Use `incus exec <name> -- bash`.

    ```bash
    incus exec hello-client -- bash
    ```

    Now you can run `tracepath -n 192.168.101.2`
    to ensure the server and client can reach each other.

6. Destroy the VMs. If you need to delete all the VMs, simply run:

    ```bash
    tofu destroy -var name=hello
    ```

    This will wipe all the VMs and networks.


