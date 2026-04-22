import 'package:flutter/material.dart';
import 'package:lamma3ly/app/app.dart';
import 'package:lamma3ly/app/di/injection.dart';
import 'package:lamma3ly/app/env/env_config.dart';

/// Production entry point.
///
/// Run with: flutter run -t lib/main_prod.dart --release
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(EnvConfig.prod);
  runApp(const Lamma3lyApp());
}
