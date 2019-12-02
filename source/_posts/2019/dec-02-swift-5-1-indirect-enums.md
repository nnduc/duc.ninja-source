---
layout: post
title: Swift 5.1 Indirect Enums
date: 2019-12-02 08:30:00 +0700
tags:
---

Indirect enums are enums that need to reference themselves somehow, and are called “indirect” because they modify the way Swift stores them so they can grow to any size. Without the indirection, any enum that referenced itself could potentially become infinitely sized: it could contain itself again and again, which wouldn’t be possible.

<!-- more -->

As an example, here’s an indirect enum that defines a node in a linked list:

```swift
indirect enum LinkedListItem<T> {
    case endPoint(value: T)
    case linkNode(value: T, next: LinkedListItem)
}
```

Because that references itself – because one of the associated values is itself a linked list item – we need to mark the enum as being indirect.

Apart from the special way they store their values internally, indirect enums work identically to regular enums. So, we could make a linked list using that enum and loop over it, like this:

```swift
let third = LinkedListItem.endPoint(value: "Third")
let second = LinkedListItem.linkNode(value: "Second", next: third)
let first = LinkedListItem.linkNode(value: "First", next: second)

var currentNode = first

listLoop: while true {
    switch currentNode {
    case .endPoint(let value):
        print(value)
        break listLoop
    case .linkNode(let value, let next):
        print(value)
        currentNode = next
    }
}
```

Happy coding!

[Source: hackingwithswift]
