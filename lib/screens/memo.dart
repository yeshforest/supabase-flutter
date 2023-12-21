import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({super.key});

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('memo'),
        leading: IconButton(onPressed: () {
          Navigator.pop(context,"UPDATE");
        } , icon: const Icon(Icons.chevron_left),),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('제목을 입력해주세요'),
                    TextField(
                      controller: titleController,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        '내용을 입력해주세요',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextField(
                        maxLines: 10,
                        controller: contentController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xffd9d9d9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed:setMemo,
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setMemo() async{
    String title = titleController.text;
    String content = contentController.text;
    // 데이터 삽입
    await supabase.from('memos').insert({'title':title,'content':content});

  }
}
