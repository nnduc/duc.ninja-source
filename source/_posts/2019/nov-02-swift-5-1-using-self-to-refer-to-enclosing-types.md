---
layout: post
title: Swift 5.1 Using Self to refer to enclosing types
date: 2019-11-02 13:15:00 +0700
tags:
---

Swift’s `Self` keyword (*or type, really*) has previously enabled us to dynamically refer to a type in contexts where the actual concrete type isn’t known — for example by referring to a protocol’s implementing type within a protocol extension:

<!-- more -->

Swift’s `Self` keyword (*or type, really*) has previously enabled us to dynamically refer to a type in contexts where the actual concrete type isn’t known — for example by referring to a protocol’s implementing type within a protocol extension:

```
extension Numeric {
    func incremented(by value: Self = 1) -> Self {
        return self + value
    }
}
```

While that’s still possible, the scope of `Self` has now been extended to also include concrete types — like enums, structs and classes — enabling us to use `Self` as a sort of alias referring to a method or property’s *enclosing* type, like this:

```
extension TextTransform {
    static var capitalize: Self {
        return TextTransform { $0.capitalized }
    }

    static var removeLetters: Self {
        return TextTransform { $0.filter { !$0.isLetter } }
    }
}
```

The fact that we can now use `Self` above, rather than the full `TextTransform` type name, is of course purely *syntactic sugar* — but it can help make our code a bit more compact, especially when dealing with long type names. We can even use `Self` inline within a method or property as well, further making the above code even more compact:

```
extension TextTransform {
    static var capitalize: Self {
        return Self { $0.capitalized }
    }

    static var removeLetters: Self {
        return Self { $0.filter { !$0.isLetter } }
    }
}
```

Besides referring to an enclosing type itself, we can now also use `Self` to access static members within an instance method or property — which is quite useful in situations when we want to reuse the same value across all instances of a type, such as the `cellReuseIdentifier` in this example:

```
class ListViewController: UITableViewController {
    static let cellReuseIdentifier = "list-cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: Self.cellReuseIdentifier
        )
    }
}
```

Again, we could’ve simply typed out `ListViewController` above when accessing our static property, but using `Self` does arguably improve the readability of our code — and will also enable us to rename our view controller without having to update the way we access its static members. https://github.com/apple/swift-evolution/blob/master/proposals/0242-default-values-memberwise.md)

Happy coding!
