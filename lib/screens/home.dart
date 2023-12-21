import 'package:flutter/material.dart';
import 'package:memo_app/model/memo_model.dart';
import 'package:memo_app/screens/memo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MemoModel>> memoList;
  final supabase = Supabase.instance.client;


  @override
  void initState() {
    memoList = getAllMemo();
    super.initState();
  }

  // void getMemo()async {
  //   List<MemoModel> sdf = await getAllMemo();
  //   for (MemoModel memo in sdf){
  //     print(":sdfsdf : "+memo.title);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: Center(
        child: FutureBuilder(
            future: memoList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                List<MemoModel> ml = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: ml.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ml[index].title,
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w800),
                                ),
                                IconButton(onPressed: () => deleteItem(ml[index].id), icon: const Icon(Icons.delete_forever),)
                              ],
                            ),
                            Text(
                              ml[index].content,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(ml[index].createdAt,
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
      /// 작성화면으로 이동버튼
      floatingActionButton: FloatingActionButton(
        child: const Text('작성'),
        onPressed: () async{
          var data = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MemoScreen()));
          if(data != null){
            if(data == "UPDATE"){
              setState(() {
                memoList = getAllMemo();
              });
            }
          }
        },
      ),
    );
  }

  Future<List<MemoModel>> getAllMemo() async {
    /// 모든 메모데이터 가져오는 함수

    List<MemoModel> memoModel = [];
    List<Map<String, dynamic>> data =
        await supabase.from("memos").select();
    memoModel = data.map((e) => MemoModel.fromJson(e)).toList();
    return memoModel;
  }

  void deleteItem(int itemId) async{
    /// 해당 리스트 아이템 삭제하는 함수
    await supabase
        .from('memos')
        .delete()
        .match({ 'id': itemId });

    var snackbar = const SnackBar(
      content: Text('삭제완료!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    setState(() {
      memoList = getAllMemo();
    });
  }
}