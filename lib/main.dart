import 'package:butcity/injection.dart' as di;
import 'package:flutter/material.dart';

import 'features/app/app_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
////////////////////