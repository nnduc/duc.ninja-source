---
layout: default
title:  "What the hell is Swift 4 Access Control?"
date:   2017-11-04 21:45:00 +0700
key: 20171104
tags:
  - ios
  - swift
lang: en
---

In [object-oriented programming languages](https://en.wikipedia.org/wiki/Object-oriented_programming), *access control* is a part of the apparatus of achieving [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)), one of four fundamentals of object-oriented programming. The goal is to establish a clear separation between interface (visible and accessible parts of the class) and implementation (internal representation and helper methods). - [Wikipedia](https://en.wikipedia.org/wiki/Access_control#In_object-oriented_programming)



### TL;DR

In Swift 4 we have **5 access levels** like Swift 3, including `open`, `public`,  `internal`, `fileprivate` and `private`, but has some differents.

### Open
You can access `open` classes and class members from **any source file** in the defining module or **any module that imports that module**. You can **subclass** an `open` class or **override** an `open` class member both within their defining module and **any module** that imports that module.

### Public
`public` allows the **same access as open** - any source file in any module - but has more restrictive subclassing and overriding. You can only subclass a `public` class within the same module. A `public` class member can only be overriden by subclasses in the same module. This is important if you are writing a framework.** If you want a user of that framework to be able to subclass a class or override a method you must make it** `open`.

### Internal
`internal` allows use from any source file in the defining module but not from outside that module. This is generally the **default access level**.

### Fileprivate
Restricts the use of an entity to its defining source file. You typically use fileprivate access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.

### private
Private access restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file.

### Conclusion
Open access is the highest (least restrictive) access level and private access is the lowest (most restrictive) access level.


Useful link:
[SE-0169](https://github.com/apple/swift-evolution/blob/master/proposals/0169-improve-interaction-between-private-declarations-and-extensions.md)
