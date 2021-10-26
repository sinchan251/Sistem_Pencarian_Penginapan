import 'package:Penginapan_Takengon/Admin/DataPemilik.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahPemilik extends StatefulWidget {
  @override
  _TambahPemilikState createState() => _TambahPemilikState();
}

class _TambahPemilikState extends State<TambahPemilik> {
  final TextEditingController pKidPMController = TextEditingController();
  final TextEditingController namaPMController = TextEditingController();
  final TextEditingController emailPMctrl = TextEditingController();
  final TextEditingController pasworrdPMctrl = TextEditingController();
  String rolectrl = 'Pemilik';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Pemilik"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Input Data Pemilik",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 1.2,
                    color: Colors.purpleAccent[100],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF6e468a),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(55, 35, 69, 0.1),
                            offset: Offset(6, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(55, 35, 69, 0.9),
                            offset: Offset(-6, -2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(55, 35, 69, 0.1),
                            offset: Offset(2, 6),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(55, 35, 69, 0.9),
                            offset: Offset(-2, -6),
                            blurRadius: 6.0,
                            spreadRadius: 3.0)
                      ]),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: pKidPMController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.black26),
                            helperText: "*PM_namapenginapan",
                            hintText: 'ID Pemilik',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "ID Pemilik",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: namaPMController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Nama Pemilik',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Nama Pemilik",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailPMctrl,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.black26),
                            helperText: "*Harus menggunakan @PM.com",
                            hintText: 'Email@example.com',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        controller: pasworrdPMctrl,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.black26),
                            helperText: "minimal 6 karakter",
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // ignore: deprecated_member_use
                      OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.purpleAccent[100],
                        onPressed: () async {
                          /// ADD DATA HERE
                          // await pemilik.doc(pKidPMController.text).set({
                          //   // MENINGPPUTKAN DATA DOCUMENT ID
                          //   'Nama': namaPMController.text,
                          //   'username': usernamePMctrl.text,
                          //   'Password': pasworrdPMctrl.text,
                          // });
                          // pKidPMController.text = '';
                          // namaPMController.text = '';
                          // usernamePMctrl.text = '';
                          // pasworrdPMctrl.text = '';

                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailPMctrl.text,
                              password: pasworrdPMctrl.text);
                          User updateUser = FirebaseAuth.instance.currentUser;
                          updateUser.updateProfile(
                              displayName: namaPMController.text);

                          //signOut();
                          AlertDialog alert = AlertDialog(
                            title: Text("Akun berhasil di daftar"),
                            content: TextButton(
                                onPressed: () {
                                  pmSetup(
                                      pKidPMController.text,
                                      namaPMController.text,
                                      emailPMctrl.text,
                                      pasworrdPMctrl.text,
                                      rolectrl);
                                  AlertDialog alertt = AlertDialog(
                                    title:
                                        Text("Kembali Ke halaman sebelumnya"),
                                    content: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DataPemilik()));
                                          AuthServices.signOut();
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                            color: Colors.purpleAccent[100],
                                          ),
                                        )),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alertt;
                                    },
                                  );
                                },
                                child: Text(
                                  "YA",
                                  style: TextStyle(
                                    color: Colors.purpleAccent[100],
                                  ),
                                )),
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: Text('Submit', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  Future<void> pmSetup(String id, nama, email, password, role) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    // users.add({'Nama': nama, 'uid': uid, 'email': email, 'pass': password});
    await users.doc(uid).set({
      //MENINGPPUTKAN DATA DOCUMENT ID
      'ID PM': id,
      'Nama': nama,
      'id akun': uid,
      'email': email,
      'Password': password,
      'Role': role,
    });

    return;
  }
}
