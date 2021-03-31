import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageManager {
  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    // async 异步操作
    // sync 同步操作
    temporaryDirectory = await getTemporaryDirectory();
  }
}
