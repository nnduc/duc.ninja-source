---
layout: post
title:  "macOS High Sierra Final Version for Your Mac"
date:   2017-09-26 12:53:34 +0700
key: 20170926
tags:
  - macOS
  - tips
lang: en
---

![](/assets/images/macos-high-sierra.png)


#### Is Your Mac Compatible with High Sierra?

This is vital information. But if your Mac can run macOS Sierra then it will be able to run macOS High Sierra just fine. But just in case, here is the list of compatible Mac computers with macOS High Sierra.
<br>
iMac – 2009 or later.<br>
MacBook – 2009 or later.<br>
Mac Pro – 2010 or later.<br>
Mac mini – 2010 or later.<br>
MacBook Pro – 2010 or later.<br>
MacBook Air – 2010 or later.<br>


Link: [Download macOS High Sierra Final Version][appstore]


### Create macOS High Sierra USB Installer Drive for Clean Install

####  Format USB Drive Which You’re Going to Use as Installer Source.
  This is an extremely crucial step. Get yourself an 8GB (or more) USB flash drive. Once you do, plug it in your Mac and follow the steps exactly as they’re outlined below. Please do not make changes that are not outlined in the guide.

1. Plug in your USB drive to your Mac and then launch Disk Utility. You can launch it by opening Spotlight Search, then do a quick search for Disk Utility.

2. Once Disk Utility is in view, select your USB drive from the available choices on the left then click on the Erase button at the top.

3. Without changing anything at all, click on the Erase button. Refer to the screenshot below to make sure you haven’t made any change even by mistake.


#### Once the USB is done erasing, move on to the next step.

Create macOS High Sierra USB Installer.
This is the final step in the USB installer making guide. Also, this is the step which you have to get absolutely right otherwise all efforts will go to waste. It’s best to read through the guide several times before ultimately punching in the command itself.

All set? Let’s begin.

1. Plug in the formatted USB drive to your Mac. If it’s already plugged in then move on to the next step.

2. Launch Terminal. Open up Spotlight Search and do a quick search of Terminal and hit the Return key on the keyboard.

3. Now, with the USB plugged in, type in the following command exactly as it is. There’s no chance of error at all. Also, see those single, long dashes? They’re actually double dashes. The website font is making them appear like that. Refer to the screenshot right under the command and you’ll see immediately what I’m taking about here.

```
sudo /Applications/Install\ macOS\ 10.13.app/Contents/Resources/createinstallmedia –volume /Volumes/Untitled –applicationpath /Applications/Install\ macOS\ 10.13.app
```
![](/assets/images/disk-utility-erase-usb-step.png)

You’ll be required to enter your Mac’s login password, so please do so when prompted for it.

The entire process, if followed correctly, will take no more than a few minutes. If you have a USB 3.0 drive, then you’ll boost through the process like a champ.

Now you can move on to the next big step – clean installing macOS High Sierra. Check out our guide below for more details.



### How to Clean Install macOS High Sierra – Tutorial

Create a macOS High Sierra USB Installer. Once you are done, return to this tutorial for further details.

With the USB installer disk plugged into your Mac and everything backed up, follow the steps outlined below.

1. Power down your Mac and boot it back up with the Option key pressed down.

2. You’ll see a couple of drive options on the display. Select the macOS High Sierra USB installer and hit the Return key on the keyboard.

3. Now open Disk Utility, select your Mac HDD or SSD from the left hand side pane and then click on Erase. Click on the Erase button to confirm with the format process.

4. Close the Disk Utility window as soon as the format and erase process is complete.

5. On the main installation screen, just select the install macOS 10.13 High Sierra installation option, select the drive you formatted as source of installation and follow on-screen instructions for completion.

###  How to Update to macOS High Sierra Without Losing Files & Settings

Install macOS High Sierra Over the Air.
Just as a safety precaution, it’s best to copy all your important files to either iCloud Drive or onto an external storage medium. Also make sure that you have at least 10GB of free space on your Mac. You can check how much space you have by clicking on the Apple logo icon in the menu bar, then click on About this Mac, then click on the Storage tab. You should see something similar to the screenshot below.
![](/assets/images/mac-storage-space.png)

1. Connect to a WiFi network and then launch the Mac App Store.
2. Let the Mac App Store refresh properly and then click on the Updates tab at the top.
3. In a few seconds the new High Sierra update will show up. When it does, you’ll see an Update button right next to it. Click on it.

4. At this point, the download will commence. But once it’s complete, just follow the on-screen prompts for installation.

Your Mac will become completely unusable during the installation time period so make sure you save all your work ahead of proceedings. But as soon as the installation is complete, you’ll be prompted to enter your Apple ID password then you can start using your Mac immediately.

The over the air route is great and all, but occasionally users might run into performance related issues down the line. Therefore it’s recommended you go for the clean install method, provided you have the time and patience. But if everything is working out just fine for you then you’re golden.

[appstore]: https://itunes.apple.com/us/app/macos-high-sierra/id1246284741?mt=12

