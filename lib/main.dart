import 'package:flutter/material.dart';
import 'package:sky_message/Core/dependency_injection.dart';
import 'package:sky_message/app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DependencyInjection di=DependencyInjection();
  di.dependencies();

  runApp(App());


}
