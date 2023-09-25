<a id="readme-top"></a>

<style>
  .responsive-img {
    max-height: 150px;
    max-width: 100%;
    width: auto;
  }
</style>

<br />
<div align="center">
  <a href="https://github.com/mmgordon82/BurpSuiteInstaller">
    <img src="readme-assets/title-logo.png" alt="Logo" class="responsive-img">
  </a>

<h3 align="center">Burp Suite Cracked Activator (Keygen and Loader + Easy Install)</h3>

  <p align="center">
    Install the most updated versions of Burp Suite (Pro) with easy-to-use installers and instructions in an automated fashion.
    <br />
  </p>

![Go](https://img.shields.io/badge/go-%2300ADD8.svg?style=for-the-badge&logo=go&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Inno Setup](readme-assets/badge-inno-setup.svg)
![OpenJDK](https://img.shields.io/badge/OpenJDK-%23d47820.svg?style=for-the-badge&logo=openjdk&logoColor=white)
</br>
[![Download Now](https://img.shields.io/badge/-Download%20Now-5b4fff?style=for-the-badge&logo=github&logoColor=black)](https://github.com/mmgordon82/BurpSuiteInstaller/releases/latest)

</div>

## Disclaimer (Legal Notice)
This is for educational purposes only. I am not responsible for any damage caused by this software. Use at your own risk.


<!-- ABOUT THE PROJECT -->
## About
tl;dr now you can install Burp Suite (or patch your current setup) easily.

In the past few months, I needed to install Burp suite more than I had imagined. And every time I found myself bamboozled with how to crack/activate it.

Just to clarify, activating it means doing the following:
 - Looking online (mostly on Telegram or shady torrent sites) for a cracked version (hoping it doesn't contain any virus)
 - Download it
 - Put the JAR file somewhere on my PC
 - Modify the .vmoptions file
 - Download and install JRE
 - Discover I downloaded the wrong version of JRE
 - Download and install JRE (the right version this time)
 - Use a half-cocked keygen and loader that contains god-knows-what.
 - (OPTIONAL) create a shortcut and put it in the Programs directory, so it can be accessed as a run-of-the-mill software.

So in the past few weeks I decided to work on a solution that would mimic the official Burp-Suite exe installer only paid pro members get.

This repo includes:
 - `installer` for Windows - Installs everything needed, includes JDK, Burp and the keygen/loader.
 - `patcher`, for those who prefer installing the official releases of Burp - activates the existing installed Burp.

The keygen used is written by [h3110w0r1d-y](https://github.com/h3110w0r1d-y/BurpLoaderKeygen).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

### Linux

#### Download and Install
```bash
# Download the official release from PortSwigger
wget -O 'burpsuite_pro_linux.sh' 'https://portswigger-cdn.net/burp/releases/download?product=pro&version=2023.10.1.1&type=Linux'
chmod +x burpsuite_pro_linux.sh

# Can also be installed as root user (for all users)
./burpsuite_pro_linux.sh

# Install Burp Suite Using the GUI

# Download & Run the patcher
wget -O 'burpsuite_pro_patcher_linux.sh' 'https://github.com/mmgordon82/BurpSuiteInstaller/releases/latest/download/burpsuite_pro_patcher_linux_generic.sh'
chmod +x burpsuite_pro_patcher_linux.sh
./burpsuite_pro_patcher_linux.sh

# Follow the patcher...
# That's it!
```

### Windows

#### Using the unofficial installer
Simply download the [Latest Installer for Windows](https://github.com/mmgordon82/BurpSuiteInstaller/releases/latest) and follow the instructions.

On the first run, you'll be required to proceed with the offline activation process.

#### Using the official installer
Download and install the [official installer from PortSwigger](https://portswigger-cdn.net/burp/releases/download?product=pro&version=2023.10.1.1&type=WindowsX64).

After the installation is complete, download and run the [patcher for Windows](https://github.com/mmgordon82/BurpSuiteInstaller/releases/latest) and run it.

## Utilities

### Remove License and Configurations
Sometimes you might want to remove the license and configurations from Burp Suite. This is useful when you want to use Burp Suite on a different machine, or when you want to reset Burp Suite to its default state. For this, you can use the `reset-burp-settings.bat` script.

#### Windows
Simply run the `reset-burp-settings.bat` script. This will remove the license and configurations stored on disk and on registry.

#### Linux
Instead of registry, Linux uses the `~/.java/.userPrefs/burp/` directory to store the configurations. To remove the license and configurations, simply run the following command:

```bash
rm -rvf ~/.java/.userPrefs/burp/
```

<!-- LICENSE -->
## License

Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* Keygen by [h3110w0r1d-y](https://github.com/h3110w0r1d-y/BurpLoaderKeygen)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
