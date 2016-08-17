ImageResourceGenerator
===
本项目基于 [@nixzhu](https://twitter.com/nixzhu) 的文章 [能偶尔用上的 awk](https://github.com/nixzhu/dev-blog/blob/master/2016-08-11-awk.md) 改进而来

用文章里的代码能在命令行生成
```swift
static var xxx_bubbleBody: UIImage {
    return UIImage(named: "bubble_body")!
}

static var xxx_bubbleLeftTail: UIImage {
    return UIImage(named: "bubble_left_tail")!
}

static var xxx_bubbleRightTail: UIImage {
    return UIImage(named: "bubble_right_tail")!
}
```
但是，需要手动的，没法确保每次能同步更新的资源

所以基于该思想，写了个`Xcode`的 `Run Script`,每次`build`的时候去生成这个资源文件



⚠️Warning
===
Assets 的子目录名不能有空格，否则解析不能(待解决)

Source
===
`Demo`项目里面包含了`Script`的源码

源码在此[gist](https://gist.github.com/CodeEagle/44e4e379e7b93ee08afc76e30c719c25)
