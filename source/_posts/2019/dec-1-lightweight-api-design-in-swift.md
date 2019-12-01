---
layout: post
title: Lightweight API design in Swift
date: 2019-12-01 10:30:00 +0700
tags:
---

One of the most powerful aspects of `Swift` is just how much flexibility it gives us when it comes to how APIs can be designed. Not only does that flexibility enable us to define functions and types that are easier to understand and use — it also lets us create APIs that give a very lightweight first impression, while still progressively disclosing more power and complexity if needed.

Let’s take a look at some of the core language features that enable those kind of lightweight APIs to be created, and how we can use them to make a feature or system much more capable through the power of composition.

<!-- more -->

## [A trade-off between power and ease of use](#a-trade-off-between-power-and-ease-of-use)

Often when we design how our various types and functions will interact with each other, we have to find some form of balance between power and ease of use. Make things too simple, and they might not be flexible enough to enable our features to continuously evolve — but on the other hand, too much complexity often leads to frustration, misunderstandings, and ultimately bugs.

As an example, let’s say that we’re working on an app that lets our users apply various filters to images — for example to be able to edit photos from their camera roll or library. Each filter is made up of an array of image transforms, and is defined using an `ImageFilter` struct, that looks like this:

```swift
struct ImageFilter {
    var name: String
    var icon: Icon
    var transforms: [ImageTransform]
}
```

When it comes to the `ImageTransform` API, it’s currently modeled as a protocol, which is then conformed to by various types that implement our individual transform operations:

```swift
protocol ImageTransform {
    func apply(to image: Image) throws -> Image
}

struct PortraitImageTransform: ImageTransform {
    var zoomMultiplier: Double

    func apply(to image: Image) throws -> Image {
        ...
    }
}

struct GrayScaleImageTransform: ImageTransform {
    var brightnessLevel: BrightnessLevel

    func apply(to image: Image) throws -> Image {
        ...
    }
}
```

One core advantage of the above approach is that, since each transform is implemented as its own type, we’re free to let each type define its own set of properties and parameters — such as how `GrayScaleImageTransform` accepts a `BrightnessLevel` to use when turning an image into grayscale.

We can then combine as many of the above types as we wish in order to form each filter — for example one that gives an image a bit of a *“dramatic”* look through a series of transforms:

```swift
let dramaticFilter = ImageFilter(
    name: "Dramatic",
    icon: .drama,
    transforms: [
        PortraitImageTransform(zoomMultiplier: 2.1),
        ContrastBoostImageTransform(),
        GrayScaleImageTransform(brightnessLevel: .dark)
    ]
)
```

So far so good — but if we take a closer look at the above API, it can definitely be argued that we’ve chosen to optimize for power and flexibility, rather than for ease of use. Since each transform is implemented as an individual type, it’s not immediately clear what kind of transforms that our code base contains, since there’s no single place in which they can all be instantly discovered.

Compare that to if we would’ve chosen to use an enum to model our transforms instead — which would’ve given us a very clear overview of all possible options:

```swift
enum ImageTransform {
    case portrait(zoomMultiplier: Double)
    case grayScale(BrightnessLevel)
    case contrastBoost
}
```

Using an enum would’ve also resulted in very nice and readable call sites — making our API feel much more lightweight and easy to use, since we would’ve been able to construct any number of transforms using *dot-syntax*, like this:

```swift
let dramaticFilter = ImageFilter(
    name: "Dramatic",
    icon: .drama,
    transforms: [
        .portrait(zoomMultiplier: 2.1),
        .contrastBoost,
        .grayScale(.dark)
    ]
)
```

However, while Swift enums are a fantastic tool in many different situations, this isn’t really one of them.

Since each transform needs to perform vastly different image operations, using an enum in this case would’ve forced us to write one massive `switch` statement to handle each and every one of those operations — which would most likely become somewhat of a nightmare to maintain.

## [Light as an enum, capable as a struct](#light-as-an-enum-capable-as-a-struct)

Thankfully, there’s a third option — which sort of gives us the best of both worlds. Rather than using either a protocol or an enum, let’s instead use a struct, which in turn will contain a closure that encapsulates a given transform’s various operations:

```swift
struct ImageTransform {
    let closure: (Image) throws -> Image

    func apply(to image: Image) throws -> Image {
        try closure(image)
    }
}
```

Note that the `apply(to:)` method is no longer required, but we still add it both for backward compatibility, and to make our call sites read a bit nicer.

With the above in place, we can now use static factory methods and properties to create our transforms — each of which can still be individually defined and have its own set of parameters:

```swift
extension ImageTransform {
    static var contrastBoost: Self {
        ImageTransform { image in
            ...
        }
    }

    static func portrait(withZoomMultipler multiplier: Double) -> Self {
        ImageTransform { image in
            ...
        }
    }

    static func grayScale(withBrightness brightness: BrightnessLevel) -> Self {
        ImageTransform { image in
            ...
        }
    }
}
```

That `Self` can now be used as a return type for static factory methods is one of the small but significant improvements introduced in Swift 5.1.

The beauty of the above approach is that we’re back to the same level of flexibility and power that we had when defining `ImageTransform` as a protocol, while still being able to use a more or less identical dot-syntax as when using an enum:

```swift
let dramaticFilter = ImageFilter(
    name: "Dramatic",
    icon: .drama,
    transforms: [
        .portrait(withZoomMultipler: 2.1),
        .contrastBoost,
        .grayScale(withBrightness: .dark)
    ]
)
```

The fact that dot syntax isn’t tied to enums, but can instead be used with any sort of static API, is incredibly powerful — and even lets us encapsulate things one step further, by modeling the above filter creation as a computed static property as well:

