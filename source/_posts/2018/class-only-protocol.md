---
layout: post
title: Swift 4 - Class only protocol
date: 2018-08-17 08:13:00 +0700
tags:
---

![](/assets/images/swift4.png)

We usually use the `class` keyword to define a `class only protocol` in the normal way.
```
protocol DetailViewControllerDelegate: class {
  func didFinishTask(sender: DetailViewController)
}
```

Since Swift 4, we have an other way to define it. Introduced in [0156-subclass-existentials][0156-subclass-existentials]

> This proposal merges the concepts of class and AnyObject, which now have the same meaning: they represent an existential for classes.

So, it much clearer with the new way:

```
protocol DetailViewControllerDelegate: AnyObject {
  func didFinishTask(sender: DetailViewController)
}
```

Happy coding!

[0156-subclass-existentials]: https://github.com/apple/swift-evolution/blob/master/proposals/0156-subclass-existentials.md
