import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';

import 'Home_Screen.dart';
import 'Maps.dart';

class HalInformasi extends StatefulWidget {
  final Position posisilongg;

  final jarak;
  final index;

  const HalInformasi({Key key, this.index, this.jarak, this.posisilongg})
      : super(key: key);

  @override
  _HalInformasiState createState() =>
      _HalInformasiState(this.jarak, this.posisilongg);
}

class _HalInformasiState extends State<HalInformasi> {
  final jarak;
  final Position posisilongg;

  _HalInformasiState(this.jarak, this.posisilongg);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.index),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            iconSize: 25.0,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen())),
          )),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Penginapan")
                .where("ID PG", isEqualTo: widget.index)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return DataPenginapanHSL(
                  hslPenginapan: snapshot.data.docs,
                  jarakk: jarak,
                  loklong: posisilongg);
            }),
      ),
    );
  }
}

class DataPenginapanHSL extends StatelessWidget {
  final List<DocumentSnapshot> hslPenginapan;
  final jarakk;
  final Position loklong;

  const DataPenginapanHSL(
      {Key key, this.hslPenginapan, this.jarakk, this.loklong})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: hslPenginapan == null ? 0 : hslPenginapan.length,
          itemBuilder: (context, i) {
            String namaPG =
                hslPenginapan[i].data()["Nama Penginapan"].toString();
            String jenisPG =
                hslPenginapan[i].data()["Jenis Penginapan"].toString();
            String fasilitas = hslPenginapan[i].data()["Fasilitas"].toString();
            String jumlahkamar =
                hslPenginapan[i].data()["Jumlah Kamar"].toString();
            var kamarstr = hslPenginapan[i].data()["Kamar Standard"].toString();
            var kamarmed = hslPenginapan[i].data()["Kamar Medium"].toString();
            var kamardlx = hslPenginapan[i].data()["Kamar Deluxe"].toString();
            String hargastr =
                hslPenginapan[i].data()["Harga Standard"].toString();
            String hargamed =
                hslPenginapan[i].data()["Harga Medium"].toString();
            String hargadlx =
                hslPenginapan[i].data()["Harga Deluxe"].toString();

            String alamat =
                hslPenginapan[i].data()["Alamat Penginapan"].toString();
            String info =
                hslPenginapan[i].data()["Informasi Penginapan"].toString();
            String imgurl = hslPenginapan[i].data()["URL Gambar"].toString();
            var lat = hslPenginapan[i].data()["Latitude"];
            var long = hslPenginapan[i].data()["Longitude"];
            String nomortelp = hslPenginapan[i].data()["Nomor Telpon"];

            final aaa = jarakk.toStringAsFixed(3);

            return Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imgurl,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            namaPG,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.purple[100],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ($aaa Km)",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.purple[100],
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            fasilitas,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple[100],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        info,
                        style: TextStyle(color: Colors.purple[100]),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Text(
                        alamat,
                        style: TextStyle(color: Colors.purple[100]),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Info Kamar",
                        style: TextStyle(
                            color: Colors.purpleAccent[200], fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Kamar Standard ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.purple[100],
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Harga: Rp. $hargastr / Malam",
                              style: TextStyle(
                                color: Colors.purple[100],
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      hargamed == "0"
                          ? Text(
                              "Kamar Deluxe Tidak ada",
                              style: TextStyle(
                                  color: Colors.purple[100],
                                  fontWeight: FontWeight.bold),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Kamar Medium ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.purple[100],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Harga: Rp. $hargamed / Malam",
                                    style: TextStyle(
                                      color: Colors.purple[100],
                                    )),
                              ],
                            ),
                      SizedBox(height: 10),
                      hargadlx == "0"
                          ? Text(
                              "Kamar Deluxe Tidak ada",
                              style: TextStyle(
                                  color: Colors.purple[100],
                                  fontWeight: FontWeight.bold),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Kamar Deluxe ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.purple[100],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Harga: Rp. $hargadlx / Malam",
                                    style: TextStyle(
                                      color: Colors.purple[100],
                                    )),
                              ],
                            ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 100,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.hotel,
                                  color: Colors.purpleAccent[100],
                                  size: 30,
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    jumlahkamar + " Kamar",
                                    style: TextStyle(color: Colors.purple[100]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 100,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.purpleAccent[100],
                                  size: 30,
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    jenisPG,
                                    style: TextStyle(color: Colors.purple[100]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.purpleAccent[100],
                                  size: 30,
                                ),
                                SizedBox(height: 8),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "$nomortelp",
                                      style:
                                          TextStyle(color: Colors.purple[100]),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            //olor: Colors.purple.withOpacity(0.3),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.purpleAccent[100],
                          onPressed: () {
                            print(loklong);
                            print(lat);
                            print(long);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Maps(
                                          posisilong: loklong,
                                          latpg: lat,
                                          longpg: long,
                                        )));
                          },
                          child: Text("View Maps",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )),
                        )),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
