import 'package:Penginapan_Takengon/acc/Halaman_Login.dart';
import 'package:Penginapan_Takengon/acc/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);
    return (firebaseUser == null) ? HalLogin() : Mainpage(user: firebaseUser);
  }
}
