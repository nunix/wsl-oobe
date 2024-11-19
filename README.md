# wsl-oobe
 
Demo of the new WSL2 oobe with container rootfs

## Prerequisites

- Windows 11 or Windows Server 2025
- [WSL2 v2.4.4](https://github.com/microsoft/WSL/releases/tag/2.4.4)
- Docker/Rancher/Podman Desktop (pick your preferred one)

## Quickstart

```powershell
# [Optional] Remove distro if it exists already
wsl --unregister corsairnix

# Build a container based on Azure Linux v3
## See Dockerfile.azurelinux for details
docker build -t local/corsairnix -f .\Dockerfile.azurelinux --no-cache .

# [Optional] Remove the container if it exists already
docker rm corsairnix

# Create a new container without running any command
docker run --name corsairnix local/corsairnix

# Export the container's rootfs to a directory
## [Example] The following directory structure is in place:
## tree C:\wsl\
## Folder PATH listing
## Volume serial number is 0CC2-5C5C
## C:\WSL
## ├───distros
## └───sources
docker export -o C:\wsl\sources\corsairnix.tar corsairnix

# Copy the container rootfs file to the current directory and changes the extension to `.wsl`
cp C:\wsl\sources\corsairnix.tar corsairnix.wsl
```

Once the `.wsl` file is created, open it by double clicking on it. It will install the WSL2 distro.

## Demo video

https://github.com/user-attachments/assets/71f73844-8f50-4035-bf37-1d6106290ef8
