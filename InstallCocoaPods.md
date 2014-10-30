# 在CocoaPod中安装BmobSDK

## 安装CocoaPods
 
   当你开发iOS应用时，会经常使用到很多第三方开源类库，比如JSONKit，AFNetWorking等等。可能某个类库又用到其他类库，所以要使用它，必须得另外下载其他类库，而其他类库又用到其他类库，“子子孙孙无穷尽也”，这也许是比较特殊的情况。总而言之，手动一个个去下载所需类库十分麻烦。另外一种常见情况是，你项目中用到的类库有更新，你必须得重新下载新版本，重新加入到项目中，十分麻烦。如果能有什么工具能解决这些恼人的问题，那将“善莫大焉”。所以，你需要 CocoaPods。

   CocoaPods是iOS最常用最有名的类库管理工具，上述两个烦人的问题，通过cocoaPods，只需要一行命令就可以完全解决。

   在安装CocoaPods时不要直接执行 `sudo gem install cocoapods` 命令，因为`cocoapods.org`被墙了。我们可以使用淘宝的Ruby镜像来访问CocoaPods，安装CocoaPods的过程如下：

```
$ sudo gem sources --remove https://rubygems.org/
//等有反应之后再敲入以下命令
$ sudo gem sources -a http://ruby.taobao.org/
$ sudo gem install cocoapods

```

安装完成之后，命令行终端应该是如下的效果：

![](images/install.png)

如果在安装CocoaPods的过程中有任何问题，可以查看文档：http://code4app.com/article/cocoapods-install-usage

## 安装BmobSDK

在你的项目的根目录中新建一个 `Podfile` 文件，添加内容如下：

```
pod 'BmobSDK'
```

如下图所示：

![](images/podfile.png)


终端命令行（使用 `cd` 命令）进入到要使用Bmob的iOS项目的根目录中，执行如下命令安装SDK：

```
pod install
```

安装完成之后，你就可以在项目中使用BmobSDK开发了。

需要注意的是:如果提示缺少类库，需要添加libz.1.2.5.dylib、libicucore.dylib
