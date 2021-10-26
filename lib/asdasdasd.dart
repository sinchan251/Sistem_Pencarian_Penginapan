import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sort/sort.dart';

class Testqs extends StatefulWidget {
  @override
  _TestqsState createState() => _TestqsState();
}

class _TestqsState extends State<Testqs> {
  var list = <double>[9.3, 12.4, 2, 3, 6, 7];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            iconSize: 25.0,
            color: Colors.black54,
            onPressed: () {
              //AuthServices.signOut();
              setState(() {
                // _quicksort(data, 0, data.length - 1);
                list.quickSort();
              });
            },
            //ini button untuk kembali pakek pop, jangan lupa ganti
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text("$list"),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Penginapan")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return Qstestqs(
                    qsqs: snapshot.data.docs,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
_quicksort(listtobesort, int leftelement, int rightelement) {
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
    _quicksort(listtobesort, leftelement, j);
  }
  if (i < rightelement) {
    _quicksort(listtobesort, i, rightelement);
  }
}

class Qstestqs extends StatefulWidget {
  final List<QueryDocumentSnapshot> qsqs;

  const Qstestqs({
    Key key,
    this.qsqs,
  }) : super(key: key);

  @override
  _QstestqsState createState() => _QstestqsState();
}

class _QstestqsState extends State<Qstestqs> {
  _qqqq() {}

  _tess() {
    // final List<QueryDocumentSnapshot> qwqw = widget.qsqs;
    // qwqw.map((e) => e.data()["Kamar Saat ini"]).toList();
    // _quickSortA(qwqw.map((e) => e.data()["Kamar Saat ini"]).toList(), 0,
    //     qwqw.length - 1);

    // qwqw.forEach((element) {
    //   print(element.data()["Nama Penginapan"] +
    //       " - " +
    //       element.data()["Kamar Saat ini"].toString());
    // });

    // widget.qsqs.forEach((element) {
    //   print(element.data()["Nama Penginapan"] +
    //       " - " +
    //       element.data()["Kamar Saat ini"].toString());
    // });

    // List kk = widget.qsqs.map((e) => e.data()["Kamar Saat ini"]).toList();
    // _quicksort(kk, 0, kk.length - 1);
    // kk.forEach((element) {
    //   print(element);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: deprecated_member_use
        RaisedButton(
            child: Text("urutkan"),
            onPressed: () {
              setState(() {
                _tess();
              });
            }),
        Container(
          color: Colors.red,
          height: 200,
          child: ListView.builder(
              itemCount: widget.qsqs.length,
              itemBuilder: (BuildContext context, int i) {
                String namaPG =
                    widget.qsqs[i].data()["Nama Penginapan"].toString();
                String jenisPG =
                    widget.qsqs[i].data()["Jenis Penginapan"].toString();
                var kamarnow = widget.qsqs[i].data()["Kamar Saat ini"];
                var lat = widget.qsqs[i].data()["Latitude"];
                var long = widget.qsqs[i].data()["Longitude"];
                String harga = widget.qsqs[i].data()["Harga"].toString();

                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(namaPG),
                      Text(jenisPG),
                      Text("$kamarnow"),
                      Text(harga),
                      Text("$lat" + " , " + "$long"),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

int _partitionA(List arr, int low, int high) {
  var pivot = arr[high]; // pivot
  var i = (low - 1); // Index of smaller element

  for (int j = low; j <= high - 1; j++) {
    // If current element is smaller than the pivot
    if (arr[j].runtimeType == DateTime) {
      if (arr[j].isBefore(pivot)) {
        i++; // increment index of smaller element
        final temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    } else {
      if (arr[j] < pivot) {
        i++; // increment index of smaller element
        final temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    }
  }
  final temp = arr[i + 1];
  arr[i + 1] = arr[high];
  arr[high] = temp;
  return (i + 1);
}

///Quicksort for int and double
void _quickSortA(List arr, int low, int high) {
  if (low < high) {
    /* pi is partitioning index, arr[p] is now  
        at right place */
    int pi = _partitionA(arr, low, high);

    // Separately sort elements before
    // partition and after partition
    _quickSortA(arr, low, pi - 1);
    _quickSortA(arr, pi + 1, high);
  }
}
