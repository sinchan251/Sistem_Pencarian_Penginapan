import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'EditPenginapan.dart';
import 'HalTambahData.dart';
import 'DataPemilik.dart';
import 'DataOperator.dart';
import 'tambahadmin/dataadmin.dart';

class HalAdmin extends StatefulWidget {
  final User dataadmin;

  const HalAdmin({Key key, this.dataadmin}) : super(key: key);

  @override
  _HalAdminState createState() => _HalAdminState(this.dataadmin);
}

class _HalAdminState extends State<HalAdmin> {
  final User dataadmin;

  _HalAdminState(this.dataadmin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
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
                    // Text("Hello " + dataadmin.displayName),
                    // SizedBox(height: 3),
                    // Text(dataadmin.email)
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Beranda'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HalAdmin())),
              leading: Icon(Icons.home_sharp),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Pemilik'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataPemilik())),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Operator'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataOperator())),
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings_outlined),
              title: Text('Admin'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataAdmin())),
            ),
            Divider(
              color: Colors.purpleAccent[100],
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
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
        title: Text("Data Penginapan"),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HalTambahData())),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Penginapan").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return DataPenginapan(listPenginapan: snapshot.data.docs);
            }),
      ),
    );
  }
}

class DataPenginapan extends StatelessWidget {
  final List<DocumentSnapshot> listPenginapan;

  DataPenginapan({Key key, this.listPenginapan}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        itemCount: listPenginapan == null ? 0 : listPenginapan.length,
        itemBuilder: (context, i) {
          String pkidPG = listPenginapan[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
          String namaPG =
              listPenginapan[i].data()["Nama Penginapan"].toString();
          String namaPM = listPenginapan[i].data()["ID Pemilik"].toString();
          String namaOP = listPenginapan[i].data()["ID Operator"].toString();
          String jenisPG =
              listPenginapan[i].data()["Jenis Penginapan"].toString();
          String fasilitas = listPenginapan[i].data()["Fasilitas"].toString();
          String jumlahkamar =
              listPenginapan[i].data()["Jumlah Kamar"].toString();
          var kamarstr = listPenginapan[i].data()["Kamar Standard"].toString();
          var kamarmed = listPenginapan[i].data()["Kamar Medium"].toString();
          var kamardlx = listPenginapan[i].data()["Kamar Deluxe"].toString();
          String hargastr =
              listPenginapan[i].data()["Harga Standard"].toString();
          String hargamed = listPenginapan[i].data()["Harga Medium"].toString();
          String hargadlx = listPenginapan[i].data()["Harga Deluxe"].toString();
          String lat = listPenginapan[i].data()["Latitude"].toString();
          String long = listPenginapan[i].data()["Longitude"].toString();
          String notelpp = listPenginapan[i].data()["Nomor Telpon"].toString();
          String alamat =
              listPenginapan[i].data()["Alamat Penginapan"].toString();
          String info =
              listPenginapan[i].data()["Informasi Penginapan"].toString();
          String imgurl = listPenginapan[i].data()["URL Gambar"].toString();

          return Stack(
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    20.0,
                    5.0,
                    20.0,
                    5.0,
                  ),
                  // height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(55, 35, 69, 0.1),
                            offset: Offset(6, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text("ID  :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$pkidPG", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Nama Penginapan :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$namaPG", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("ID Pemilik :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$namaPM", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("ID Operator :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$namaOP", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Jenis Penginapan :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$jenisPG",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Fasilitas Penginapan :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$fasilitas",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Jumlah Kamar :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text(jumlahkamar,
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Kamar Standard tersedia :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$kamarstr  Kamar",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Harga :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("Rp. $hargastr ",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Kamar Medium tersedia :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$kamarmed Kamar",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Harga :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("Rp. $hargamed ",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Kamar Deluxe tersedia :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$kamardlx Kamar",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Harga :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("Rp. $hargadlx ",
                                  style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Latitude :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$lat", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Longitude :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$long", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama Alamat :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$alamat", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Informasi Penginapan :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Text("$info", style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gambar :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              SizedBox(width: 5),
                              Image.network(imgurl,
                                  width: 150, height: 150, fit: BoxFit.cover),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditPenginapan(
                                                  //edit = data
                                                  index: listPenginapan[i]
                                                      .reference,
                                                  namapg: namaPG,
                                                  idop: namaOP,
                                                  idpm: namaPM,
                                                  jenispg: jenisPG,
                                                  alamat: alamat,
                                                  infopg: info,
                                                  fasilitas: fasilitas,
                                                  jumlahkmr: jumlahkamar,
                                                  kamarstrd: kamarstr,
                                                  hargastrd: hargastr,
                                                  kamarmdm: kamarmed,
                                                  hargamdm: hargamed,
                                                  kamardlxe: kamardlx,
                                                  hargadlxe: hargadlx,
                                                  lat: lat,
                                                  long: long,
                                                  noTelp: notelpp,
                                                ))),
                                    icon: Icon(Icons.edit_outlined)),
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: () {
                                      AlertDialog alert = AlertDialog(
                                        content: Text("Hapus data ?"),
                                        actions: [
                                          // ignore: deprecated_member_use
                                          RaisedButton(
                                              color:
                                                  Theme.of(context).accentColor,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Kembali")),
                                          TextButton(
                                              onPressed: () {
                                                //konsepnya , nama collection.doc(namalist [pake array].id).delete
                                                FirebaseFirestore.instance
                                                    .collection("Penginapan")
                                                    .doc(listPenginapan[i].id)
                                                    .delete();

                                                AlertDialog alert = AlertDialog(
                                                  content: Text(
                                                      "Data berhasil di Hapus"),
                                                  actions: [
                                                    // ignore: deprecated_member_use
                                                    RaisedButton(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        onPressed: () => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HalAdmin())),
                                                        child: Text("Kembali"))
                                                  ],
                                                );
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              },
                                              child: Text("Hapus data",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor)))
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.delete_rounded)),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
