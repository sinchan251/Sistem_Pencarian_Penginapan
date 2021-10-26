import 'package:Penginapan_Takengon/Admin/tambahadmin/dataadmin.dart';
import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DataOperator.dart';
import 'EditPemilik.dart';
import 'HalAdmin.dart';
import 'TambahPemilik.dart';

class DataPemilik extends StatefulWidget {
  @override
  _HalTambahDataState createState() => _HalTambahDataState();
}

class _HalTambahDataState extends State<DataPemilik> {
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
        title: Text("Data Pemilik"),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahPemilik())),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('Role', isEqualTo: 'Pemilik')
                // .orderBy("Nama", descending: true). untuke mengurutkan
                // where("Username", isGreaterThan: 10) ,untuk menquery username lebih besar dari 10
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return DataPM(listPM: snapshot.data.docs);
            }),
      ),
    );
  }
}

class DataPM extends StatelessWidget {
  final List<DocumentSnapshot> listPM;

  const DataPM({Key key, this.listPM}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        itemCount: listPM == null ? 0 : listPM.length,
        itemBuilder: (context, i) {
          String pkidPM = listPM[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
          String idPM = listPM[i].data()["ID PM"].toString();
          String namaPM = listPM[i].data()["Nama"].toString();
          String emailPM = listPM[i].data()["email"].toString();
          String passPM = listPM[i].data()["Password"].toString();
          String uid = listPM[i].data()["id akun"].toString();

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
                            Text("$pkidPM", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Nama Pemilik  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$namaPM", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("ID PM :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$idPM", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        // Row(
                        //   children: [
                        //     Text("Nama Operator :",
                        //         style: TextStyle(
                        //             color: Colors.grey,
                        //             fontSize: 10.0)),
                        //     SizedBox(width: 5),
                        //     Text("",
                        //         style: TextStyle(fontSize: 13.0)),
                        //   ],
                        // ),
                        // SizedBox(height: 8.0),
                        // Row(
                        //   children: [
                        //     Text("Nama Penginapan  :",
                        //         style: TextStyle(
                        //             color: Colors.grey,
                        //             fontSize: 10.0)),
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
                            Text("$emailPM", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Password  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$passPM", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("ID akun  :",
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
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditPemilik(
                                                index: listPM[i].reference,
                                                id: pkidPM,
                                                nama: namaPM,
                                                username: emailPM,
                                                password: passPM,
                                              ))),
                                  icon: Icon(Icons.edit_outlined)),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              alignment: Alignment.center,
                              child: IconButton(
                                  onPressed: () {
                                    AlertDialog alert = AlertDialog(
                                      content: Text("Yakin, data di hapus ?"),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                            color:
                                                Theme.of(context).accentColor,
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DataPemilik())),
                                            child: Text("Kembali")),

                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                            color:
                                                Theme.of(context).accentColor,
                                            onPressed: () {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: listPM[i]
                                                          .data()["email"]
                                                          .toString(),
                                                      password: listPM[i]
                                                          .data()["Password"]
                                                          .toString());
                                              User updateUser = FirebaseAuth
                                                  .instance.currentUser;
                                              updateUser.delete();

                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(listPM[i].id)
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
                                                                  DataPemilik())),
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
                                            child: Text("Ya"))
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
