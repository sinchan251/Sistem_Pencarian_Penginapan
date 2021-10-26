import 'package:Penginapan_Takengon/Admin/tambahadmin/dataadmin.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TambahAdmin extends StatefulWidget {
  @override
  _TambahAdminState createState() => _TambahAdminState();
}

class _TambahAdminState extends State<TambahAdmin> {
  final TextEditingController namaadmin = TextEditingController();
  final TextEditingController emailadmin = TextEditingController();
  final TextEditingController pasworrdadmin = TextEditingController();
  String rolectrl = 'admin';
  // final User user;

  // _TambahOperatorState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Admin"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Input Data Admin",
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
                      TextFormField(
                        controller: namaadmin,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Nama Admin',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Nama Admin",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailadmin,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.black26),
                            helperText: "*Harus menggunakan @admin.com",
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
                        controller: pasworrdadmin,
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
                          // ignore: unused_local_variable
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailadmin.text,
                                  password: pasworrdadmin.text);
                          User updateUser = FirebaseAuth.instance.currentUser;
                          updateUser.updateProfile(displayName: namaadmin.text);
                          adminSetup(namaadmin.text, emailadmin.text,
                              pasworrdadmin.text, rolectrl);
                          //                     signOut();
                          AlertDialog alert = AlertDialog(
                            title: Text("Data berhasil di tambah"),
                            content: TextButton(
                                onPressed: () {
                                  AuthServices.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DataAdmin()));
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

  Future<void> adminSetup(String nama, email, password, role) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    // users.add({'Nama': nama, 'uid': uid, 'email': email, 'pass': password});
    await users.doc(uid).set({
      //MENINGPPUTKAN DATA DOCUMENT ID
      'Nama': nama,
      'id akun': uid,
      'email': email,
      'Password': password,
      'Role': role,
    });

    return;
  }
}
