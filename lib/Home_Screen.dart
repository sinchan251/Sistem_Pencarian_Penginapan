import 'dart:ui';

import 'package:Penginapan_Takengon/Halaman_Info.dart';
import 'package:haversine/haversine.dart';
//import 'package:haversine_distance/haversine_distance.dart';

import 'package:Penginapan_Takengon/acc/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'asdasdasd.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // For storing the current position
  Position _currentPosition;
  String _currentAddress;

  // _text() {
  //   Position kosong = Position(longitude: 0.0, latitude: 0.0);
  //   _currentPosition = kosong;
  // }

// ignore: unused_local_variable
  final startAddressController = TextEditingController();

// ignore: unused_field
  String _startAddress = '';

// For controlling the view of the Map
// ignore: unused_local_variable
  GoogleMapController mapController;

// Method for retrieving the current location
// ignore: unused_element
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POSss: $_currentPosition');

        // For moving the camera to current location
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

//method mengambil alamat tsb
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.name},${place.locality}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
        print("ini adalah $_startAddress");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 9.0),
                          blurRadius: 6.0,
                        )
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    child: Image(
                      image: new AssetImage('assets/image/Kota.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.purple[100].withOpacity(0.4),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.login_rounded),
                          iconSize: 25.0,
                          color: Colors.black54,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper())),
                        ),
                        Text(
                          "Lokasi anda \n $_startAddress",
                          style: TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.sort_outlined),
                        //   iconSize: 25.0,
                        //   color: Colors.black54,
                        //   onPressed: () => {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => Testqs()))
                        //   }, //ini button untuk kembali pakek pop, jangan lupa ganti
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          iconSize: 25.0,
                          color: Colors.black54,
                          onPressed: () {
                            //AuthServices.signOut();
                            setState(() {
                              _getCurrentLocation();
                            });
                          },
                          //ini button untuk kembali pakek pop, jangan lupa ganti
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20.0,
                  top: 60.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Penginapan Penginapan di',
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Shadow(
                              offset: Offset(1.0, 2.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'Kota',
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Shadow(
                              offset: Offset(1.0, 2.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'Takengon',
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Shadow(
                              offset: Offset(1.0, 2.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Penginapan")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return DataPenginapanHS(
                      hsPenginapan: snapshot.data.docs,
                      datalok: _currentPosition);
                }),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Theme.of(context).accentColor,
      //   foregroundColor: Colors.black,
      //   onPressed: () {
      //     List arr = <int>[];
      // FirebaseFirestore.instance
      //     .collection('Penginapan')
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     print(doc["Nama Penginapan"] +
      //         " - " +
      //         doc["Kamar Saat ini"].toString());

      //     print(arr);
      //   });

      //       _quicksort(arr, 0, arr.length - 1);
      //       // print("aaa$arr");
      //     });
      //     FirebaseFirestore.instance
      //         .collection("Penginapan")
      //         .get()
      //         .then((mydata) {
      //       if (mydata.docs.isNotEmpty) {
      //         for (int i = 0; i < mydata.docs.length; i++) {
      //           mydata.
      //           var ajeja = mydata.docs;
      //           print(ajeja);
      //           mylist.add(ajeja);
      //         }
      //       }
      //       print("nyo $mylist");
      //       _quicksort(mylist, 0, mylist.length - 1);
      //       print("nnyo $mylist");
      //     });
      //     print("sebelum $eeh");
      //     eeh.quickSort();
      //     print("sedudah $eeh");
      //   },
      //   icon: Icon(Icons.filter_list),
      //   label: Text('Filter'), //filter tanggal in sama tanggal out
      // ),
    );
  }
}

void sort(listtobesort, int leftelement, int rightelement) {
  int i = leftelement;
  int j = rightelement;
  int pivotelement = listtobesort[(leftelement + rightelement) ~/ 2];
  while (i <= j) {
    while (listtobesort[i] < pivotelement) {
      i++;
    }
    while (listtobesort[j] > pivotelement) {
      j--;
    }
    if (i <= j) {
      int objtemp = listtobesort[i];
      listtobesort[i] = listtobesort[j];
      listtobesort[j] = objtemp;
      i++;
      j--;
    }
  }
  if (leftelement < j) {
    sort(listtobesort, leftelement, j);
  }
  if (i < rightelement) {
    sort(listtobesort, i, rightelement);
  }
}

class DataPenginapanHS extends StatefulWidget {
  final List<DocumentSnapshot> hsPenginapan;
  final Position datalok;

  const DataPenginapanHS({Key key, this.hsPenginapan, this.datalok})
      : super(key: key);

  @override
  _DataPenginapanHSState createState() => _DataPenginapanHSState();
}

class _DataPenginapanHSState extends State<DataPenginapanHS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: () {
                  AlertDialog jeut = AlertDialog(
                    title: Text("Panduan Penggunaan"),
                    content: Text(
                      """
1. Jika anda pemilik atau operator boleh login pada button pojok kiri atas\n\n2. Untuk Mengurutkan data kamar silhkan, klik pada button urutkan dan pilih sesuai yang anda inginkan.\n\n3.Untuk mendapatkan informasi penginapan silahkan tap pada penginapan yang ingin di halaman.\n\n4. Untuk mendapatkan Maps penginapan, pada halaman informasi penginapan, silahkan scroll ke paling bawah dan klik button view Maps dan untuk mendapatkan rute klik marker penginapan dan pilih salah satu icon pojok kanan bawah """,
                      textAlign: TextAlign.justify,
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return jeut;
                      });
                },
                label: Text(
                  "Panduan Penggunaan",
                  style: TextStyle(color: Colors.white70),
                ),
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  textDirection: TextDirection.ltr,
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.only(right: 15),
              child: TextButton.icon(
                onPressed: () {
                  AlertDialog gass = AlertDialog(
                    backgroundColor: Colors.grey[100],
                    title: Text("Data yang di Urut"),
                    actions: [
                      //str kamar
                      OutlineButton(
                          highlightElevation: 2,
                          highlightedBorderColor: Colors.purpleAccent[100],
                          color: Colors.purpleAccent[100].withOpacity(0.2),
                          onPressed: () {
                            setState(() {
                              widget.hsPenginapan.sort((p1, p2) =>
                                  p1.data()["Kamar Standard"] -
                                  p2.data()["Kamar Standard"]);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Urutkan Kamar Standard",
                            style: TextStyle(color: Colors.black),
                          )),
                      //medium kamar
                      OutlineButton(
                          color: Colors.purpleAccent[100].withOpacity(0.2),
                          highlightElevation: 2,
                          highlightedBorderColor: Colors.purpleAccent[100],
                          onPressed: () {
                            setState(() {
                              widget.hsPenginapan.sort((p1, p2) =>
                                  p1.data()["Kamar Medium"] -
                                  p2.data()["Kamar Medium"]);
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Urutkan Kamar Medium",
                              style: TextStyle(color: Colors.black))),
                      // deluxe kamar
                      OutlineButton(
                          color: Colors.purpleAccent[100].withOpacity(0.2),
                          highlightElevation: 2,
                          highlightedBorderColor: Colors.purpleAccent[100],
                          onPressed: () {
                            setState(() {
                              widget.hsPenginapan.sort((p1, p2) =>
                                  p1.data()["Kamar Deluxe"] -
                                  p2.data()["Kamar Deluxe"]);
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Urutkan Kamar Deluxe",
                              style: TextStyle(color: Colors.black))),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return gass;
                    },
                  );
                  // var kk = widget.hsPenginapan
                  //     .map((e) => e.data()["Kamar Saat ini"])
                  //     .toList();
                  // sort(kk, 0, kk.length - 1);
                  // print("$kk");
                },
                label: Text(
                  "Urutkan",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.sort,
                  color: Colors.white,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
        Container(
          // height: MediaQuery.of(context).size.height - 313,
          height: 465,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
            itemCount:
                widget.hsPenginapan == null ? 0 : widget.hsPenginapan.length,
            itemBuilder: (BuildContext context, int i) {
              String namaPG =
                  widget.hsPenginapan[i].data()["Nama Penginapan"].toString();
              String jenisPG =
                  widget.hsPenginapan[i].data()["Jenis Penginapan"].toString();
              var kamarstr = widget.hsPenginapan[i].data()["Kamar Standard"];
              var kamarmed = widget.hsPenginapan[i].data()["Kamar Medium"];
              var kamardlx = widget.hsPenginapan[i].data()["Kamar Deluxe"];
              var lat = widget.hsPenginapan[i].data()["Latitude"];
              var long = widget.hsPenginapan[i].data()["Longitude"];
              String hargastr =
                  widget.hsPenginapan[i].data()["Harga Standard"].toString();
              String hargamed =
                  widget.hsPenginapan[i].data()["Harga Medium"].toString();
              String hargadlx =
                  widget.hsPenginapan[i].data()["Harga Deluxe"].toString();

              String imgurl =
                  widget.hsPenginapan[i].data()["URL Gambar"].toString();

// INI HAVERSINE YAAAA

              final harvesine = new Haversine.fromDegrees(
                  latitude1: widget.datalok.latitude,
                  longitude1: widget.datalok.longitude,
                  // latitude1: 4.6346335,
                  // longitude1: 96.8431193,
                  latitude2: lat,
                  longitude2: long);
              final tessa = harvesine.distance();

              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HalInformasi(
                            index: widget.hsPenginapan[i].id,
                            jarak: tessa,
                            posisilongg: widget.datalok))),
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    30.0,
                    5.0,
                    20.0,
                    5.0,
                  ),
                  height: MediaQuery.of(context).size.height / 4.7,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            imgurl,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //nama ,kamar tersedia dan terpakai, jeins , jarak , harga
                            Text(namaPG,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500)),
                            //SizedBox(height: 5),
                            // Text(jenisPG,
                            //     style: TextStyle(
                            //         color: Colors.white70,
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w400)),
                            SizedBox(height: 3),
                            Text('Jarak dari lokasi anda sekitar: ',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${harvesine.distance().toStringAsFixed(3)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    ' Km'
                                    //+ " dari lokasi anda"
                                    ,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            Text('Berdasarkan Haversine Formula',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400)),

                            Text("Kamar Tersedia : ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$kamarstr",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                Text(" Kamar Standard, ",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                Text("Rp. ",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                Text("$hargastr",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            SizedBox(height: 3),
                            kamarmed == 0
                                ? Text("Kamar Jenis Medium Tidak Tersedia !",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("$kamarmed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                      Text(" kamar Medium, ",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                      Text("Rp. ",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                      Text("$hargamed",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                            SizedBox(height: 3),
                            kamardlx == 0
                                ? Text("Kamar Jenis Deluxe Tidak Tersedia !",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("$kamardlx",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                      Text(" Kamar Deluxe, ",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                      Text("Rp. ",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                      Text("$hargadlx",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
