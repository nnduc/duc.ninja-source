---
layout: post
title:  "Passing Data Using NotificationCenter in Swift 4"
date:   2017-11-12 22:15:00 +0700
key: 20171112
tags:
  - ios
  - swift
  - tips
lang: en
---

Passing data from one view controller to another view controller using Notification Center is an easy way when compared to `delegate protocols`.

Here we need add `observer` or `listeners` for getting new data to load. First we need to send data using post notification method.
<!-- more -->


## Sending Data - Post Notification:

```
let dataToSend = ["name" : "John", "age" : 25] as [String : Any]
```

```
NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: dataToSend)
```



Before sending data we need to listen for the above notification using  `NSNotification.Name`

## Data Receiving - Add observer:



Add the following code for `listening` to new data:



```
NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: "newDataToLoad"), object: nil)
```

Add the following method to retrieve data:

```
@objc func notificationRecevied(notification: Notification) {
    let data = notification.object
}
```

## Remove Observer:



Don't forgot to remove observer on`viewWillDisappear()`as follow:



```
NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "newDataToLoad"), object: nil)
```

Source: iosrevisited
