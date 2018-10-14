---
layout: default
title:  "Shortcut to run a test case or run whole test case"
date:   2018-01-25 21:43:00 +0700
key: 20180125
tags:
  - ios
  - xcode
  - tips
  - testing
lang: en
---



### #TIL

 `⌃⌥⌘U` shortcut does different things depending on the current cursor location:

- inside a test method: runs this single test method
- inside an `XCTestCase` subclass but outside of any method: runs all tests in the class
- Run last test case before: `⌃⌥⌘G`

![](/assets/images/run-test-case.jpg)

Source: @arekholko
