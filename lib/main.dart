import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uponor_technical_test/helpers/service_locator.dart'; 

import 'app.dart';

final getIt = GetIt.instance; // Crea una instancia global de Get It

void main() async {
 
  //Inyeccion de dependencias 
  ServiceLocator.setupDependencies();



  
  runApp(MyApp());
}



