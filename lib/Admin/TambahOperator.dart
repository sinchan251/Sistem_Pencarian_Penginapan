import 'package:Penginapan_Takengon/Admin/DataOperator.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class TambahOperator extends StatefulWidget {
  @override
  _TambahOperatorState createState() => _TambahOperatorState();
}

class _TambahOperatorState extends State<TambahOperator> {
  final TextEditingController pKidOpController = TextEditingController();
  final TextEditingController namaOPController = TextEditingController();
  final TextEditingController emailOPctrl = TextEditingController();
  final TextEditingController pasworrdOPctrl = TextEditingController();
  String rolectrl = 'operator';
  // final User user;

  // _TambahOperatorState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Operator"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Input Data Operator",
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
                        controller: pKidOpController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            // icon: Icon(Icons.person),
                            // labelText: "Username",
                            // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)))
                            helperStyle: TextStyle(color: Colors.black26),
                            helperText: "*OP_namapenginapan",
                            hintText: 'ID Operator',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "ID Operator",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: namaOPController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Nama Operator',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Nama Operator",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextField(
                      //   enabled: false,
                      //   readOnly: true,
                      //   style: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w600),
                      //   decoration: InputDecoration(
                      //       hintText: '$rolectrl',
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Colors.black87, width: 1.5),
                      //       ),
                      //       labelText: "Role",
                      //       labelStyle: TextStyle(
                      //           color: Colors.purpleAccent[100], fontSize: 12)),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailOPctrl,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.black26),
                            helperText: "*Harus menggunakan @OP.com",
                            hintText: 'Username@test.com',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Username",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        controller: pasworrdOPctrl,
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
                            style: TextStyle(
                                fontSize: 12, color: Colors.purpleAccent[100])),
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
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailOPctrl.text,
                              password: pasworrdOPctrl.text);
                          User updateUser = FirebaseAuth.instance.currentUser;
                          updateUser.updateProfile(
                              displayName: namaOPController.text);
                          //                     signOut();
                          AlertDialog alert = AlertDialog(
                            title: Text("Akun berhasil didaftarkan"),
                            content: TextButton(
                                onPressed: () {
                                  userSetup(
                                      pKidOpController.text,
                                      namaOPController.text,
                                      emailOPctrl.text,
                                      pasworrdOPctrl.text,
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
                                                      DataOperator()));
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

  Future<void> userSetup(String id, nama, email, password, role) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    // users.add({'Nama': nama, 'uid': uid, 'email': email, 'pass': password});
    await users.doc(uid).set({
      //MENINGPPUTKAN DATA DOCUMENT ID
      'ID OP': id,
      'Nama': nama,
      'id akun': uid,
      'email': email,
      'Password': password,
      'Role': role,
    });

    return;
  }
}
