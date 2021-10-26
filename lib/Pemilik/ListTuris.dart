import 'package:Penginapan_Takengon/acc/auth_servicese.dart';
import 'package:Penginapan_Takengon/acc/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Home_Screen.dart';

class ListTuris extends StatefulWidget {
  final idlist;

  const ListTuris({Key key, this.idlist}) : super(key: key);
  @override
  _ListTurisState createState() => _ListTurisState(this.idlist);
}

class _ListTurisState extends State<ListTuris> {
  final idlist;

  _ListTurisState(this.idlist);
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
                        Text('Check IN',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w800))
                      ]),
                      Column(children: [
                        Text('Check OUT',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w800))
                      ]),
                    ]),
                  ]),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Turis")
                    .where('ID Penginapan Turis', isEqualTo: idlist)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text("Lodaing...."));
                  return DataturisPM(listtur: snapshot.data.docs);
                }),
          ],
        ),
      ),
    );
  }
}

class DataturisPM extends StatelessWidget {
  final List<DocumentSnapshot> listtur;

  const DataturisPM({Key key, this.listtur}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: listtur == null ? 0 : listtur.length,
            itemBuilder: (context, i) {
              // ignore: unused_local_variable
              String idturis = listtur[i].id; //UNUTK MENDAPPATKAN DOCUMENT ID
              String namaturis = listtur[i].data()["Nama Turis"].toString();
              String checkIN = listtur[i].data()["Tanggal Check IN"].toString();
              String checkOUT =
                  listtur[i].data()["Tanggal Check OUT"].toString();

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
                            padding: const EdgeInsets.all(5),
                            child: Text(namaturis,
                                style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child:
                                Text(checkIN, style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(checkOUT,
                                style: TextStyle(fontSize: 15.0)),
                          )
                        ]),
                      ]),
                    ]),
              );
            }));
  }
}
