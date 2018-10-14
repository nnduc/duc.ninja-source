---
layout: post
title:  "Use didSet during initialling an object in Swift 4"
date:   2017-11-04 14:00:00 +0700
key: 201
tags:
  - swift
  - tips
lang: en
---



By default `didSet` of a property  don't called during init, so we can use `defer` to fix that issue.


```swift
class VideoPlayerController: UIViewController {
    enum State {
        case idle
        case loading(URL, Data)
        case playing(Video)
    }

    var state = State.idle {
        didSet { updateVideoView() }
    }

    init(state initialState: State) {
        super.init(nibName: nil, bundle: nil)
        // By deferring the state assignment, our property observer is
        // invoked, so we don't need to call updateVideoView() manually.
        defer { state = initialState }
    }
}

```



