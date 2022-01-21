import 'package:flutter/material.dart';
import 'package:memo/database/db.dart';
import 'package:memo/database/memo.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method


class WritePage extends StatelessWidget {
  String title = '';
  String text = '';
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
              onPressed: saveDB,
              icon: const Icon(Icons.save)
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
              onChanged: (String title){this.title = title;},
                style: TextStyle(fontSize: 30),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            //obscureText: true,
              decoration: InputDecoration(
              //border: OutlineInputBorder(),
              hintText: '제목을 적어주세요.',
            ),
          ),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                onChanged: (String text){this.text = text;},
                keyboardType: TextInputType.multiline,
                maxLines: null,
                //obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '내용을 적어주세요.',
                ),
              ),
        ],
      ),
    ),);
  }

  Future<void> saveDB() async {
    DBHelper helper = DBHelper();

    var fido = Memo(
        id: Strtosha512(DateTime.now().toString()),
        title: title,
        text: text,
        createTime: DateTime.now().toString(),
        editTime: DateTime.now().toString()
    );

    await helper.insertMemo(fido);

    print(await helper.memos());
  }


  String Strtosha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
