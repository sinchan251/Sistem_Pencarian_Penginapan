import 'dart:io';
import 'dart:ui';

import 'package:Penginapan_Takengon/Admin/HalAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';

class HalTambahData extends StatefulWidget {
  @override
  _HalTambahDataState createState() => _HalTambahDataState();
}

class _HalTambahDataState extends State<HalTambahData> {
  List<String> jenispenginapan = <String>[
    'Hotel',
    'Wisma',
    'Hostel',
    'Guesthouse',
    'Resort',
    'Villa',
    'HomeStay'
  ];

  String namapg,
      idop,
      idpm,
      jenispg,
      alamat,
      infopg,
      fasilitas,
      jumlahkmr,
      kmrstr,
      hargastr,
      kmrmed,
      hargamed,
      kmrdlx,
      hargadlx,
      lat,
      long,
      notelp;

  bool _isLoading = false;

  final TextEditingController idPGController = TextEditingController();

  // File selectedimage;
  // void getImage() async {
  //   final image = await ImagePicker().getImage(source: ImageSource.gallery);

  //   setState(() {
  //     selectedimage = image as File;
  //   });
  // }
  File selectedimage;
  void getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedimage = image;
    });
  }

  uploadgambar() async {
    if (selectedimage != null) {
      // up gambar ke firebaser strage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("Gambar Penginapan")
          .child("${randomAlphaNumeric(8)}.jpg");

      final TaskSnapshot uploadtask = await ref.putFile(selectedimage);

      var downurl = await uploadtask.ref.getDownloadURL();
      print("this is irl $downurl");

      userSetup(
              downurl,
              namapg,
              idop,
              idpm,
              jenispg,
              alamat,
              infopg,
              fasilitas,
              jumlahkmr,
              kmrstr,
              hargastr,
              kmrmed,
              hargamed,
              kmrdlx,
              hargadlx,
              lat,
              long,
              notelp)
          .then((result) {});
    } else {}
  }

