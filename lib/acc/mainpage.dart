import 'package:Penginapan_Takengon/Admin/HalAdmin.dart';
import 'package:Penginapan_Takengon/Operator/HalOperator.dart';
import 'package:Penginapan_Takengon/Pemilik/HalPemilik.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  final User user;
  Mainpage({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error :  ${snapshot.error}");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading..");
              default:
                return checkrole(snapshot.data, context);
            }
          }),
    );
  }

  checkrole(DocumentSnapshot snapshot, BuildContext context) {
    if (snapshot.data()["Role"] == "Pemilik") {
      return HalPemilik(
        datauser: user,
      );
    } else if (snapshot.data()["Role"] == "operator") {
      return HalOperator(
        dataOP: user,
      );
    } else if (snapshot.data()["Role"] == "admin") {
      return HalAdmin(
        dataadmin: user,
      );
    }
  }
}
