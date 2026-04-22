import 'package:flutter/material.dart';
import 'package:lamma3ly/app/app.dart';
import 'package:lamma3ly/app/di/injection.dart';
import 'package:lamma3ly/app/env/env_config.dart';

/// Development entry point.
///
/// Run with: flutter run -t lib/main_dev.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(EnvConfig.dev);
  runApp(const Lamma3lyApp());
}
