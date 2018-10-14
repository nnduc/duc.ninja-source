---
layout: post
title:  "Tips to be more productive with Xcode"
date:   2017-09-25 07:02:34 +0700
key: 20170925
tags:
  - xcode
  - tips
lang: en
---

<br>`⌃`: Control
<br>`⌘`: Command
<br>`⌥`: Option
<br>`⇧`: Shift
<br>`⏎`: Return

### 1. Decide Where to Open a File
In Xcode, you can open a file in various ways: in the standard editor, in a new or existing assistant editor, in a new or existing tab, or in a new window. Here's how you can decide about this:

When clicking on a file in the Navigator, hold down **`⇧`** + **`⌥`**
<br>When clicking on a symbol in an editor pane, hold down **`⇧`** + **`⌥`** + **`⌘`**
<br>A pop-over will appear and let you choose where exactly you want this file to be displayed:

![](/assets/images/xcode-open-file.gif)

### 2. Moving a full line or many lines of code up or down

**`⌘`** + **`⌥`** + **`{`** : move up

**`⌘`** + **`⌥`** + **`}`** : move down

> If you have text selected, Xcode will move each line containing your selection; otherwise, it’ll move the line the cursor is in.

### 3. Quickly find app’s container folder
You can get app’s container on the file system with a single command. You just need to know app’s bundle identifier and execute the command below:
```bash
xcrun simctl get_app_container booted <APP'S BUNDLE ID>
```
Or you can make it even faster by opening destination folder in Finder with the open command:
```bash
open `xcrun simctl get_app_container booted <APP'S BUNDLE ID>` -a Finder
```


### 4.  Reveal in Project Navigator

The **Reveal in Project Navigator** command is a true timesaver for large, complex projects with lots of files and folders. The command shows or reveals the current file in the **Project Navigator** on the left. The default key binding is **⌘ + ⇧ + J**.

### 5. Jump to Method

When I am working in a class or structure, I often have the need to quickly jump to a particular method in the class. This is very easy by pressing **⌃** + **6** and typing the first few letters of the method’s name.

![](/assets/images/figure-jump-to-method.jpg)


<br><br>
Source:

- [git-tower][git-tower]
- [detroitlabs][detroitlabs]
- [cocoacasts][cocoacasts]


[git-tower]: https://www.git-tower.com/blog/6-tips-for-xcode/
[detroitlabs]: https://www.detroitlabs.com/blog/2017/04/13/17-xcode-tips-and-tricks-that-every-ios-developer-should-know/
[cocoacasts]:https://cocoacasts.com/seven-xcode-tricks-every-developer-should-know/
