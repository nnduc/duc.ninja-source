---
layout: post
title:  "Convert Between UTC and Device Timezone in Swift 4"
date:   2017-10-22 20:16:34 +0700
key: 20171022
tags:
  - swift
  - tips
lang: en
---

In this article we are going to convert **UTC Date** format to **Current device date format**.

**UTC** is the time standard commonly used across the world. The world's timing centers have agreed to keep their time scales closely synchronized - or coordinated - therefore the name **Coordinated Universal Time**.
<!-- more -->
## UTC to Local:


Use the following method for converting:
```swift
func UTCToLocal(UTCDateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Input Format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
    let UTCDate = dateFormatter.date(from: UTCDateString)
    dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss" // Output Format
    dateFormatter.timeZone = TimeZone.current
    let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
    return UTCToCurrentFormat
}
```
Usage:

Call above method as follow:
```swift
let dateString = "2017-10-10 9:56:25"
let date = self.UTCToLocal(UTCDateString: dateString)
```
//output date should be `'2017-10-10 15:26:25'`
In above method we can customize date formats as per our usage. But the input date format must be same format as input date string.

## Local to UTC:
Use the following method for converting:
```swift
func localToUTC(date:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.calendar = NSCalendar.current
    dateFormatter.timeZone = TimeZone.current

    let dt = dateFormatter.date(from: date)
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss"

    return dateFormatter.string(from: dt!)
}
```
Usage:

Call above method as follow:
```swift
let dateString = "2017-10-10 15:56:25"
let date = self.localToUTC(date: dateString)
```
//output date should be `'2017-10-10 09:26:25'`



Source: [iosrevisited](https://iosrevisited.blogspot.in/2017/10/convert-utc-local-swift4.html)


