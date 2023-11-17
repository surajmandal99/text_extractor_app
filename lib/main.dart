import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_extractor_app/views/home_view.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
