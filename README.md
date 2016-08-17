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



`Demo`项目里面包含了`Script`的源码

源码在此[gist](https://gist.github.com/CodeEagle/44e4e379e7b93ee08afc76e30c719c25)

```bash
#!/bin/bash

# Generate UIImage extension for images assets, using in Xcode run script
base="$SRCROOT/${TARGET_NAME}"
assertPath="$base/Assets.xcassets"
fileName="$base/ImageResource.swift"
content="import UIKit\nextension UIImage {\n"

DealWithFile() {
  entry=$1
  IFS='/' read -r -a components <<< "$entry"
  for index in "${!components[@]}"
  do
    local item="${components[index]}"
    if [[ $item == *".imageset"* ]]
    then
      imageName=${item/.imageset/}
      seperator=""
      if [[ $imageName == *" "* ]]
      then
        seperator=" "
      fi
      if [[ $imageName == *"-"* ]]
      then
        seperator="-"
      fi
      if [[ $imageName == *"_"* ]]
      then
        seperator="_"
      fi
      if [[ $imageName == *"."* ]]
      then
        seperator="."
      fi
      IFS="$seperator" read -r -a vnames <<< "$imageName"
      cname=""
      for kk in "${!vnames[@]}"
      do
        name="${vnames[kk]}"
        if [ "$kk" == 0 ]
        then
          cname+=$(echo "$name" | awk '{print tolower($0)}')
        else
          cname+="$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1}"
        fi
      done
      content+="    static var luoo_$cname: UIImage {  return UIImage(named: \"$imageName\")! }\n"
    fi
  done
}
ImageResourceGenerator() {
  for entry in $1/*
  do
    if [[ -d $entry ]]
    then
      IFS='/' read -r -a components <<< "$entry"
      LENGTH=${#components[@]} # Get the length.
      LAST_POSITION=$((LENGTH - 1)) # Subtract 1 from the length.
      lastComponent=${components[${LAST_POSITION}]}
      if [[ $lastComponent == *"."* ]]
      then
        echo "deal file $entry"
        DealWithFile "$entry"
      else
        echo "deal dir $entry"
        ImageResourceGenerator "$entry"
      fi
    fi
  done
}

ImageResourceGenerator "$assertPath"
content+="}"
echo "// Generate By Code" | tee "$fileName"
echo -e "$content" >> "$fileName"

```
