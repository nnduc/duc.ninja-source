---
layout: post
title:  Migrating to Swift 4
date:   2017-09-24  00:00:00
key: 20170924
tags:
  - swift
  - tips
lang: en
---


In the past, migrating your code was a big deal when a new version of Swift was introduced – when Swift 3 came around, it seemed like every line of code had a syntax change. This time around, however, life should be a lot easier on us – in fact maybe you’ll even see this nice message during your migration:

![](/assets/images/screenshot-2017-09-12-12-26-38.png)

Here’s what Chris Lattner said about it on the Accidental Tech Podcast:

> I think it’s definitely fair to say that in the Swift 1 and 2 timeframes, Swift as a language was changing really rapidly, and I could see why you’d feel like you’re on uneven footing and not really sure what the language is, much less what the idioms are. Swift 3 really is quite well baked out, and I expect that going forward the new things are going to be additive, not changing the existing patterns.

That said, as you update to Xcode 9, Swift 4 and iOS 11 you might find you need to make a few little tweaks – and not just related to Swift changes. I’ve been updating all of the code base for my book, and finding there are some repetitive tasks worth mentioning:

### Swift 3 `@objc` inference.

During migration, you’ll be asked if you want to minimize @objc inference (the new Swift 4 way of doing things) or handle @objc inference the Swift 3 way:

![](/assets/images/screenshot-2017-09-12-15-30-46.png)

What’s all this about?

You can tag a Swift declaration with @objc to indicate that it should be available to Objective-C. In Swift 3 many declarations were automatically inferred to be made available to Objective-C (for example methods in a subclass of NSObject were inferred to be available to Objective-C). In Swift 4, many of these are no longer going to be inferred and the migrater will help you out by adding the @objc tag in some common places it might be needed. (A common place for example, is a method that is referenced by a #selector)

For some reason, however, despite migrating your code to manage this new state of affairs, the migrater doubles down on ensuring that there are no migration problems, and sets a new ‘Swift 3 @objc inference’ setting in your targets’ Build Settings to ‘On’, ensuring that everything works just as it did in Swift 3.

This isn’t a big problem, other than increasing your app’s binary size (about 6-8% according to the swift-evolution proposal) and load time. But – if you want your app to work just like a new Swift 4 app would, change the ‘Swift 3 @objc inference’ setting in each target’s Build Settings to ‘Default’ (or ‘Off’).

![](/assets/images/screenshot-2017-09-12-15-38-47.png)

If you check out the Xcode migration guide, @objc inference is basically all it talks about. Most other Swift changes have been add-ons and non-breaking. There are however a couple of interface issues worth mentioning.

### Safe area guides

Xcode 9 and iOS 11 introduced safe area guides, with the idea of replacing top and bottom layout guides. This change isn’t enforced by the migrator, but if you want your app to work as a new project would, you’ll want to turn on safe area guides for your storyboards.

Open a storyboard, select a view controller, and open up the file inspector. You’ll find a new check box: “Use Safe Area Layout Guides”. Check this and immediately you’ll notice a change in the document outline of your storyboard. All of your view controllers will lose their top and bottom layout guides and be replaced by safe area guides.

![](/assets/images/safearea.png)

### Large titles

This is another optional update, but a good idea anyway. Apple is moving towards large titles for navigation bars and has made this available to developers. To give a view controller a large title, select the first navigation bar in the navigation stack, and select ‘Prefers Large Titles’ in the attributes inspector.

![](/assets/images/largetitles.png)


This automatically sets up large titles for the whole navigation stack, though Apple suggests in many cases the large titles are more appropriate for just the initial view controller. Turn off large titles in a view controller down the line in the navigation stack, by selecting its navigation item and instead of ‘Automatic’, select ‘Never’.

![](/assets/images/largetitlesnever.png)


### Marketing App icon

Previously we would add the huge 1024×1024 app icons for marketing purposes in iTunesConnect. Finally, Apple has united all of the app icons, and now these app icons can also be added to your app’s assets catalog.

Source:<br>&emsp;[craiggrummitt](https://craiggrummitt.com/2017/09/12/migrating-to-swift-4-ios-11/)


<!-- Lorem ipsum dolor sit amet consectetur, adipisicing elit. Modi laboriosam suscipit doloremque perspiciatis dolorem. Deleniti, iusto quos, laborum ullam animi maiores alias necessitatibus saepe vero tenetur aliquid accusantium ipsa totam!

Now, let's have a glance at the basic styles: [link](http://github.com/syaning/vida),
**strong**, *italic*, <del>deletion</del>, <ins>insertion</ins>.

<hr>

# Header 1

## Header 2

### Header 3

#### Header 4

##### Header 5

###### Header 6

- list item 1
- list item 2
- list item 3

1. list item 1
2. list item 2
3. list item 3

> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

![](/assets/images/image.png)

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Fruit</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Alex</td>
            <td>22</td>
            <td>Apple</td>
        </tr>
        <tr>
            <td>Bran</td>
            <td>20</td>
            <td>Orange</td>
        </tr>
        <tr>
            <td>Mike</td>
            <td>21</td>
            <td>Waltermelon</td>
        </tr>
    </tbody>
</table>

```javascript
// index.js
var arr = [1, 2, 3, 4, 5];
var b = arr.map(x => x * x);
console.log(b);
```

MathJax support:

$$ a^2 + b^2 = c^2 $$ -->
