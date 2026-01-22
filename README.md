# TinyWin11 - a 540 MB Windows 11 PE based live USB and VM 

![](screenshots/TinyWin11.jpg)

TinyWin11 a small live USB (as well as VM) based on Windows 11 PE and a slightly adjusted version of a simple custom desktop shell called [WinSetupShell](https://github.com/59de44955ebd/WinSetupShell). It's actually just a by-product of this other project.

TinyWin11 is provided in two flavors:

- as virtual machine for [VMware Workstation](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) (Windows, Linux) and [VMware Fusion](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) (macOS).  
  Both are now free (as in beer, not open source).

- as raw disk image (.img) that can be used to create a bootable USB drive using tools like [dd](https://en.wikipedia.org/wiki/Dd_(Unix)), [Etcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/en/).

See WinSetupShell's [README.md](https://github.com/59de44955ebd/WinSetupShell/blob/main/README.md) for features and restrictions of this simple desktop shell and how to configure it, how to add additional programs (like e.g. a web browser) etc.

## Building

### Requirements

- [Python 3](https://python.org/) and [pyinstaller](https://pypi.org/project/pyinstaller/) for building the shell.

- [ADK for Windows 11, version 22H2](https://go.microsoft.com/fwlink/?linkid=2196127)  
  (only the "Deployment Tools" have to be installed)

- [Windows PE add-on for the ADK for Windows 11, version 22H2](https://go.microsoft.com/fwlink/?linkid=2196224)  
  Microsoft recommends to apply the [2023-05 Cumulative Update for Windows 11 for x64-based Systems (KB5026368)](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/05/windows10.0-kb5026368-x64_a5523f98635d9c2b93f2f2144e5bacab7ff7d838.msu) to the PE, which only has to be done once.

Version 22H2 is used to maximize hardware compatibility (no SSE4.2 requirement), but later Windows 11 PE versions could be used instead. Other Windows 11 hardware requirements (like 4+ GB RAM, Secure Boot and TPM 2.0) don't apply anyway, 1 GB RAM and a 20 years old PC should work fine.

### Building the shell

Run `make_shell.cmd`

### Building the system and the .img and .vmdk disk images

Run `make_system.cmd` from an elevated CMD prompt.
