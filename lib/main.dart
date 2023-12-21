import 'package:flutter/material.dart';
import 'package:memo_app/screens/home.dart';
import 'package:memo_app/screens/memo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  /* supabase 초기화 */
  await Supabase.initialize(
    url: 'https://zcrutsqilbcerrkiaqfj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpjcnV0c3FpbGJjZXJya2lhcWZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI4OTAyNDcsImV4cCI6MjAxODQ2NjI0N30.KNjqWAvhxX7GzHiFH79Tqc_P3FY_cYGmuodGqa1AU5c',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:const HomeScreen(),
    );
  }
}
