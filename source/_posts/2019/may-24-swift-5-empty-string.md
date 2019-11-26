---
layout: post
title: Empty Strings in Swift 5
date: 2019-05-24 08:13:00 +0700
tags:
---

How do you tell if a string is empty in Swift? That depends on what you mean by “empty”. You might mean a string with zero length, or maybe also an optional string that is nil. What about a “blank” string that only contains whitespace. Let’s see how to test for each of those conditions with Swift.

<!-- more -->

### Using isEmpty
A Swift `String` is a collection of characters and the `Collection` protocol already has a test for an empty collection:
```
var isEmpty: Bool { get }
```
We have access to the source code for `Collection.swift` in the standard library so we can see what this does:
```
public var isEmpty: Bool {
  return startIndex == endIndex
}
```
If the `startIndex` and `endIndex` of the collection are the same the collection is empty. Using this for a `String`:
```
"Hello".isEmpty  // false
"".isEmpty       // true
```
> Note: Use isEmpty rather than comparing count to zero which requires iterating over the entire string:
```
// Don't do this to test for empty
myString.count == 0
```
### What about whitespace?
Sometimes I want to test not only for an empty string but for a blank string. For example, I want a test that also returns true for each of these strings:
```
" "        // space
"\t\r\n"   // tab, return, newline
"\u{00a0}" // Unicode non-breaking space
"\u{2002}" // Unicode en space
"\u{2003}" // Unicode em space
```
I’ve seen people do this by first trimming whitespace from the string and then testing for empty. With Swift 5, we can make use of [0221-character-properties][0221-character-properties] to directly test for whitespace. We could write the test like this:
```
func isBlank(_ string: String) -> Bool {
  for character in string {
    if !character.isWhitespace {
        return false
    }
  }
  return true
}
```
That works but a simpler way to test all elements in a sequence is to use allSatisfy. Rewriting as an extension of String:
```
extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace })
  }
}
```
This is looking promising:
```
"Hello".isBlank        // false
"   Hello   ".isBlank  // false
"".isBlank             // true
" ".isBlank            // true
"\t\r\n".isBlank       // true
"\u{00a0}".isBlank     // true
"\u{2002}".isBlank     // true
"\u{2003}".isBlank     // true
```
### What about optional strings?
We can extend the solution to allow for optional strings. Here’s an extension to Optional where the wrapped element is a String:
```
extension Optional where Wrapped == String {
  var isBlank: Bool {
    return self?.isBlank ?? true
  }
}
```
Using optional chaining with a default value we return true if the optional string is nil else we test the String as before. We can now also write:
```
var title: String? = nil
title.isBlank            // true
title = ""
title.isBlank            // true
title = "  \t  "
title.isBlank            // true
title = "Hello"
title.isBlank            // false
```
Testing for a “blank” string iterates over the string so don’t use it when isEmpty is all you need.

Happy coding!
[Source: useyourloaf]

[character-properties]: https://github.com/apple/swift-evolution/blob/master/proposals/0221-character-properties.md
