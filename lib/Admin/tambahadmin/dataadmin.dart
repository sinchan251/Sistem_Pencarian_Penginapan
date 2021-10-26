import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../DataOperator.dart';
import '../DataPemilik.dart';
import '../HalAdmin.dart';
import 'tambahadmin.dart';

class DataAdmin extends StatefulWidget {
  @override
  _DataAdminState createState() => _DataAdminState();
}

class _DataAdminState extends State<DataAdmin> {
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
                onTap: () => {
                      AuthServices.signOut(),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                    }),
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
        title: Text("Data Admin"),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahAdmin())),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("Role", isEqualTo: "admin")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Loading...."));
              return DataAD(listAD: snapshot.data.docs);
            }),
      ),
    );
  }
}

class DataAD extends StatelessWidget {
  final List<DocumentSnapshot> listAD;

  DataAD({Key key, this.listAD}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        itemCount: listAD == null ? 0 : listAD.length,
        itemBuilder: (context, i) {
          String pkidad = listAD[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
          String namaad = listAD[i].data()["Nama"].toString();
          String emailad = listAD[i].data()["email"].toString();
          String passad = listAD[i].data()["Password"].toString();
          String uid = listAD[i].data()["id akun"].toString();

          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(
                  20.0,
                  5.0,
                  20.0,
                  5.0,
                ),
                // height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
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
                            Text("$pkidad", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Nama Admin  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$namaad", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        // Row(
                        //   children: [
                        //     Text("Nama Penginapan  :",
                        //         style: TextStyle(
                        //             color: Colors.grey, fontSize: 10.0)),
                        //     SizedBox(width: 5),
                        //     Text("Lido Graha Hotel",
                        //         style: TextStyle(fontSize: 13.0)),
                        //   ],
                        // ),
                        // SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Email  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$emailad", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Password  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$passad", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Id Akun  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$uid", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
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
                                  onPressed: () {
                                    AlertDialog alert = AlertDialog(
                                      content: Text("Hapus data ?"),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                            color:
                                                Theme.of(context).accentColor,
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DataAdmin())),
                                            child: Text("Kembali")),

                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                            color:
                                                Theme.of(context).accentColor,
                                            onPressed: () {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: listAD[i]
                                                          .data()["email"]
                                                          .toString(),
                                                      password: listAD[i]
                                                          .data()["Password"]
                                                          .toString());
                                              User updateUser = FirebaseAuth
                                                  .instance.currentUser;
                                              updateUser.delete();
                                              //konsepnya , nama collection.doc(namalist [pake array].id).delete
                                              FirebaseFirestore.instance
                                                  .collection("operator")
                                                  .doc(listAD[i].id)
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
                                                              builder: (context) =>
                                                                  DataAdmin())),
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
                                            child: Text("Hapus data"))
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
            ],
          );
        },
      ),
    );
  }
}
