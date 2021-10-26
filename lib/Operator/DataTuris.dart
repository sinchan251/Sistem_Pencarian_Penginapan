import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:Penginapan_Takengon/acc/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Home_Screen.dart';
import 'EditTuris.dart';

class DataTuris extends StatefulWidget {
  final idpgdataturis;

  const DataTuris({Key key, this.idpgdataturis}) : super(key: key);
  @override
  _DataTurisState createState() => _DataTurisState(this.idpgdataturis);
}

class _DataTurisState extends State<DataTuris> {
  final idpgdataturis;

  _DataTurisState(this.idpgdataturis);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Hello ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 7),
                    //Text(dataOP.displayName)
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Beranda'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
              leading: Icon(Icons.home_sharp),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Halaman Awal'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            Divider(
              color: Colors.purpleAccent[100],
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_sharp),
              title: Text('Log Out'),
              onTap: () => {
                AuthServices.signOut(),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).accentColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip);
          },
        ),
        title: Text("Data Turis"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Table(
                  border: TableBorder.all(
                      color: Colors.black54,
                      style: BorderStyle.solid,
                      width: 0.5),
                  children: [
                    TableRow(children: [
                      Column(children: [
                        Text(
                          'NAMA',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w800),
                        )
                      ]),
                      Column(children: [
                        Text('Jenis Kamar',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w800))
                      ]),
                      Column(children: [
                        Text('Check IN',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w800))
                      ]),
                      Column(children: [
                        Text('Check OUT',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w800))
                      ]),
                      Column(children: [
                        Text('Actions',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w800))
                      ]),
                    ]),
                  ]),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Turis")
                    .where('ID Penginapan Turis', isEqualTo: idpgdataturis)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text("Lodaing...."));
                  return DataturisOP(
                      listtur: snapshot.data.docs, aidi: idpgdataturis);
                }),
          ],
        ),
      ),
    );
  }
}

class DataturisOP extends StatefulWidget {
  final List<DocumentSnapshot> listtur;
  final aidi;

  const DataturisOP({Key key, this.listtur, this.aidi}) : super(key: key);

  @override
  _DataturisOPState createState() => _DataturisOPState();
}

class _DataturisOPState extends State<DataturisOP> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: widget.listtur == null ? 0 : widget.listtur.length,
            itemBuilder: (context, i) {
              // ignore: unused_local_variable
              String idturis =
                  widget.listtur[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
              String namaturis =
                  widget.listtur[i].data()["Nama Turis"].toString();
              String jenis = widget.listtur[i].data()["Jenis Kamar"].toString();
              String statuss = widget.listtur[i].data()["Status"].toString();
              String checkIN =
                  widget.listtur[i].data()["Tanggal Check IN"].toString();
              String checkOUT =
                  widget.listtur[i].data()["Tanggal Check OUT"].toString();

              return Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Table(
                    border: TableBorder.all(
                        color: Colors.black54,
                        style: BorderStyle.solid,
                        width: 0.5),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 5, right: 5),
                            child: Text(namaturis,
                                style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 5, right: 5),
                            child:
                                Text(jenis, style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 18, right: 18),
                            child:
                                Text(checkIN, style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 18, right: 18),
                            child: Text(checkOUT,
                                style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                        Column(children: [
                          //EDIT
                          IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTuris(
                                        index: widget.listtur[i].reference,
                                        namatur: namaturis,
                                        nginap: checkIN,
                                        keluar: checkOUT))),
                            icon: Icon(Icons.edit_outlined),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Theme.of(context).accentColor,
                          ),
                          //Chech out
                          statuss == "Selesai"
                              ? Text(
                                  "Selesai C.O",
                                  style: TextStyle(color: Colors.white),
                                )
                              : TextButton(
                                  onPressed: () {
                                    if (jenis == "Standard") {
                                      FirebaseFirestore.instance
                                          .collection("Turis")
                                          .doc(idturis)
                                          .update({"Status": "Selesai"});

                                      FirebaseFirestore.instance
                                          .collection("Penginapan")
                                          .doc(widget.aidi)
                                          .update({
                                        "Kamar Standard":
                                            FieldValue.increment(1),
                                      });
                                    }

                                    if (jenis == "Medium") {
                                      FirebaseFirestore.instance
                                          .collection("Turis")
                                          .doc(idturis)
                                          .update({"Status": "Selesai"});
                                      FirebaseFirestore.instance
                                          .collection("Penginapan")
                                          .doc(widget.aidi)
                                          .update({
                                        "Kamar Medium": FieldValue.increment(1),
                                      });
                                    }
                                    if (jenis == "Deluxe") {
                                      FirebaseFirestore.instance
                                          .collection("Turis")
                                          .doc(idturis)
                                          .update({"Status": "Selesai"});
                                      FirebaseFirestore.instance
                                          .collection("Penginapan")
                                          .doc(widget.aidi)
                                          .update({
                                        "Kamar Deluxe": FieldValue.increment(1),
                                      });
                                    }

                                    AlertDialog alert = AlertDialog(
                                      title: Text("Check Out Berhasil"),
                                      content: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Wrapper()));
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
                                  child: Text("CHECK OUT NOW",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )))

                          // IconButton(
                          //   onPressed: () {
                          //     AlertDialog alert = AlertDialog(
                          //       content: Text("Hapus data ?"),
                          //       actions: [
                          //         // ignore: deprecated_member_use
                          //         RaisedButton(
                          //             color: Theme.of(context).accentColor,
                          //             onPressed: () => Navigator.pop(context),
                          //             child: Text("Kembali")),
                          //         TextButton(
                          //             onPressed: () {
                          //               //konsepnya , nama collection.doc(namalist [pake array].id).delete
                          //               FirebaseFirestore.instance
                          //                   .collection("Penginapan")
                          //                   .doc(listtur[i].id)
                          //                   .delete();
                          //               AlertDialog alert = AlertDialog(
                          //                 content:
                          //                     Text("Data berhasil di Hapus"),
                          //               );
                          //               showDialog(
                          //                 context: context,
                          //                 builder: (BuildContext context) {
                          //                   return alert;
                          //                 },
                          //               );
                          //             },
                          //             child: Text("Hapus data",
                          //                 style: TextStyle(
                          //                     color: Theme.of(context)
                          //                         .accentColor)))
                          //       ],
                          //     );
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return alert;
                          //       },
                          //     );
                          //   },
                          //   icon: Icon(Icons.delete_rounded),
                          // ),
                        ]),
                      ]),
                    ]),
              );
            }));
  }
}
