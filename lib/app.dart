import 'package:flutter/material.dart';
import 'package:uponor_technical_test/presentation/pages/catalog_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uponor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatalogView(),
    );
  }
}