//ini servise database
  Future<void> userSetup(
      String downurl,
      namapg,
      idop,
      idpm,
      jenispg,
      alamat,
      infopg,
      fasilitas,
      jumlahkmr,
      kmrstr,
      hargastr,
      kmrmed,
      hargamed,
      kmrdlx,
      hargadlx,
      lat,
      long,
      notelp) async {
    CollectionReference pg =
        FirebaseFirestore.instance.collection('Penginapan');
    await pg.doc(idPGController.text).set({
      "ID PG": idPGController.text,
      "URL Gambar": downurl,
      "Nama Penginapan": namapg,
      "ID Pemilik": idpm,
      "ID Operator": idop,
      "Jenis Penginapan": jenispg,
      "Kamar Standard": int.parse(kmrstr),
      "Harga Standard": hargastr,
      "Kamar Medium": int.parse(kmrmed),
      "Harga Medium": hargamed,
      "Kamar Deluxe": int.parse(kmrdlx),
      "Harga Deluxe": hargadlx,
      "Jumlah Kamar": int.parse(jumlahkmr),
      "Latitude": double.parse(lat),
      "Longitude": double.parse(long),
      "Alamat Penginapan": alamat,
      "Informasi Penginapan": infopg,
      "Fasilitas": fasilitas,
      "Nomor Telpon": notelp,
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    final filename = selectedimage != null
        ? basename(selectedimage.path)
        : 'No file choosen';

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Tambah Data"),
        ),
        body: _isLoading
            ? Container(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              )
            : ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tambah Data Penginapan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          wordSpacing: 1.2,
                          color: Colors.purpleAccent[100],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // color: Colors.red,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: Color(0xFF6e468a),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(55, 35, 69, 0.1),
                                  offset: Offset(6, 2),
                                  blurRadius: 6.0,
                                  spreadRadius: 3.0),
                              BoxShadow(
                                  color: Color.fromRGBO(55, 35, 69, 0.9),
                                  offset: Offset(-6, -2),
                                  blurRadius: 6.0,
                                  spreadRadius: 3.0),
                              BoxShadow(
                                  color: Color.fromRGBO(55, 35, 69, 0.1),
                                  offset: Offset(2, 6),
                                  blurRadius: 6.0,
                                  spreadRadius: 3.0),
                              BoxShadow(
                                  color: Color.fromRGBO(55, 35, 69, 0.9),
                                  offset: Offset(-2, -6),
                                  blurRadius: 6.0,
                                  spreadRadius: 3.0)
                            ]),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: idPGController,
                              style: TextStyle(
                                  // controller: idController,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "*kodeangka_namapenginapan",
                                  hintText: 'ID Penginapan',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "ID Penginapan",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                namapg = val;
                              },
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Nama Penginapan',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Nama Penginapan",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .where('Role', isEqualTo: 'operator')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: Text("Loading...."));
                                  } else {
                                    List<DropdownMenuItem> aoperator = [];
                                    for (int i = 0;
                                        i < snapshot.data.docs.length;
                                        i++) {
                                      DocumentSnapshot snap =
                                          snapshot.data.docs[i];
                                      aoperator.add(DropdownMenuItem(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snap.data()['ID OP'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      Colors.purpleAccent[100]),
                                            ),
                                            SizedBox(
                                              width: 1.0,
                                            ),
                                            Text(snap.data()["Nama"].toString())
                                          ],
                                        ),
                                        value: "${snap.id}",
                                      ));
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Nama Operator :",
                                            style: TextStyle(
                                                color:
                                                    Colors.purpleAccent[100])),
                                        Center(
                                          child: DropdownButton(
                                            focusColor:
                                                Theme.of(context).accentColor,
                                            dropdownColor: Color(0xFF6e468a),
                                            items: aoperator,
                                            onChanged: (pilihop) {
                                              print('$pilihop');
                                              setState(() {
                                                idop = pilihop;
                                              });
                                            },
                                            value: idop,
                                            isExpanded: true,
                                            hint: Text(
                                              "pilih Operator",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                }),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .where('Role', isEqualTo: 'Pemilik')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: Text("Loading...."));
                                  } else {
                                    List<DropdownMenuItem> apemilik = [];
                                    for (int i = 0;
                                        i < snapshot.data.docs.length;
                                        i++) {
                                      DocumentSnapshot snap =
                                          snapshot.data.docs[i];
                                      apemilik.add(DropdownMenuItem(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snap.data()['ID PM'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      Colors.purpleAccent[100]),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(snap.data()["Nama"].toString())
                                          ],
                                        ),
                                        value: "${snap.id}",
                                      ));
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Nama Pemilik :",
                                            style: TextStyle(
                                                color:
                                                    Colors.purpleAccent[100])),
                                        Center(
                                          child: DropdownButton(
                                            focusColor:
                                                Theme.of(context).accentColor,
                                            dropdownColor: Color(0xFF6e468a),
                                            items: apemilik,
                                            onChanged: (pilihPM) {
                                              print('$pilihPM');
                                              setState(() {
                                                idpm = pilihPM;
                                              });
                                            },
                                            value: idpm,
                                            isExpanded: false,
                                            hint: Text(
                                              "pilih Pemilik",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Jenis Penginapan :",
                                    style: TextStyle(
                                        color: Colors.purpleAccent[100])),
                                Center(
                                  child: DropdownButton(
                                    focusColor: Theme.of(context).accentColor,
                                    dropdownColor: Color(0xFF6e468a),
                                    items: jenispenginapan
                                        .map((value) => DropdownMenuItem(
                                              child: Text(value,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (pilihjenis) {
                                      print('$pilihjenis');
                                      setState(() {
                                        jenispg = pilihjenis;
                                      });
                                    },
                                    value: jenispg,
                                    isExpanded: false,
                                    hint: Text(
                                      "pilih jenis penginapan anda",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              onChanged: (val) {
                                kmrstr = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Kamar Tersedia',
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "jika Ada, Jika tidak isi 0",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Kamar Standard Tersedia",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                hargastr = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "*200.000, jika tidak ada isi 0",
                                  hintText: 'Harga',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Harga Kamar Standard",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                kmrmed = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Kamar Medium Tersedia',
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "jika Ada, Jika tidak isi 0",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Kamar Medium Tersedia",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                hargamed = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "*200.000, jika tidak ada isi 0",
                                  hintText: 'Harga',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Harga Kamar Medium",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                kmrdlx = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Kamar deluxe Tersedia',
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "jika Ada, Jika tidak isi 0",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Kamar Deluxe Tersedia",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                hargadlx = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  helperStyle: TextStyle(color: Colors.black26),
                                  helperText: "*200.000, jika tidak ada isi 0",
                                  hintText: 'Harga',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Harga Kamar Deluxe",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                jumlahkmr = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Jumlah Kamar',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Jumlah Total seluruh Kamar",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                lat = val;
                                double.parse(lat);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Latitude',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Latitude",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                long = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Longitude',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Longitude",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                notelp = val;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: '08xx-xxxx-xxxx',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Nomor Telpon",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (val) {
                                alamat = val;
                              },
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Alamat ',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Alamat Penginapan",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              onChanged: (val) {
                                infopg = val;
                              },
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  hintText: 'Informasi Penginapan ',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.5),
                                  ),
                                  labelText: "Info",
                                  labelStyle: TextStyle(
                                      color: Colors.purpleAccent[100],
                                      fontSize: 12)),
                            ),
                            MultiSelect(
                                titleText: "Pilih Fasilitas",
                                searchBoxFillColor: Colors.grey[200],
                                checkBoxColor: Colors.purpleAccent[100],
                                clearButtonTextColor: Colors.white,
                                clearButtonColor: Colors.purpleAccent[100],
                                saveButtonColor: Colors.purpleAccent[100],
                                buttonBarColor: Colors.transparent,
                                cancelButtonColor: Colors.purpleAccent[100],
                                selectedOptionsBoxColor: Colors.transparent,
                                titleTextColor: Colors.purpleAccent[100],
                                enabledBorderColor: Colors.transparent,
                                selectIconColor: Colors.purpleAccent[100],
                                autovalidate: false,
                                dataSource: [
                                  {
                                    "display": "Dinner",
                                    "value": "Dinner",
                                  },
                                  {
                                    "display": "Lunch",
                                    "value": 'Lunch',
                                  },
                                  {
                                    "display": "Wi-fi",
                                    "value": 'Wi-fi',
                                  },
                                  {
                                    "display": "Restaurant",
                                    "value": 'Restaurant',
                                  },
                                  {
                                    "display": "Room Service",
                                    "value": 'Room Service',
                                  },
                                  {
                                    "display": "Kedai Kopi",
                                    "value": 'Kedai Kopi',
                                  },
                                ],
                                inputBoxFillColor: Colors.transparent,
                                textField: "display",
                                hintText: '',
                                selectedOptionsInfoText:
                                    'Fasilitas yang dipilih :',
                                valueField: 'value',
                                value: null,
                                change: (display) {
                                  fasilitas = '$display';
                                  print('The value is $display');
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Upload Gambar Penginapan anda",
                                style: TextStyle(
                                    color: Colors.purpleAccent[100],
                                    fontSize: 14)),
                            SizedBox(height: 10),
                            Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: selectedimage != null
                                        ? Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                // height: 150,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: new Image.file(
                                                    selectedimage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            ],
                                          )
                                        : Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                                Icons.add_a_photo_rounded,
                                                color:
                                                    Colors.purpleAccent[100]),
                                          ),
                                  ),
                                  Text(filename),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // ignore: deprecated_member_use
                            OutlineButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.purpleAccent[100],
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Colors.purpleAccent[100],
                              onPressed: () {
                                uploadgambar();

                                AlertDialog alert = AlertDialog(
                                  title: Text("Data berhasil di tambah"),
                                  content: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HalAdmin()));
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
                              child: Text('Submit',
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]));
  }
}
