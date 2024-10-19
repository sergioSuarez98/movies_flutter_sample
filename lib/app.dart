import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de modo debug
      title: 'Uponorflix',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema de color azul
      ),
      home: const HomePage(), // Página principal
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uponorflix'), // Título en la barra superior
      ),
      body: const Center(
        child: Text(
          'Hello World!', // El texto "Hello World" centrado
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
