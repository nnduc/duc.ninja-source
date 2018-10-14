---
layout: post
title:  "More Interface Builder Tips And Tricks"
date:   2018-03-04 22:56:00 +0700
key: 20180304
tags:

---


My top ten tips, tricks, dos and don’ts to make you feel like an Interface Builder expert.


- To easily select an object when it is behind a stack of other items hold down the Ctrl (⌃) + Shift (⇧) keys and then click over the object. Select the item you want from the popup menu showing the full view hierarchy at the point where you clicked.

![](/assets/images/ib-tips/ib-tips001.png)

- Click on a view in the canvas to select it and then hold down the Option (⌥) key. Move the mouse pointer over other views in the scene to see the distances between the views:

![](/assets/images/ib-tips/ib-tips002.png)

- To quickly copy an object in the canvas, hold down the Option (⌥) key and then click on and drag the object.

- When adjusting the position of a view in the canvas the arrow keys move the view by one point at a time. Hold down the Shift (⇧) key to jump by 5 points at a time.

- When creating constraints in the canvas or document outline use the Shift (⇧) key to select multiple constraints:

![](/assets/images/ib-tips/ib-tips003.png)

Use the Option (⌥) key for alternate constraints. Useful when you want the margins instead of the safe area or a 1:1 aspect ratio:

![](/assets/images/ib-tips/ib-tips004.png)

- There are some useful options for the canvas in the Xcode Editor menu.

![](/assets/images/ib-tips/ib-tips005.png)

I like to turn on either Show Layout Rectangles or Show Bounds Rectangles to see the layout guides or bounds of views.

If you are fighting with constraint priorities try turning on Show Intrinsic Size Constraints Contributing To Ambiguity. It makes it easier to see which priorities you need to change to fix the problem:

![](/assets/images/ib-tips/ib-tips006.png)

- Don’t let your Storyboards get too large. Interface Builder slows down and if you are collaborating with other developers it gets harder to avoid conflicts. Use Editor > Refactor To Storyboard to break it into smaller scenes with storyboard references. See Refactoring with Storyboard References.

![](/assets/images/ib-tips/ib-tips007.png)

- Don’t trust Interface Builder to Reset to Suggested Constraints. It will rarely do what you want.

- Use command-equal (⌘=) to quickly resize a label, button, image, etc. to fit the content size. For example, this label is too small and high for the text:

![](/assets/images/ib-tips/ib-tips008.png)

After using ⌘= to size to fit contents:

![](/assets/images/ib-tips/ib-tips009.png)

- Don’t forget you can preview your layout on different devices and orientations in Interface Builder with the assistant editor. This is much faster than launching the simulator or running on a device. Use the + in the bottom left corner of the assistant editor to add devices.

![](/assets/images/ib-tips/ib-tips010.png)

You can add multiple assistant editors with the + in the top right corner of the assistant editor. I like to use this to preview layouts with different localizations. Change the localization with the menu in the bottom right corner.



