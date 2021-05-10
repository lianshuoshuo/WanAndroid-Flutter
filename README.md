> giao窝里giao，许久不见，甚是想念。各位客官，走过路过千万不要错过。
</br>

自从19年发了一篇[flutter路由框架fluro](https://www.jianshu.com/p/1987cc9b714a)之后就再也没有动态了，哈哈，因为毕业后忙于android开发工作实在没时间去搞flutter了。
</br>
 ![image.png](https://upload-images.jianshu.io/upload_images/14349345-c073990864228344.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)</br>
![](https://upload-images.jianshu.io/upload_images/14349345-3737476329ab00d6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/220)
</br>

年后回来，榨干了我的咸鱼时间，重新捡回了flutter。通过不断的深夜学习，利用我那久经‘沙场’的双手,终于完成了完整的flutter项目。话不多说直接上图。奥利给！！！</br>

![202105101401472802.jpg](https://upload-images.jianshu.io/upload_images/14349345-a44dd6863a1c41ad.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/840)

![two.jpg](https://upload-images.jianshu.io/upload_images/14349345-7d64968f80e8f127.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/840)

![3.jpg](https://upload-images.jianshu.io/upload_images/14349345-2512f71e5e18065d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/840)</br>
项目的基本界面就在上面了，具体的可以下载demo体验!</br>
[点我下载](http://d.firim.top/lhpt)
![image.png](https://upload-images.jianshu.io/upload_images/14349345-6f48f5338c02f3fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/240)</br>
本demo框架模式采用的是mvvm+provider实现的，mvvm相信各位Android客官已经有所了解，provider是flutter用来管理页面状态的，我们用它来做数据层与页面之间的状态管理，多余的不多介绍了,不懂的可以去查看[provider官方文档](https://pub.dev/packages/provider)介绍。

# 采用的三方库
```
#状态管理
  provider: ^4.1.2
  #网络请求
  dio: ^3.0.10
  #cookie管理
  dio_cookie_manager: ^1.0.0
  cookie_jar: ^1.0.1
  #路径
  path_provider: ^2.0.1
  #刷新组件
  flutter_easyrefresh: ^2.2.1
  #toast
  fluttertoast: ^4.0.0
  #本地存储
  shared_preferences: ^2.0.5
  # 本地json对象存储
  localstorage: ^4.0.0+1
  #时间格式
  date_format: ^1.0.8
  #缓存图片
  cached_network_image: ^2.3.1
  #webview
  webview_flutter: ^2.0.4
  # 谁用谁闪亮
  shimmer: ^1.1.1
  # 加载动画
  loading_indicator_view: ^1.1.0
  #自适应大小text
  auto_size_text: ^2.1.0
  #点赞按钮
  like_button: ^2.0.2
  #flare动画
  flare_flutter: ^3.0.0
  rive: ^0.7.8
  #显示html标签
  flutter_html_rich_text: ^1.0.0
  #数据库
  sqflite: ^1.3.0
```
# 参考
- 鸿洋大神的玩Android API
- 后续理出
