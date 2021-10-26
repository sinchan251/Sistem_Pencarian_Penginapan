import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DataTuris.dart';

class TambahTuris extends StatefulWidget {
  final idpgturis;

  const TambahTuris({Key key, this.idpgturis}) : super(key: key);
  @override
  _TambahTurisState createState() => _TambahTurisState(this.idpgturis);
}

class _TambahTurisState extends State<TambahTuris> {
  final TextEditingController namaTuris = TextEditingController();
  final TextEditingController iN = TextEditingController();
  final TextEditingController oUT = TextEditingController();

  final idpgturis;

  _TambahTurisState(this.idpgturis);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Pengunjung"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Input Data Turis",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 1.2,
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
                      // TextField(
                      //   enabled: false,
                      //   style: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w600),
                      //   decoration: InputDecoration(
                      //       hintText: idpgturis,
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Colors.black87, width: 1.5),
                      //       ),
                      //       labelText: "ID penginapan: " + idpgturis,
                      //       labelStyle: TextStyle(
                      //           color: Colors.purpleAccent[100], fontSize: 12)),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      TextField(
                        controller: namaTuris,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Nama Pengunjung',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Nama",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: iN,
                        keyboardType: TextInputType.datetime,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'HH/BB/TTTT',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Check IN",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: oUT,
                        keyboardType: TextInputType.datetime,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'HH/BB/TTTT',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.5),
                            ),
                            labelText: "Check Out",
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
                        onPressed: () {
                          AlertDialog alert = AlertDialog(
                            title: Text("Pilih Jenis Kamar "),
                            actions: [
                              RaisedButton(
                                color: Colors.purpleAccent[100],
                                onPressed: () {
                                  String jk = "Standard";
                                  String aa = idpgturis;
                                  tambahturis(
                                    aa,
                                    namaTuris.text,
                                    iN.text,
                                    oUT.text,
                                    jk,
                                  );
                                  FirebaseFirestore.instance
                                      .collection("Penginapan")
                                      .doc(idpgturis)
                                      .update({
                                    "Kamar Standard": FieldValue.increment(-1)
                                  });
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Data berhasil di tambah"),
                                    content: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DataTuris(
                                                          idpgdataturis:
                                                              idpgturis)));
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
                                child: Text('Kamar Standard',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              //med
                              RaisedButton(
                                color: Colors.purpleAccent[100],
                                onPressed: () {
                                  String jk = "Medium";
                                  String aa = idpgturis;
                                  tambahturis(
                                    aa,
                                    namaTuris.text,
                                    iN.text,
                                    oUT.text,
                                    jk,
                                  );
                                  FirebaseFirestore.instance
                                      .collection("Penginapan")
                                      .doc(idpgturis)
                                      .update({
                                    "Kamar Medium": FieldValue.increment(-1)
                                  });
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Data berhasil di tambah"),
                                    content: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DataTuris(
                                                          idpgdataturis:
                                                              idpgturis)));
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
                                child: Text('Kamar Medium ',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              //dlx
                              RaisedButton(
                                color: Colors.purpleAccent[100],
                                onPressed: () {
                                  String jk = "Deluxe";
                                  String aa = idpgturis;
                                  tambahturis(
                                    aa,
                                    namaTuris.text,
                                    iN.text,
                                    oUT.text,
                                    jk,
                                  );
                                  FirebaseFirestore.instance
                                      .collection("Penginapan")
                                      .doc(idpgturis)
                                      .update({
                                    "Kamar Deluxe": FieldValue.increment(-1)
                                  });
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Data berhasil di tambah"),
                                    content: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DataTuris(
                                                          idpgdataturis:
                                                              idpgturis)));
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
                                child: Text(' Kamar Deluxe  ',
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
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

  Future<void> tambahturis(String idpgturis, nama, cin, cout, jk) async {
    CollectionReference pg = FirebaseFirestore.instance.collection('Turis');
    await pg.doc().set({
      'ID Penginapan Turis': idpgturis,
      'Nama Turis': nama,
      'Tanggal Check IN': cin,
      'Tanggal Check OUT': cout,
      'Jenis Kamar': jk,
      'Status': "Belum Selesai"
    });

    return;
  }
}
