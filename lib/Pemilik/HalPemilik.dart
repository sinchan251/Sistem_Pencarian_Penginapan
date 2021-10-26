import 'package:Penginapan_Takengon/Home_Screen.dart';
import 'package:Penginapan_Takengon/Pemilik/ListTuris.dart';
import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:Penginapan_Takengon/acc/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HalPemilik extends StatefulWidget {
  final User datauser;

  const HalPemilik({Key key, this.datauser}) : super(key: key);

  @override
  _HalPemilikState createState() => _HalPemilikState(this.datauser);
}

class _HalPemilikState extends State<HalPemilik> {
  final User datauser;

  _HalPemilikState(this.datauser);

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
                    Text(datauser.displayName)
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Beranda'), //informasi penginapan
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
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
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          datauser.displayName,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Penginapan")
                .where("ID Pemilik", isEqualTo: datauser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Lodaing...."));
              return DataPML(listPML: snapshot.data.docs, datauserr: datauser);
            }),
      ),
    );
  }
}

class DataPML extends StatelessWidget {
  final List<DocumentSnapshot> listPML;
  final User datauserr;

  const DataPML({Key key, this.listPML, this.datauserr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
          itemCount: listPML == null ? 0 : listPML.length,
          itemBuilder: (context, i) {
            String pkidPG = listPML[i].id;
            String namaPG = listPML[i].data()["Nama Penginapan"].toString();
            String fasilitas = listPML[i].data()["Fasilitas"].toString();
            String jumlahkamar = listPML[i].data()["Jumlah Kamar"].toString();
            String info = listPML[i].data()["Informasi Penginapan"].toString();
            String imgurl = listPML[i].data()["URL Gambar"].toString();

            return Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height / 1.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
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
                                          child: Image.network(imgurl,
                                              fit: BoxFit.cover))),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    // width: MediaQuery.of(context).size.width / 2 * 6,
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
                                        Text("Pemilik  :",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0)),
                                        Text(datauserr.displayName,
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
                            Divider(color: Colors.grey),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Fasilitas :",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey)),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    //color: Colors.red,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          //color: Colors.blue,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(fasilitas.toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 12.0)),
                                              SizedBox(
                                                height: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Text("Informasi Penginapan",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(height: 5),
                                  Text(
                                    "\t " + info,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: deprecated_member_use
                      RaisedButton(
                        splashColor: Theme.of(context).accentColor,
                        elevation: 3,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListTuris(idlist: pkidPG))),
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
            );
          }),
    );
  }
}
