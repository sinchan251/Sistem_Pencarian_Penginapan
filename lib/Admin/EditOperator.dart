import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DataOperator.dart';

class EditOperator extends StatefulWidget {
  final index;
  final String id, nama, password, email;

  const EditOperator(
      {Key key, this.index, this.id, this.nama, this.password, this.email})
      : super(key: key);
  @override
  _EditOperatorState createState() => _EditOperatorState();
}

class _EditOperatorState extends State<EditOperator> {
  final TextEditingController pKidOpController = TextEditingController();
  final TextEditingController namaOPController = TextEditingController();
  final TextEditingController emailOPctrl = TextEditingController();
  final TextEditingController pasworrdOPctrl = TextEditingController();

  //metod menampilkan data data yang akan di edit
  void setValueForm() {
    pKidOpController.text = widget.id;
    namaOPController.text = widget.nama;
    emailOPctrl.text = widget.email;
    pasworrdOPctrl.text = widget.password;
  }

  void prosesEditOP() {
    FirebaseFirestore.instance.runTransaction((Transaction tr) async {
      DocumentSnapshot snapshot = await tr.get(widget.index);
      // User updateUser = FirebaseAuth.instance.currentUser;
      // updateUser.updateEmail(emailOPctrl.text);
      // updateUser.updatePassword(pasworrdOPctrl.text);
      tr.update(snapshot.reference, {
        'Nama': namaOPController.text,
      });
      namaOPController.text = '';
      // emailOPctrl.text = '';
      // pasworrdOPctrl.text = '';
      AlertDialog alert = AlertDialog(
        title: Text("Data berhasil di Update"),
        content: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataOperator()));
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
    });
  }

  @override
  void initState() {
    setValueForm();
    super.initState();
  }

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
                  "Edit Data Operator",
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
                        readOnly: true,
                        enabled: false,
                        controller: pKidOpController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
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
                      TextField(
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
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: false,
                        readOnly: true,
                        controller: emailOPctrl,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Username@asdasd.com',
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
                        readOnly: true,
                        controller: pasworrdOPctrl,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
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
                            side: BorderSide(color: Colors.red)),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.purpleAccent[100],
                            )),
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
                        onPressed: () => prosesEditOP(),
                        child: Text('Edit', style: TextStyle(fontSize: 15)),
                      ),
                      Container(
                        // padding: EdgeInsets.all(2.0),
                        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                              )
                            ]),
                        // child: IconButton(
                        //   onPressed: () => {print(widget.index)},
                        //   icon: Icon(Icons.directions),
                        //   iconSize: 25.0,
                        // ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
