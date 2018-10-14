---
layout: post
title:  "Dependency Injection examples with Swift 4"
date:   2017-11-05 21:16:00 +0700
key: 20171105
tags:
  - ios
  - swift
  - tips
  - til
lang: en
---


In [software engineering](https://en.wikipedia.org/wiki/Software_engineering), **dependency injection** is a technique whereby one object supplies the dependencies of another object. A dependency is an object that can be used (a [service](https://en.wikipedia.org/wiki/Service_(systems_architecture))). An injection is the passing of a dependency to a dependent object (a [client](https://en.wikipedia.org/wiki/Client_(computing))) that would use it.
<!-- more -->
The service is made part of the client's [state](https://en.wikipedia.org/wiki/State_(computer_science)).[[1\]](https://en.wikipedia.org/wiki/Dependency_injection#cite_note-JamesShore-1) Passing the service to the client, rather than allowing a client to build or [find the service](https://en.wikipedia.org/wiki/Service_locator_pattern), is the fundamental requirement of the pattern. - [Wikipedia](https://en.wikipedia.org/wiki/Dependency_injection).



### TL;DR.

![](/assets/images/di.png)

### Initializer injection

```swift
protocol Serializer {
    func serialize(data: Any) -> Data?
}

class RequestSerializer: Serializer {
    func serialize(data: Any) -> Data? {
        return nil
    }
}

class DataManager {
    var serializer: Serializer?

    init(serializer: Serializer) {
        self.serializer = serializer
    }
}

let serializer = RequestSerializer()
// DI
let dataManager = DataManager(serializer: serializer)

```



### Property injection

```swift
protocol Serializer {
    func serialize(data: Any) -> Data?
}

class RequestSerializer: Serializer {
    func serialize(data: Any) -> Data? {
        return nil
    }
}

class DataManager {
    var serializer: Serializer?
}

let dataManager = DataManager()

// DI
dataManager.serializer = RequestSerializer()


```



### Method Injection

```swift
protocol Request {}
protocol Serializer {}

class DataManager {
    func serializeRequest(_ request: Request, with serializer: Serializer) -> Data? {
        return nil
    }
}

```

