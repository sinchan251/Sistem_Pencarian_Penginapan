import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DataPemilik.dart';
import 'EditOperator.dart';
import 'HalAdmin.dart';
import 'TambahOperator.dart';
import 'tambahadmin/dataadmin.dart';

class DataOperator extends StatefulWidget {
  @override
  _DataOperatorState createState() => _DataOperatorState();
}

class _DataOperatorState extends State<DataOperator> {
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
        title: Text("Data Operator"),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahOperator())),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('Role', isEqualTo: 'operator')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Lodaing...."));
              return DataOP(listOP: snapshot.data.docs);
            }),
      ),
    );
  }
}

class DataOP extends StatelessWidget {
  final List<DocumentSnapshot> listOP;

  DataOP({Key key, this.listOP}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        itemCount: listOP == null ? 0 : listOP.length,
        itemBuilder: (context, i) {
          String pkidop = listOP[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
          String idop = listOP[i].data()["ID OP"].toString();
          String namaop = listOP[i].data()["Nama"].toString();
          String emailop = listOP[i].data()["email"].toString();
          String passop = listOP[i].data()["Password"].toString();
          String uid = listOP[i].data()["id akun"].toString();

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
                            Text("$pkidop", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("ID OP :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$idop", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Nama Operator  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$namaop", style: TextStyle(fontSize: 13.0)),
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
                            Text("$emailop", style: TextStyle(fontSize: 13.0)),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text("Password  :",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            SizedBox(width: 5),
                            Text("$passop", style: TextStyle(fontSize: 13.0)),
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
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditOperator(
                                                //edit = data
                                                index: listOP[i].reference,
                                                id: pkidop,
                                                nama: namaop,
                                                email: emailop,
                                                password: passop,
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
                                                        DataOperator())),
                                            child: Text("Kembali")),

                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                            color:
                                                Theme.of(context).accentColor,
                                            onPressed: () {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: listOP[i]
                                                          .data()["email"]
                                                          .toString(),
                                                      password: listOP[i]
                                                          .data()["Password"]
                                                          .toString());
                                              User updateUser = FirebaseAuth
                                                  .instance.currentUser;
                                              updateUser.delete();
                                              //konsepnya , nama collection.doc(namalist [pake array].id).delete
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(listOP[i].id)
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
                                                                  DataOperator())),
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
