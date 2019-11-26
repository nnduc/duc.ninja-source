---
layout: post
title: Swift 5.1 Implicit returns and Default values for memberwise initializer
date: 2019-10-12 13:30:00 +0700
tags:
---

The release of `Swift 5.1` brought some useful polish to the language with minimal source breaking changes. Some of the bigger improvements like property wrappers and ordered collection diffing take some time to get your head around. Luckily there are also some quick hits that you can start using today.

<!-- more -->

Implicit returns
Many languages allow you to skip the return statement in a method. For example, a Ruby method returns the value of the last expression evaluated:

```ruby
# Ruby
class Person
  def greeting
    "Hello"
  end
end

joe = Person.new
puts joe.greeting  // "Hello"
```

`Swift 5.1` allows you to omit the return statement for functions (or closures) which are single expressions. For example, we can rewrite the following:

```swift
struct Person {
  func greeting() -> String {
    return "Hello"
  }
}
```

As this with Swift 5.1:

```swift
struct Person {
  func greeting() -> String {
    "Hello"
  }
}
```

You can only omit the return in Swift when the function is a single expression. So while the following is valid Ruby:

```ruby
# Ruby
def greeting
  if is_birthday?
    "Happy Birthday!"
  else
    "Hello"
  end
end
```

You cannot write the same in Swift. Unfortunately, in Swift the if conditional is a statement, not an expression so you need the return keywords:

```swift
struct Person {
  var isBirthday = false

  func greeting() -> String {
    if isBirthday {
      return "Happy Birthday"
    } else {
      return "Hello"
    }
  }
}
```

In this trivial case we can rewrite this as a single expression and again omit the return:

```swift
func greeting() -> String {
  isBirthday ? "Happy Birthday" : "Hello"
}
```

This also works well when the getter of a property is a single expression:

```swift
struct Person {
  var age = 0
  var formattedAge: String {
    NumberFormatter.localizedString(from: age as NSNumber,
                                  number: .spellOut)
  }
}
```

Default values for memberwise initializer
As Swift matures a number of the rough edges of the language are getting smoothed over. This change is another example of that. You probably know that a Swift struct gets a default initializer. For example, given this structure:

```swift
struct Country {
  var name: String
  var population: Int
  var visited: Bool
}

The compiler creates an initializer with parameters for each member of the structure:

```swift
let place = Country(name: "Antarctica", population: 0,
                    visited: false)
```

But what if our structure has default values like this:

```swift
struct Country {
  var name: String
  var population: Int = 0
  var visited: Bool = false
}
```

Unfortunately until `Swift 5.1` you couldn’t omit the default values from the initializer. You’d get a compiler error about missing arguments. It’s reasonable to want to use an initializer that assumes the default values like this:

```swift
let place = Country(name: "Antarctica")
```

That now works with Swift 5.1.

* Further Details
See the following Swift evolution proposal documentation for more details:

[SE-0255 Implicit returns from single-expression functions](https://github.com/apple/swift-evolution/blob/master/proposals/0255-omit-return.md)
[SE-0242 Synthesize default values for the memberwise initializer](https://github.com/apple/swift-evolution/blob/master/proposals/0242-default-values-memberwise.md)

Happy coding!
[Source: useyourloaf]
