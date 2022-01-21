import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/database/memo.dart';
import 'package:memo/database/db.dart';

class ViewPage extends StatelessWidget {
  ViewPage({Key? key, required this.id}) : super(key: key);

  String id = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.edit)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: LoadBuilder()
      ),);
  }

  Future<List<Memo>> loadMemo(String id) async{
    DBHelper helper = DBHelper();
    return await helper.findMemo(id);
  }

  LoadBuilder() {
    return FutureBuilder<List<Memo>>(
        future: loadMemo(id),
        builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot){
          if ((snapshot.data as List).length == 0) {
            return Container(
            alignment: Alignment.center,
            child: Text("데이터를 불러올 수 없습니다!\n\n\n\n\n\n\n"));
          }else{
            Memo memo = snapshot.data![0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 100,
                  child: SingleChildScrollView(
                    child:Text(memo.title,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(child: SingleChildScrollView(
                  child: Text(memo.text)),
                )
              ],
            );
          }
      }
    );
  }
}
