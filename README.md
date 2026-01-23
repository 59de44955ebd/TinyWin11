# TinyWin11 - a 580 MB Windows 11 PE based live USB and VM 

![](screenshots/TinyWin11.jpg)

TinyWin11 a small live USB (as well as VM) based on Windows 11 PE and a slightly adjusted version of a simple custom desktop shell called [WinSetupShell](https://github.com/59de44955ebd/WinSetupShell). It's actually just a by-product of this other project.

TinyWin11 is provided in two flavors:

- as virtual machine for [VMware Workstation](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) (Windows, Linux) and [VMware Fusion](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) (macOS).  
  Both are now free (as in beer, not open source).

- as raw disk image (.img) that can be used to create a bootable USB drive using tools like [dd](https://en.wikipedia.org/wiki/Dd_(Unix)), [Etcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/en/).

See WinSetupShell's [README.md](https://github.com/59de44955ebd/WinSetupShell/blob/main/README.md) for features and restrictions of this simple desktop shell and how to configure it, how to add additional programs (like e.g. a web browser) etc.

## Building

### Requirements

- [Python 3](https://python.org/) and [pyinstaller](https://pypi.org/project/pyinstaller/) on Windows for building the shell.

- [Windows ADK 10.1.26100.2454](https://go.microsoft.com/fwlink/?linkid=2289980)  
  (only the "Deployment Tools" need to be installed)

- [Windows PE add-on for the Windows ADK 10.1.26100.2454](https://go.microsoft.com/fwlink/?linkid=2289981)  

### Building the shell

Run `make_shell.cmd`

### Building the system and the .img and .vmdk disk images

Run `make_system.cmd` from an elevated CMD prompt.
