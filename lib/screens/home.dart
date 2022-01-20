import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit.dart';
import 'package:memo/database/db.dart';
import 'package:memo/database/memo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text('메모하기',
              style: TextStyle(fontSize: 36, color: Colors.blue))),
          Expanded(child: memobuilder())
        ],

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        tooltip: '메모를 추가하시려면 눌러주세요.',
        label: Text('메모추가'),
        icon: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> LoadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(
      color: Colors.blue,
      height: 100,
    ));
    memoList.add(Container(
      color: Colors.red,
      height: 100,
    ));
    memoList.add(Container(
      color: Colors.yellow,
      height: 100,
    ));
    memoList.add(Container(
      color: Colors.amber,
      height: 100,
    ));

    return memoList;
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper helper = DBHelper();
    return await helper.memos();
  }
    Widget memobuilder() {
      return FutureBuilder(
        builder: (context, projectSnap) {
          if ((projectSnap.data as List).length == 0) {
            return Container(child: Text("메모를 추가해주세요!"));
          }
          return ListView.builder(
            itemCount: (projectSnap.data as List).length,
            itemBuilder: (context, index) {
              Memo memo = (projectSnap.data as List)[index];
              return Column(
                children: <Widget>[
                  Text(memo.title),
                  Text(memo.text),
                  Text(memo.createTime)
                ],
              );
            },
          );
        },
        future: loadMemo(),
      );
    }
  }

