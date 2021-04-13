import 'package:flutter/material.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage> {
  Matrix4 _matrix4;
  double y = 0;

  @override
  void initState() {
    _matrix4 = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _matrix4 = Matrix4.translationValues(0, y, 0);
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Transform(
              transform: _matrix4,
              child: Container(
                color: Colors.grey,
                width: 100,
                height: 100,
              ),
            ),
            Slider(
                min: -100,
                max: 100,
                value: y,
                onChanged: (v) {
                  setState(() {
                    y = v;
                  });
                }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.black26,
                ),
                // MediaQuery.removeViewPadding(
                //     context: context,
                //     child: Text(
                //       '搜索更多',
                //       // style: TextStyle(fontSize: 16, color: Colors.black26),
                //     )),
                Text(
                  '搜索更多',
                  // style: TextStyle(fontSize: 16, color: Colors.black26),
                )
              ],
            ),
            Center(
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black26,
                  ),
                  MediaQuery.removeViewPadding(
                      context: context,
                      child: Text(
                        '搜索更多',
                        style: TextStyle(fontSize: 17, color: Colors.black26),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
