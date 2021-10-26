import 'dart:ui';

import 'package:Penginapan_Takengon/Admin/HalAdmin.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../Home_Screen.dart';

class HalLogin extends StatefulWidget {
  @override
  _HalLoginState createState() => _HalLoginState();
}

class _HalLoginState extends State<HalLogin> {
  final _formkey = GlobalKey();
  final TextEditingController emailctrl = TextEditingController(text: "");
  final TextEditingController passctrl = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _formkey,
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   title: Text(
          //     'Sign In',
          //     textAlign: TextAlign.left,
          //   ),
          // ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_outlined),
                        iconSize: 25.0,
                        color: Colors.black54,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Welcome'),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text("Username"),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFdbbaf3),
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(55, 35, 69, 0.1),
                                offset: Offset(6, 2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                            BoxShadow(
                                color: Color.fromRGBO(55, 35, 69, 0.5),
                                offset: Offset(-6, -2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          validator: (eMAIL) {
                            if (eMAIL.isEmpty) {
                              return "Masukkan Email";
                            }
                            return null;
                          },
                          controller: emailctrl,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'example@OP/PM.com',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text("Password"),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFdbbaf3),
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(55, 35, 69, 0.1),
                                offset: Offset(6, 2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                            BoxShadow(
                                color: Color.fromRGBO(55, 35, 69, 0.5),
                                offset: Offset(-6, -2),
                                blurRadius: 6.0,
                                spreadRadius: 3.0),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextField(
                          controller: passctrl,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'minimal 6 karakter'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HalAdmin()));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                " ",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.purpleAccent[100]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              if (emailctrl.text == "admin@admin.com" &&
                                  passctrl.text == "admin123") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HalAdmin()));
                              } else {
                                try {
                                  UserCredential result = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: emailctrl.text,
                                          password: passctrl.text);
                                  User firebaseUser = result.user;

                                  return firebaseUser;
                                } on FirebaseAuthException catch (e) {
                                  print("ass ${e.message}");
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Error",
                                            style: TextStyle(
                                              color: Colors.purple,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          elevation: 4,
                                          content: Text(
                                            e.message,
                                            style:
                                                TextStyle(color: Colors.purple),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFdbbaf3),
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(55, 35, 69, 0.1),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0),
                                    BoxShadow(
                                        color: Color.fromRGBO(55, 35, 69, 0.5),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
