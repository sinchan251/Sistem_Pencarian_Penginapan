import 'package:Penginapan_Takengon/Admin/HalAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class EditPenginapan extends StatefulWidget {
  final index;
  final String idpg,
      namapg,
      idop,
      idpm,
      jenispg,
      alamat,
      infopg,
      fasilitas,
      jumlahkmr,
      kamarstrd,
      hargastrd,
      kamarmdm,
      hargamdm,
      kamardlxe,
      hargadlxe,
      lat,
      long,
      noTelp;

  const EditPenginapan(
      {Key key,
      this.index,
      this.idpg,
      this.namapg,
      this.idop,
      this.idpm,
      this.jenispg,
      this.alamat,
      this.infopg,
      this.fasilitas,
      this.jumlahkmr,
      this.kamarstrd,
      this.hargastrd,
      this.kamarmdm,
      this.hargamdm,
      this.kamardlxe,
      this.hargadlxe,
      this.lat,
      this.long,
      this.noTelp})
      : super(key: key);
  @override
  _EditPenginapanState createState() => _EditPenginapanState();
}

class _EditPenginapanState extends State<EditPenginapan> {
  final TextEditingController idPGController = TextEditingController();
  final TextEditingController namapgg = TextEditingController();
  final TextEditingController idopp = TextEditingController();
  final TextEditingController idpmm = TextEditingController();
  final TextEditingController jenispgg = TextEditingController();
  final TextEditingController alamatt = TextEditingController();
  final TextEditingController infopgg = TextEditingController();
  String fasilitass;
  final TextEditingController jumlahkmrr = TextEditingController();
  final TextEditingController kamarstrdd = TextEditingController();
  final TextEditingController hargastrdd = TextEditingController();
  final TextEditingController kamarmedmm = TextEditingController();
  final TextEditingController hargamedmm = TextEditingController();
  final TextEditingController kamardlxee = TextEditingController();
  final TextEditingController hargadlxee = TextEditingController();
  final TextEditingController latt = TextEditingController();
  final TextEditingController longg = TextEditingController();
  final TextEditingController notelepon = TextEditingController();

  void setValueForm() {
    idPGController.text = widget.idpg;
    namapgg.text = widget.namapg;
    idopp.text = widget.idop;
    idpmm.text = widget.idpm;
    jenispgg.text = widget.jenispg;
    alamatt.text = widget.alamat;
    infopgg.text = widget.infopg;
    fasilitass = widget.fasilitas;
    jumlahkmrr.text = widget.jumlahkmr;
    kamarstrdd.text = widget.kamarstrd;
    hargastrdd.text = widget.hargastrd;
    kamarmedmm.text = widget.kamarmdm;
    hargamedmm.text = widget.hargamdm;
    kamardlxee.text = widget.kamardlxe;
    hargadlxee.text = widget.hargadlxe;
    latt.text = widget.lat;
    longg.text = widget.long;
    notelepon.text = widget.noTelp;
  }

  void prosesEditPG(String fasilitass) {
    FirebaseFirestore.instance.runTransaction((Transaction tr) async {
      DocumentSnapshot snapshot = await tr.get(widget.index);
      tr.update(snapshot.reference, {
        "Nama Penginapan": namapgg.text,
        "Nama Pemilik": idpmm.text,
        "Nama Operator": idopp.text,
        "Jenis Penginapan": jenispgg.text,
        "Jumlah Kamar": int.parse(jumlahkmrr.text),
        "Latitude": double.parse(latt.text),
        "Longitude": double.parse(longg.text),
        "Kamar Standard": int.parse(kamarstrdd.text),
        "Harga Standard": hargastrdd.text,
        "Kamar Medium": int.parse(kamarmedmm.text),
        "Harga Medium": hargamedmm.text,
        "Kamar Deluxe": int.parse(kamardlxee.text),
        "Harga Deluxe": hargadlxee.text,
        "Alamat Penginapan": alamatt.text,
        "Informasi Penginapan": infopgg.text,
        "Fasilitas": fasilitass,
        "Nomor Telpon": notelepon.text,
      });
      AlertDialog alert = AlertDialog(
        content: Text("Data berhasil di Update"),
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HalAdmin())),
              child: Text("Kembali"))
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

  @override
  void initState() {
    setValueForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Edit"),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Edit Data Penginapan",
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
                        enabled: false,
                        controller: idPGController,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'ID Penginapan',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "ID Penginapan",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: namapgg,
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
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: jenispgg,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Jenis Penginapan',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Jenis Penginapan",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: jumlahkmrr,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Jumlah Kamar',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Jumlah Kamar",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: notelepon,
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
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: latt,
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
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: longg,
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
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: kamarstrdd,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'kamar Standard tersedia',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Kamar Standard tersedia",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: hargastrdd,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Harga kamar Standard',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Harga Kamar Standard",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: kamarmedmm,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'kamar Medium tersedia',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Kamar Medium tersedia",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: hargamedmm,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Harga kamar Medium',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Harga Kamar Medium",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: kamardlxee,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'kamar Deluxe tersedia',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Kamar Deluxe tersedia",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: hargadlxee,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: 'Harga kamar Deluxe',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5),
                            ),
                            labelText: "Harga Kamar Deluxe",
                            labelStyle: TextStyle(
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: alamatt,
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
                                color: Colors.purpleAccent[100], fontSize: 12)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: infopgg,
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
                                color: Colors.purpleAccent[100], fontSize: 12)),
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
                          selectedOptionsInfoText: 'Fasilitas yang dipilih :',
                          valueField: 'value',
                          value: null,
                          change: (display) {
                            fasilitass = '$display';
                            print('The value is $display');
                          }),
                      SizedBox(
                        height: 20,
                      ),
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
                            side: BorderSide(color: Colors.red)),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 12, color: Colors.purple[900])),
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
                        onPressed: () => prosesEditPG(fasilitass),
                        child: Text('Submit', style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  kamartxtfield(TextEditingController kamarr, String jenis) {
    TextField(
      keyboardType: TextInputType.number,
      controller: kamarr,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          hintText: 'kamar $jenis tersedia',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 1.5),
          ),
          labelText: "Kamar $jenis tersedia",
          labelStyle: TextStyle(color: Colors.purpleAccent[100], fontSize: 12)),
    );
    SizedBox(
      height: 10,
    );
  }

  hargatxtfield(TextEditingController hargaa, String jeniss) {
    TextField(
      keyboardType: TextInputType.number,
      controller: hargaa,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          hintText: 'Harga',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 1.5),
          ),
          labelText: "Harga Kamar $jeniss",
          labelStyle: TextStyle(color: Colors.purpleAccent[100], fontSize: 12)),
    );
    SizedBox(
      height: 10,
    );
  }
}
