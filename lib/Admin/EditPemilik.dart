import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DataPemilik.dart';

class EditPemilik extends StatefulWidget {
  final index;
  final String id, nama, password, username;

  const EditPemilik(
      {Key key, this.index, this.id, this.nama, this.password, this.username})
      : super(key: key);
  @override
  _EditPemilikState createState() => _EditPemilikState();
}

class _EditPemilikState extends State<EditPemilik> {
  final TextEditingController pKidPMController = TextEditingController();
  final TextEditingController namaPMController = TextEditingController();
  final TextEditingController usernamePMctrl = TextEditingController();
  final TextEditingController pasworrdPMctrl = TextEditingController();

  //metod menampilkan data data yang akan di edit
  void setValueForm() {
    pKidPMController.text = widget.id;
    namaPMController.text = widget.nama;
    usernamePMctrl.text = widget.username;
    pasworrdPMctrl.text = widget.password;
  }

  void prosesEditPM() {
    FirebaseFirestore.instance.runTransaction((Transaction tr) async {
      DocumentSnapshot snapshot = await tr.get(widget.index);
      tr.update(snapshot.reference, {
        'Nama': namaPMController.text,
        // 'username': usernamePMctrl.text,
        // 'Password': pasworrdPMctrl.text,
      });
      namaPMController.text = '';
      // usernamePMctrl.text = '';
      // pasworrdPMctrl.text = '';
      AlertDialog alert = AlertDialog(
        content: Text("Data berhasil di Update"),
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataPemilik())),
              child: Text("Kembali"))
        ],
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
                  "Edit Data Pemilik",
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
                        controller: pKidPMController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
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
                      // TextField(
                      //   style: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w600),
                      //   decoration: InputDecoration(
                      //       hintText: 'Nama Penginapan',
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Colors.black87, width: 1.5),
                      //       ),
                      //       labelText: "Nama Penginapan",
                      //       labelStyle: TextStyle(
                      //           color: Colors.purpleAccent[100], fontSize: 12)),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      TextField(
                        enabled: false,
                        controller: usernamePMctrl,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'username@PM.com',
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
                        enabled: false,
                        obscureText: true,
                        controller: pasworrdPMctrl,
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
                                fontSize: 12, color: Colors.blue[900])),
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
                        onPressed: () => prosesEditPM(),
                        child: Text('Submit', style: TextStyle(fontSize: 15)),
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
