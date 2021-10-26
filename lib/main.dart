import 'package:Penginapan_Takengon/acc/auth_servicese.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider.value(
      value: AuthServices.firebaseUserstream,
      // initialData: User,
      child: MaterialApp(
        title: 'Penginapan Takengon',
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primaryColor: Color(0xFFd4acf0),
          // accentColor: Color(0xFFccccff),
          // scaffoldBackgroundColor: Color(0xFF997DAD),
          primaryColor: Color(0xFFd4acf0),
          accentColor: Color(0xFFb875e7),
          scaffoldBackgroundColor: Color(0xFF6e468a),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
