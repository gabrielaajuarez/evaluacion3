import 'package:evaluacion3/pages/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:NestedScrollViewExample(),
      debugShowCheckedModeBanner: false,
      title: 'Evaluación lll',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 131, 17, 131)),
        useMaterial3: true,
      ),
    );
  }
}