```swift
extension ImageFilter {
    static var dramatic: Self {
        ImageFilter(
            name: "Dramatic",
            icon: .drama,
            transforms: [
                .portrait(withZoomMultipler: 2.1),
                .contrastBoost,
                .grayScale(withBrightness: .dark)
            ]
        )
    }
}
```

The result of all of the above is that we can now take a really complex series of tasks — applying image filters and transforms — and encapsulate them into an API that, on the surface level, appears as lightweight as simply passing a value to a function:

```swift
let filtered = image.withFilter(.dramatic)
```

While it’s easy to dismiss the above change as purely adding *”syntactic sugar”*, we haven’t only improved the way our API reads, but also the way in which its parts can be composed. Since all transforms and filters are now just values, they can be combined in a huge number of ways — which doesn’t only make them more lightweight, but also much more flexible as well.

## [Variadic parameters and further composition](#variadic-parameters-and-further-composition)

Next, let’s take a look at another really interesting language feature — variadic parameters — and what kind of API design choices that they can unlock.

Let’s now say that we’re working on an app that uses shape-based drawing in order to create parts of its user interface, and that we’ve used a similar struct-based approach as above in order to model how each shape is drawn into a `DrawingContext`:

```swift
struct Shape {
    var drawing: (inout DrawingContext) -> Void
}
```

Above we use the `inout` keyword to enable a value type (`DrawingContext`) to be passed as if it was a reference. For more on that keyword, and value semantics in general, check out Utilizing value semantics in Swift.

Just like how we enabled `ImageTransform` values to be easily created using static factory methods before, we’re now also able to encapsulate each shape’s drawing code within completely separate methods — like this:

```swift
extension Shape {
    func square(at point: Point, sideLength: Double) -> Self {
        Shape { context in
            let origin = point.movedBy(
                x: -sideLength / 2,
                y: -sideLength / 2
            )

            context.move(to: origin)
            context.drawLine(to: origin.movedBy(x: sideLength))
            context.drawLine(to: origin.movedBy(x: sideLength, y: sideLength))
            context.drawLine(to: origin.movedBy(y: sideLength))
            context.drawLine(to: origin)
        }
    }
}
```

Since each shape is simply modeled as a value, drawing arrays of them becomes quite easy — all we have to do is to create an instance of `DrawingContext`, and then pass that into each shape’s closure in order to build up our final image:

```swift
func draw(_ shapes: [Shape]) -> Image {
    var context = DrawingContext()

    shapes.forEach { shape in
        context.move(to: .zero)
        shape.drawing(&context)
    }

    return context.makeImage()
}
```

Calling the above function also looks quite elegant, since we’re again able to use dot syntax to heavily reduce the amount of syntax needed to perform our work:

```
let image = draw([
    .circle(at: point, radius: 10),
    .square(at: point, sideLength: 5)
])
```

However, let’s see if we can take things one step further using variadic parameters. While not a feature unique to Swift, when combined with Swift’s really flexible parameter naming capabilities, using variadic parameters can yield some really interesting results.

When a parameter is marked as variadic (by adding the `...` suffix to its type), we’re essentially able to pass any number of values to that parameter — and the compiler will automatically organize those values into an array for us, like this:

```
func draw(_ shapes: Shape...) -> Image {
    ...
    // Within our function, 'shapes' is still an array:
    shapes.forEach { ... }
}
```

With the above change in place, we can now remove all of the array literals from the calls to our `draw` function, and instead make them look like this:

```
let image = draw(.circle(at: point, radius: 10),
                 .square(at: point, sideLength: 5))
```

That might not seem like such a big change, but especially when designing more lower-level APIs that are intended to be used to create more higher-level values (such as our `draw` function), using variadic parameters can make those kind of APIs feel much more lightweight and convenient.

However, one drawback of using variadic parameters is that an array of pre-computed values can no longer be passed as a single argument. Thankfully, that can quite easily be fixed in this case, by creating a special `group` shape that — just like the `draw` function itself — iterates over an array of underlying shapes and draws them:

```
extension Shape {
    static func group(_ shapes: [Shape]) -> Self {
        Shape { context in
            shapes.forEach { shape in
                context.move(to: .zero)
                shape.drawing(&context)
            }
        }
    }
}
```

With the above in place, we can now once again easily pass a group of pre-computed `Shape` values to our `draw` function, like this:

```
let shapes: [Shape] = loadShapes()
let image = draw(.group(shapes))
```

What’s really cool though, is that not only does the above `group` API enable us to construct arrays of shapes — it also enables us to much more easily compose multiple shapes into more higher-level components. For example, here’s how we could express an entire drawing (such as a logo), using a group of composed shapes:

```
extension Shape {
    static func logo(withSize size: Size) -> Self {
        .group([
            .rectangle(at: size.centerPoint, size: size),
            .text("The Drawing Company", fittingInto: size),
            ...
        ])
    }
}
```

Since the above logo is a `Shape` just like any other, we can easily draw it with a single call to our `draw` method, using the same elegant dot syntax as we used before:

```
let logo = draw(.logo(withSize: size))
```

What’s interesting is that while our initial goal might’ve been to make our API more lightweight, in doing so we also made it more composable and more flexible as well.

## [Conclusion](#conclusion)

The more tools that we add to our *“API designer’s toolbox”*, the more likely it is that we’ll be able to design APIs that strike the right balance between power, flexibility and ease of use.

Making APIs as lightweight as possible might not be our ultimate goal, but by trimming our APIs down as much as we can, we also often discover how they can be made more powerful — by making the way we create our types more flexible, and by enabling them to be composed. All of which can aid us in achieving that perfect balance between simplicity and power.

Happy coding!

[Source: swiftbysundell]
