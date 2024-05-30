import 'package:flutter/material.dart';

import 'package:backup_restore_manager/src/app.dart';
import 'package:backup_restore_manager/src/core/di/injector_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDI();

  runApp(const MyApp());
}
