---
layout: post
title:  "Remove old Simulators"
date:   2017-11-05 11:10:00 +0700
key: 20171105
tags:
  - xcode
  - tips
  - til
lang: en
---

If you are an iOS developer, execute this:

```swift
$ xcrun simctl delete unavailable
```
<!-- more -->

It removes old simulators Xcode no longer use


Source: @dev_jac
