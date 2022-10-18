import 'package:flutter/material.dart';
import 'dashboard.dart';

// import 'item_data.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xff14279B)),
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => DashBoard(),
      },
    );
  }
}
