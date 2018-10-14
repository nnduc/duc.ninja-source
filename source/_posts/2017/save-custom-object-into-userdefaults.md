---
layout: post
title:  "Save custom objects into UserDefaults(Swift 4)"
date:   2017-11-07 21:47:00 +0700
key: 20171107
tags:
  - ios
  - tips
  - swift
lang: en
---

We have many ways to store and retrieve persistent data in iOS but let try to store a custom object into `UserDefaults` with `Codable` in Swift 4.
<!-- more -->
We have a custom object like this:

```swift
struct User: Codable {
    var id: String
    var name: String
    var age: Int
}
```

And now, let define a object:

```swift
let user = User(id: "abc123", name: "Tim can Cook", age: 13)
```

Finally, we have to encode it using `JSONEncoder` then it can be persist into UserDefaults.

```swift
let kUser = "kUser"

if let encoded = try? JSONEncoder().encode(user) {
    UserDefaults.standard.set(encoded, forKey: "kUser")
}

if let userData = UserDefaults.standard.data(forKey: "kUser"),
    let user = try? JSONDecoder().decode(User.self, from: userData) {

    dump(user)
}

```

Now you can see the log on the console:

```bash
▿ __lldb_expr_10.User
  - id: "ABCD1234"
  - name: "Tim can Cook"
  - age: 13

```

That's it! You can download the  [**final playground file here.**](https://github.com/ducito/CustomObjectWithUserDefaults/archive/master.zip)
