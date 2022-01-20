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
  String deleteId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30, bottom: 20),
            child: Container(
                padding: EdgeInsets.all(5),
                child: Text('NotePad',
                    style: TextStyle(fontSize: 36, color: Colors.black)),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(child: memobuilder(context))
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

  Future<void> deleteMemo(String id) async {
    DBHelper helper = DBHelper();
    await helper.deleteMemo(id);
  }
  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('메모삭제'),
          content: Text("정말 메모를 삭제하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                   deleteMemo(deleteId);
                });
                deleteId = '';
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "취소");
                deleteId = '';
              },
            ),
          ],
        );
      },
    );
  }

    Widget memobuilder(BuildContext parentcontext) {
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
              return InkWell(
                onTap: (){},
                onLongPress: (){
                  deleteId = memo.id;
                   showAlertDialog(parentcontext);
                },
                child: Container(
                  padding: EdgeInsets.all(13),
                  margin: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  height: 80,
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
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:[
                            Text(memo.title,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(memo.text),
                          ]
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("마지막으로 수정된 시간 : " + memo.createTime.split('.')[0],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        future: loadMemo(),
      );
    }
  }

