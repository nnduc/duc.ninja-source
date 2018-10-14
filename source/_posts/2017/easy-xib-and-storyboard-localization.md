---
layout: post
title:  "Easy XIB and Storyboard Localization"
date:   2017-11-05 22:30:00 +0700
key: 20171105
tags:
  - xcode
  - tips
lang: en
---



![img](https://cdn-images-1.medium.com/max/1600/1*oFXeXtJ2LM8uB7prmtAZmw.jpeg)Photo by [freestocks.org](https://unsplash.com/photos/jUSu0686zDM) on [Unsplash](https://unsplash.com)

Localization is a key part of an application. In order to make it easy, maintainable and extensible it deserves a bit of effort and care.

But for iOS graphic interfaces made with Interface Builder, it becomes a bit tricky to accomplish those goals.

### Storyboard localization: what the heck!

Say we have a Storyboard with an interface like this:

![img](https://cdn-images-1.medium.com/max/1600/1*9hTd6a-GI-p5IJiTtcwfqw.png)

There are three controls suitable to be localized: the “Title” label, the “Information” label and the “Buy” button. We want to localize the UI in English and Spanish.

The classic strategy is to have two `Main.storyboard` files, one in a `en.lproj`folder and the other in a `es.lproj` folder. That sounds simple but it leads to a huge problem of maintenance as some change in the UI requires changing all the Storyboards. Imagine an app localized in more than two languages.

The second option is to tick “English — Localizable Strings” in the localization pane in the File inspector of the Storyboard; it creates a `strings` file called `Main.strings` located in the folder `en.lproj`. This file looks like this:

![img](https://cdn-images-1.medium.com/max/1600/1*AaeTIl9OwM9jR6VKwq6XOQ.png)

It has the usual syntax of a `strings` file, but the first thing you may notice is how the controls are identified. We have names like `Axl-vE-Aj2` for the “Title” label, or `cY0-hb-qiL` for the “Buy” button.

Well, it is a bit confusing, but we can move on and localize the UI to Spanish. We create the new Spanish Localization in the Configuration pane of the project and automatically Xcode creates a new `Main.strings` file inside the `es.lproj` folder. Let’s open that file and translate the texts to Spanish:

![img](https://cdn-images-1.medium.com/max/1600/1*AJMl0WFOOGvPRPWPTTKndQ.png)

It sounds pretty straightforward, but this workflow has a bunch of problems:

- If you change something in IB, the `strings` files are not updated. You have to use *ibtool* or *AppleGlot* to get it done. More about this [here](https://ayeohyes.wordpress.com/2015/07/24/localizing-storyboards-and-xibs/).
- The names of the controls are not in a human readable manner, not even if we have filled the “Label” property of the control (Identity Inspector > Document).
- There is no possibility to reuse localizations from other `.strings` files, or at least I did not find the way to refer to them.
  For example, given the usual `Localizable.strings` file, to make a reference with something like `cY0-hb-qiL.normalTitle = "${to_buy}"`.
- We have localizations dispersed in more than one file: one for the localizations in code (`Localizable.strings`) and another to localize IB files (`Main.strings`).
- Probably, we’ll have translations repeated in both files if we need to use it in code and IB.

So I give a thought to this, and after a couple of searches, I arrived to a [Stack Overflow answer](https://stackoverflow.com/a/21443515/191059) that pointed to a perfect solution to this: to use the **User Defined Runtime Attributes **that we can find at the Identity Inspector.

Let’s see how to achieve it.

------

### Step 1. Localizable protocols

The first step is to create a couple of very simple protocols.

`Localizable`, that we will use to get a localized string from another string used as the key:

```
protocol Localizable {
    var localized: String { get }
}
```

```
extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
```

And `XIBLocalizable`, that we will use to localize controls from an IB file:

```
protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
```

Now we have to implement this interface in those controls suitable to be localized:

```
extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
```

```
extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}
```

**NOTE**: `get` is irrelevant in this case, we are not going to need the name of the key used in the `Localizable.strings` file anywhere.

**NOTE 2**: in order to make this run on Swift 4 you have to add `@IBInspectable`to the `xibLocKey` implementation, else it will not work:

> Failed to set (xibLocKey) user defined inspected property on (UIButton): [<UIButton 0x7fb24a50dbc0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key xibLocKey.

### Step 2. Set the localization key in IB

The second step is to set, for each control, its associated localization key. We have two `Localizable.strings` files.

`en.lproj` file:

```
“title” = “Title”;
“info” = “Information”;
“to_buy” = “Buy”;
```

`es.lproj` file:

```
"title" = "Título";
"info" = "Información";
"to_buy" = "Comprar";
```

Now it is time to set these keys in IB. To do that we have to:

1. Select the control to be localized, for example the “Title” label.
2. Go to the Identity Inspector and add a new value to the *User Defined Runtime Attributes*. Fill it with `Key Path = xibLocKey` , `Type = String` and `Value = title` . It may look like this:

![img](https://cdn-images-1.medium.com/max/1600/1*lTVg9pCO35OzgY1oObi8Wg.png)

As our properties are `@IBInspectable` you can also fill the `xibLocKey` in the *Attributes Inspector:*

![img](https://cdn-images-1.medium.com/max/1600/1*ZDtR1ogbCU3zmUBmCZQ3YA.png)

That’s all! Repeat these steps with every control you want to localize and run the app to test it.

![img](https://cdn-images-1.medium.com/max/1600/1*YlzFrh9t24GWIFWcDgvQPQ.png)Left: iPhone 6 in Spanish; Right: iPhone SE in English

------

This is a very clever and simple solution, and it avoids two important flaws we will encounter in other solutions:

1. It is a great way to get rid of complicated workflows involving external tools.
2. It also encourages [DRY principle](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) to use localizations in code and Interface Builder without having the same translation in two different files.

You can find a example project in my [GitHub](https://github.com/emenegro/xib-localization).

Source: Mario Negro
