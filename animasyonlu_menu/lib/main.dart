import 'package:animasyonlu_menu/menu_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
final Color backgroundColor = Color(0xFF343442);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: backgroundColor,
    statusBarIconBrightness: Brightness.light,

  ));

  runApp(const MyApp()); 

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:MenuDashBoard(),
    );
  }
}

