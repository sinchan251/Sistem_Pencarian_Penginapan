import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:Penginapan_Takengon/Operator/DataTuris.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'TambahTuris.dart';

class HalOperator extends StatefulWidget {
  final User dataOP;

  const HalOperator({Key key, this.dataOP}) : super(key: key);

  @override
  _HalOperatorState createState() => _HalOperatorState(this.dataOP);
}

class _HalOperatorState extends State<HalOperator> {
  final User dataOP;

  _HalOperatorState(this.dataOP);
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
                      Text(dataOP.displayName)
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('Beranda'),
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home_sharp),
              ),
              Divider(
                color: Colors.purpleAccent[100],
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
                onTap: () => AuthServices.signOut(),
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
          title: Text("Halaman Operator"),
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Penginapan")
                  .where("ID Operator", isEqualTo: dataOP.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Text("Lodaing...."));
                return DataOPL(listOPL: snapshot.data.docs, userop: dataOP);
              }),
        ));
  }
}

class DataOPL extends StatelessWidget {
  final User userop;
  final List<DocumentSnapshot> listOPL;

  const DataOPL({Key key, this.userop, this.listOPL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
            itemCount: listOPL == null ? 0 : listOPL.length,
            itemBuilder: (context, i) {
              String pkidPG = listOPL[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
              String namaPG = listOPL[i].data()["Nama Penginapan"].toString();
              // ignore: unused_local_variable
              String namaPM = listOPL[i].data()["ID Pemilik"].toString();
              // ignore: unused_local_variable
              String namaOP = listOPL[i].data()["ID Operator"].toString();
              // ignore: unused_local_variable
              String jenisPG = listOPL[i].data()["Jenis Penginapan"].toString();
              // ignore: unused_local_variable
              String fasilitas = listOPL[i].data()["Fasilitas"].toString();
              String jumlahkamar = listOPL[i].data()["Jumlah Kamar"].toString();
              var kamarstr = listOPL[i].data()["Kamar Standard"].toString();
              var kamarmed = listOPL[i].data()["Kamar Medium"].toString();
              var kamardlx = listOPL[i].data()["Kamar Deluxe"].toString();
              String hargastr = listOPL[i].data()["Harga Standard"].toString();
              String hargamed = listOPL[i].data()["Harga Medium"].toString();
              String hargadlx = listOPL[i].data()["Harga Deluxe"].toString();
              // ignore: unused_local_variable
              String lat = listOPL[i].data()["Latitude"].toString();
              // ignore: unused_local_variable
              String long = listOPL[i].data()["Longitude"].toString();
              // ignore: unused_local_variable
              String alamat = listOPL[i].data()["Alamat Penginapan"].toString();
              String info =
                  listOPL[i].data()["Informasi Penginapan"].toString();
              String imgurl = listOPL[i].data()["URL Gambar"].toString();

              return Container(
                height: MediaQuery.of(context).size.height / 1.1,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height / 1.8,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    offset: Offset(6, 2),
                                    blurRadius: 6.0,
                                    spreadRadius: 3.0),
                              ]),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                        // width: MediaQuery.of(context).size.width / 2.5,
                                        // height: MediaQuery.of(context).size.width / 2.5,
                                        child: ClipRRect(
                                            child: Image.network(
                                      imgurl,
                                      fit: BoxFit.fill,
                                    ))),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      // width: MediaQuery.of(context).size.width,
                                      // height: MediaQuery.of(context).size.width / 2.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Nama Penginapan  :",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0)),
                                          Text(namaPG,
                                              style: TextStyle(fontSize: 13.0)),
                                          SizedBox(height: 5),
                                          Text("Operator",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0)),
                                          Text(userop.displayName,
                                              style: TextStyle(fontSize: 13.0)),
                                          SizedBox(height: 5),
                                          Text("Jumlah Kamar  :",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0)),
                                          Text(
                                            jumlahkamar,
                                            style: TextStyle(fontSize: 13.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(color: Colors.black54),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kamar Tersedia :",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  // kamarstr == "0"
                                  //     ? Text(
                                  //         "Kamar Standard tidak ada yang kosong")
                                  //     :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Standard :"),
                                      Container(
                                          width: 40,
                                          height: 30,
                                          child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                kamarstr = value;
                                                int.parse(kamarstr);
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: kamarstr,
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 1.5),
                                                ),
                                              ))),
                                      Text(" Harga Rp."),
                                      Container(
                                          width: 59,
                                          height: 30,
                                          child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                hargastr = value;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: hargastr,
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 1.5),
                                                ),
                                              ))),
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        splashColor:
                                            Theme.of(context).accentColor,
                                        elevation: 3,
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Penginapan")
                                              .doc(pkidPG)
                                              .update({
                                            "Kamar Standard":
                                                int.parse(kamarstr),
                                            "Harga Standard": hargastr
                                          });
                                          AlertDialog jeut = AlertDialog(
                                            content: Text("Berhasil Di Update"),
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return jeut;
                                              });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        color: Colors.white,
                                        child: Text('Update',
                                            style: TextStyle(fontSize: 13),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  //Medium
                                  // if (kamarmed == "0")
                                  //   Text("Kamar Medium Tidak ada yang tersedia")
                                  // else
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Medium :"),
                                      Container(
                                          width: 40,
                                          height: 30,
                                          child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                kamarmed = value;
                                                int.parse(kamarmed);
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: kamarmed,
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 1.5),
                                                ),
                                              ))),
                                      Text(" Harga Rp."),
                                      Container(
                                          width: 59,
                                          height: 30,
                                          child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                hargamed = value;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: hargamed,
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 1.5),
                                                ),
                                              ))),
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        splashColor:
                                            Theme.of(context).accentColor,
                                        elevation: 3,
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Penginapan")
                                              .doc(pkidPG)
                                              .update({
                                            "Kamar Medium": int.parse(kamarmed),
                                            "Harga Medium": hargamed
                                          });
                                          AlertDialog jeut = AlertDialog(
                                            content: Text("Berhasil Di Update"),
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return jeut;
                                              });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        color: Colors.white,
                                        child: Text('Update',
                                            style: TextStyle(fontSize: 13),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  //Deluxe
                                  // kamardlx == "0"
                                  //     ? Text(
                                  //         "Kamar Deluxe Tidak ada yang tersedia")
                                  //     :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Deluxe :"),
                                      Container(
                                          width: 40,
                                          height: 30,
                                          child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                kamardlx = value;
                                                int.parse(kamardlx);
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: kamardlx,
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 1.5),
                                                ),
                                              ))),
                                      Text(" Harga Rp."),
                                      Container(
                                          width: 59,
                                          height: 30,
                                          child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                hargadlx = value;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: hargadlx,
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 1.5),
                                                ),
                                              ))),
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        splashColor:
                                            Theme.of(context).accentColor,
                                        elevation: 3,
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Penginapan")
                                              .doc(pkidPG)
                                              .update({
                                            "Kamar Deluxe": int.parse(kamardlx),
                                            "Harga Deluxe": hargadlx
                                          });
                                          AlertDialog jeut = AlertDialog(
                                            content: Text("Berhasil Di Update"),
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return jeut;
                                              });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        color: Colors.white,
                                        child: Text('Update',
                                            style: TextStyle(fontSize: 13),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                              Divider(color: Colors.black54),
                              Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Informasi Penginapan",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 9),
                                    Text(
                                      "\t " + info,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 30.0),
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                splashColor: Theme.of(context).accentColor,
                                elevation: 3,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TambahTuris(idpgturis: pkidPG))),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.purpleAccent[100],
                                child: Text('Input Data Turis',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center),
                              ),
                              // ignore: deprecated_member_use
                              RaisedButton(
                                splashColor: Theme.of(context).accentColor,
                                elevation: 3,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DataTuris(idpgdataturis: pkidPG))),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.purpleAccent[100],
                                child: Text('Lihat Data Turis',
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
