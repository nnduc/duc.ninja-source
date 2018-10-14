---
layout: post
title:  "Swift encoding and decoding"
date:   2017-09-24 19:02:34 +0700
key: 20170924
tags:
  - swift
  - tips
lang: en
---


## Encoding and decoding with Swift 4

Swift 4 lets you serialize your custom data types to JSON without writing any special code.

```javascript
// encoding.swift
struct Language: Codable {
    var name: String
    var version: Int
}

let swift = Language(name: "Swift", version: 4)
let php = Language(name: "PHP", version: 7)
let perl = Language(name: "Perl", version: 6)
```

You can see I've marked the `Language` struct as conforming to the `Codable` protocol. With that one tiny addition, we can convert it to a `Data` representation of JSON like this:

```javascript
// encoding.swift
let encoder = JSONEncoder()
if let encoded = try? encoder.encode(swift) {
    // save `encoded` somewhere
}
```

Swift will automatically encode all properties inside your data type – you don't need to do anything.

Now, if you're like me and have a long history of using `NSCoding`, you're probably somewhat doubtful: is that really all it takes, and how can we be sure it's working? Well, let's add some more code to try converting the `Data` object into a string so we can print it out, then decode it back into a new `Language` instance that we can read from:

```swift
// encoding.swift
if let encoded = try? encoder.encode(swift) {
    if let json = String(data: encoded, encoding: .utf8) {
        print(json)
    }

    let decoder = JSONDecoder()
    if let decoded = try? decoder.decode(Language.self, from: encoded) {
        print(decoded.name)
    }
}

```

Source:
- [hackingwithswift][hackingwithswift]

[hackingwithswift]: https://www.hackingwithswift.com/swift4
