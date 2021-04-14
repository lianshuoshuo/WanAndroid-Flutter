import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/app/GlobalConfig.dart';
import 'package:flutter_wanandroid/app/router/routers.dart';
import 'package:flutter_wanandroid/entity/mine_item.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  List<MainItemViewBean> itemList1 = [
    MainItemViewBean(
        title: '我的积分',
        img: Icons.monetization_on,
        url: 'fl://jifen',
        iconTextColors: 0xfffdb933),
    MainItemViewBean(
        title: '我的收藏',
        img: Icons.collections,
        url: 'fl://collect',
        iconTextColors: 0xffffd400),
    MainItemViewBean(
        title: '我的文章',
        img: Icons.menu_book,
        url: 'fl://works',
        iconTextColors: 0xff33a3dc),
    MainItemViewBean(
        title: '历史记录',
        img: Icons.history,
        url: 'fl://history_record',
        iconTextColors: 0xff666666),
    MainItemViewBean(
        title: '设置',
        img: Icons.settings,
        url: 'fl://setting',
        iconTextColors: 0xff666666),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '我',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              margin: EdgeInsets.only(top: 10),
              height: 100,
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  if (GlobalConfig.userModel.hasUser) {
                    Navigator.of(context).pushNamed(routers.LOGIN);
                  } else {
                    Navigator.of(context).pushNamed(routers.LOGIN);
                  }
                },
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        GlobalConfig.userModel.hasUser
                            ? GlobalConfig.USER_AVATAR
                            : GlobalConfig.DEFAULT_AVATAR,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        GlobalConfig.userModel.hasUser
                            ? GlobalConfig.userModel.user.username
                            : "登录/注册",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.black54,
                    )
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) {
                  return index == 2
                      ? Divider(
                          height: 10,
                          thickness: 10,
                          color: Color(0xfff8f8f8),
                        )
                      : Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xfff8f8f8),
                        );
                },
                itemCount: itemList1.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      itemList1[index].title,
                      style: TextStyle(fontSize: 15),
                    ),
                    leading: Icon(
                      itemList1[index].img,
                      color: Color(itemList1[index].iconTextColors),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
