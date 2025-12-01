import 'package:flutter/material.dart';
import 'services/storage.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const MyApp());
}
