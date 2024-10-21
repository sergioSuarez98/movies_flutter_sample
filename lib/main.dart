import 'package:flutter/material.dart';
import 'package:uponor_technical_test/helpers/service_locator.dart';

import 'app.dart';

void main() async {
  //DI
  ServiceLocator.setupDependencies();

  runApp(MyApp());
}
