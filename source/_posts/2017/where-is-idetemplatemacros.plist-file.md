---
layout: default
title:  "Customizing the file Header comment and text macros"
date:   2017-11-04 23:15:00 +0700
key: 20171104
tags:
  - xcode
  - tips
lang: en
---

## Text macros
Text macros are symbols that are expanded in-place to the specified text. They are used in files and other places in Xcode, such as the header text for a new file or the project name. You can customize existing macros and add your own macros in a project, for all users of a project, or for all of Xcode. Customizing a macro requires two things:

- *A plist named IDETemplateMacros.plist at an appropriate location.*
- *An entry in IDETemplateMacros.plist for the text macro.*
-
  Xcode looks for the value of a text macro in the following locations and uses the first matching macro:
```
Project user data -> Project shared data -> Workspace user data -> Workspace shared data -> User Xcode data
```

<!-- ![](/assets/images/xcode-file-header-comment.png) -->

### For a single project and user:
  `<ProjectName>.xcodeproj/xcuserdata/[username].xcuserdatad/IDETemplateMacros.plist`
### For all team members in a single project:
  `<ProjectName>.xcodeproj/xcshareddata/IDETemplateMacros.plist`
### For all projects in a workspace for a single user:
  `<WorkspaceName>.xcworkspace/xcuserdata/[username].xcuserdatad/IDETemplateMacros.plist`
### For all projects in a workspace for all team members:
  `<WorkspaceName>.xcworkspace/xcshareddata/IDETemplateMacros.plist`
### For everything you work on, regardless of project:
  `~/Library/Developer/Xcode/UserData/IDETemplateMacros.plist`


## Example
```
//  ___FILENAME___
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//
```
![Text macros reference](https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0)


Source: Ole Begemann
