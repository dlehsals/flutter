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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30, bottom: 20),
            child: Container(
                child: Text('메모하기',
                    style: TextStyle(fontSize: 36, color: Colors.black)),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(child: memobuilder())
        ],

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(
            builder: (context) => EditPage(),
          ),
          ).then((value) => setState(() {}));
        },
        tooltip: '메모를 추가하시려면 눌러주세요.',
        label: Text('메모추가'),
        icon: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  Future<List<Memo>> loadMemo() async {
    DBHelper helper = DBHelper();
    return await helper.memos();
  }
    Widget memobuilder() {
      return FutureBuilder(
        builder: (context, projectSnap) {
          if ((projectSnap.data as List).length == 0) {
            return Container(
                alignment: Alignment.center,
                child: Text("메모를 추가해주세요!\n\n\n\n\n\n\n"));
          }
          return ListView.builder(
            itemCount: (projectSnap.data as List).length,
            itemBuilder: (context, index) {
              Memo memo = (projectSnap.data as List)[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.amber,
                    width: 1
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: <Widget>[
                    Text(memo.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(memo.text),
                    Text("마지막으로 수정된 시간 : " + memo.createTime.split('.')[0],
                      style: TextStyle(
                        fontSize: 10
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        future: loadMemo(),
      );
    }
  }

