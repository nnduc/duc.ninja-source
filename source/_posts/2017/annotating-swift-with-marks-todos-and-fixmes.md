---
layout: post
title:  "Annotating Swift with MARKs, TODO's and FIXME's"
date:   2017-09-25 23:02:34 +0700
key: 20170925
tags:
  - xcode
  - tips
lang: en
---

When **Swift** debuted, we said goodbye to using `#pragma` pre-processor definitions to organize our code. Don't worry, **Xcode** still has our backs. We can use a few different "special" comments in our code and **Xcode** will pick up on them and display them in its **jump bar**:

![](/assets/images/annotating-swift-with-marks-todos-and-fixmes.png)
<!-- more -->
The extra **dash** character in the name of our **MARK** gets us those *sweet* separators in the source navigator dropdown.

**Xcode** also supports a similar bit of functionality for **TODO** and **FIXME** comments. They'll show up in **bold** in the same dropdown.

```
func launch() {
  // TODO: launch here
}

func land() {
  // FIXME: shouldn't crash
}

```

As a bonus, we can use a little regex magic to get Xcode to generate build warnings for **TODO** and **FIXMEs**. We'll just add a new **Run Script** build phase to our project that contains:

```
KEYWORDS="TODO|FIXME|\?\?\?:|\!\!\!:"
find "${SRCROOT}" \( -name "*.swift" \) -print0 | \
xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | \
perl -p -e "s/($KEYWORDS)/ warning: \$1/"
```

Source: [jeffreysambells][jeffreysambells]

[jeffreysambells]: http://jeffreysambells.com/2013/01/31/generate-xcode-warnings-from-todo-comments

