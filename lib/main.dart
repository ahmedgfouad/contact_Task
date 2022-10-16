import 'package:aqflite_contacts/contact_provider.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await ContactProvider.instance.open();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
