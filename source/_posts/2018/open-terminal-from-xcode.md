---
layout: post
title:  "Open Terminal from Xcode"
date:   2018-02-04 13:20:00 +0700
key: 20180204
tags:
  - xcode
  - tips
  - til
lang: en
---


### #TIL

You are using third-party tools like CocoaPods, Cathage, SPM or just having some useful script files for your project. It's fine!

But you often found yourself in need of opening a Terminal window at the project location. It hard to tell that feeling. 🤔 Don't worry, here is what you need to do:

### 1.  Create a sh file

Create a new text file with your favourite text editor and put this inside:

```console
#! /bin/bash
open -a Terminal "$SRCROOT"
```

or

```console
#!/bin/sh

if [ -n "$XcodeProjectPath" ]; then
  open -a Terminal "$XcodeProjectPath"/..
else
  open -a Terminal "$XcodeWorkspacePath"/..
fi
```

It opens either `.xcodeproj` or `.xcworkspace`.

> If you prefer iTerm, just change the Terminal keyword to iTerm in this script. I'm using **iTerm** too, so I created a bash file like this:

![Create script file](/assets/images/open-terminal-from-xcode/create-script.png)

### 2. Store the file

Save it with a .sh extension in some permanent location where your wife or your girlfriend wouldn’t see it everyday so it annoys them, and they won’t delete it by mistake.

### 3. Grant execute permission

Navigate to the location of the script file you just created using Terminal and change its permissions using:

```console
  chmod +x <fileName>
```

where **fileName** should be replaced with the name of the .sh file you just created.

### 4. Add a custom behavior

In Xcode, go to **Preferences -> Behaviors** and click the plus sign in the bottom to add a new behavior and name it something like **“Open Terminal”**

![](/assets/images/open-terminal-from-xcode/create-a-custom-behavior.png)

Tick only the last checkbox, where it says “Run”, and select the location of your .sh file.

### 5. Assign a key

Click the little ⌘ symbol to the right of your behavior name and select a new keyboard shortcut for your behavior. I recommend: ctrl+command+t.

![](/assets/images/open-terminal-from-xcode/assign-key.png)

That’s it, you’re done!  🎉  🎉  🎉

You can get my sh file here: [xcode-terminal.sh](https://gitlab.com/snippets/1697089)
