# Mars OS

The official repository for the Linux distribution **Mars OS**, developed by **MARSYX TECHNOLOGIES PRV**.

Mars OS is a Linux distribution designed to find a middle ground between user convenience and complete control over the system. It aims to provide a polished experience out of the box while still encouraging users to customize, explore, and learn how their system works.

Built on **[Arch Linux](https://archlinux.org/)**, Mars OS takes advantage of Arch's rolling release model and uses the **[pacman](https://archlinux.org/pacman/)** package manager for fast and reliable software management. Users can also access the **[Arch User Repository (AUR)](https://aur.archlinux.org/)**, giving them access to one of the largest collections of community-maintained software available on Linux.

Mars OS includes a custom installer, sensible default configuration, and a automated configuration of the 3 included desktop environments that is designed to be lightweight, responsive, and easy to personalize. Rather than complete hand-holding, Mars OS gives users the tools they need to understand and shape their own installation while reducing the amount of manual setup required.

Regardless of your familiarity with the Linux operating system all together, Mars OS is an easy to pick up distro for both beginners and enthusiasts.

---
# Installation
---
## Download Mars OS ISO
For the most simplistic and easy option, download the Mars OS ISO file from **[here.](https://drive.google.com/drive/folders/1MV13STtLz8qFWZwK-ZnEceCOhA8Te4eb?usp=sharing)**
(This will take you to a public Google Drive folder with said ISO file)

Following the download, make sure you have a USB Stick at least 3 GiB in capacity and use a bootable USB creation tool such as **[Rufus](https://rufus.ie/)** or the **[Dd](https://wiki.archlinux.org/title/Dd)** command.

---
## Building from source

To build the Mars OS ISO locally from source, clone the repository by running:

```bash
git clone https://github.com/MARSYXTECHNOLOGIESPRV/MarsOS
```

Then, change into the `MarsOS` directory:

```bash
cd MarsOS
```

Finally, build the ISO with:

```bash
sudo mkarchiso -v -w work -o out marsiso
```

If a build already exists and you are trying to generate a new one, first remove the work and out directories by running:
```bash
sudo rm -rf work out
```

Then rebuild.

Once the build is complete, the compiled ISO will be located in the newly created `out` directory.

---

### NOTE:
Building from source requires that you have the packages archiso, base-devel, and git installed on your system.
