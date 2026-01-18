# TinyWin11 - a Windows 11 based live USB and VM under 700 MB

![](screenshots/TinyWin11.jpg)

TinyWin11 a tiny live USB (as well as VM) based on Windows 11 PE and a custom desktop shell called [WinSetupShell](https://github.com/59de44955ebd/WinSetupShell). It's actually just a by-product of this other project.

TinyWin11 uses the `boot.wim` of the `Win11_23H2_English_x64v2` setup .iso, with setup.exe replaced by this custom shell, so it directly boots into a desktop session instead of the original Windows 11 setup window. Release 23H2 was used to maximize hardware compatibility (no SSE4.2 requirement), but the same thing could of course also be done with later Windows 11 setup releases like 24H2 and 25H2.

TinyWin11 is provided in two flavors:

- as virtual machine for [VMware Workstation (Windows, Linux) / VMware Fusion (macOS)](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) (both are now free as in beer).

- as raw disk image (.img) that can be used to create a bootable USB drive using tools like e.g. [dd](https://en.wikipedia.org/wiki/Dd_(Unix)), [Etcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/en/).

Check out WinSetupShell's [README.md](https://github.com/59de44955ebd/WinSetupShell/blob/main/README.md) for
more infos about the shell, like its features and restrictions, how to configure it, how to add additional programs etc.
