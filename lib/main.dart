import 'package:flutter/material.dart';
import 'package:todo_app/src/src.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.blue,
              secondary: Colors.blue[200],
            ),
      ),
    );
  }
}
