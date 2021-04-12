import 'package:flutter/material.dart';

class NavigatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigatePageState();
  }
}

class NavigatePageState extends State<NavigatePage> {
  ValueNotifier<int> test;

  @override
  void initState() {
    test = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: test,
        builder: (_, value, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("数字${test.value}"), child],
            ),
          );
        },
        child:buildChild(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            test.value++;
          },
          child: Text('天')),
    );
  }

  Widget buildChild() {
    print("buildChild");
    return Container(
      width: 100,
      height: 200,
      color: Colors.blue,
    );
  }
}
