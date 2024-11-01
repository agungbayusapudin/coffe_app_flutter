import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseweb/dasboard/dashboard_pages.dart';
import 'package:firebaseweb/dasboard/pages/buy%20pages/buy_pages.dart';
import 'package:flutter/material.dart';

class DetailOrder extends StatefulWidget {
  String nama;
  String jenis;
  int harga;
  int rating;
  String deskripsi;
  String img;

  DetailOrder(
      {super.key,
      required this.jenis,
      required this.nama,
      required this.harga,
      required this.rating,
      required this.deskripsi,
      required this.img});

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  // collection firebase
  final CollectionReference _favoriteProduct = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('favorite');

  final CollectionReference _cartProduct = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('cart');

  // variabel documeten id
  String documentIdFavorite = '';
  String documentIdCart = '';
  String selectedSize = '';

  // selection favorite icon
  bool selectedFavorite = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Detail',
            style: TextStyle(fontFamily: 'Sora'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedFavorite = !selectedFavorite;
                });
                (selectedFavorite == true)
                    ? addDataToFavorite(widget.nama, widget.jenis, widget.harga,
                        widget.rating, widget.img)
                    : deleteFromFavorite(documentIdFavorite);
              },
              icon: Icon(
                Icons.favorite,
                color: (selectedFavorite == true) ? Colors.red : Colors.black,
              ),
              iconSize: 30,
            )
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPages()));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: width,
              height: height / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.img), fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: height / 16,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nama,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.jenis,
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Sora',
                            color: Color.fromARGB(255, 89, 89, 89)),
                      )
                    ],
                  ),
                  Positioned(
                      child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 30,
                      ),
                      Text(widget.rating.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.bold))
                    ],
                  ))
                ],
              ),
            ),
          ),
          // untuk line garis warna hitam menggunakan diver
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            child: SizedBox(
              height: height / 9,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(widget.deskripsi,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Sora',
                          color: Color.fromARGB(255, 77, 77, 77)))
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Text('Size',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SizedBox(
              height: height / 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: width / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 1),
                                blurRadius: 1)
                          ],
                          border: (selectedSize == 's')
                              ? Border.all(color: Colors.green)
                              : const Border(),
                          color: Colors.white),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSize = 's';
                          });
                        },
                        child: Text('S',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Sora',
                                color: (selectedSize == 's')
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                      )),
                  Container(
                      width: width / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 1),
                                blurRadius: 1)
                          ],
                          border: (selectedSize == 'm')
                              ? Border.all(color: Colors.green)
                              : const Border(),
                          color: Colors.white),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSize = 'm';
                          });
                        },
                        child: Text('M',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Sora',
                                color: (selectedSize == 'm')
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                      )),
                  Container(
                      width: width / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 1),
                                blurRadius: 1)
                          ],
                          border: (selectedSize == 'l')
                              ? Border.all(color: Colors.green)
                              : const Border(),
                          color: Colors.white),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSize = 'l';
                          });
                        },
                        child: Text('L',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Sora',
                                color: (selectedSize == 'l')
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Color.fromARGB(255, 230, 228, 228)),
        height: height / 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Sora', fontSize: 18),
                ),
                Text(
                  'RP ${widget.harga.toString()}',
                  style: const TextStyle(
                      color: Colors.green, fontFamily: 'Sora', fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: height / 15,
                  width: width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: TextButton(
                      onPressed: () {
                        (documentIdCart == '')
                            ? addDataToCart(widget.nama, widget.jenis,
                                widget.harga, widget.rating, widget.img)
                            : Container();
                      },
                      child: const Text(
                        'Add Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sora',
                            fontSize: 20),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: height / 15,
                  width: width / 3.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: TextButton(
                      onPressed: () {
                        if (selectedSize.isNotEmpty) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyPages(
                                      nama: widget.nama,
                                      jenis: widget.jenis,
                                      harga: widget.harga,
                                      rating: widget.rating,
                                      img: widget.img,
                                      ukuran: selectedSize)));
                        }
                      },
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sora',
                            fontSize: 20),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> addDataToFavorite(
      String nama, String jenis, int harga, int rating, String img) async {
    // membaut doct reference untuk memuat id dari data yang baru dimasukan
    var docRef = await _favoriteProduct.add({
      'nama': nama,
      'jenis': jenis,
      'harga': harga,
      'rating': rating,
      'img': img
    });

    setState(() {
      documentIdFavorite = docRef.id;
    });
  }

  Future<void> addDataToCart(
      String nama, String jenis, int harga, int rating, String img) async {
    var docRef = await _cartProduct.add({
      'nama': nama,
      'jenis': jenis,
      'harga': harga,
      'rating': rating,
      'img': img
    });

    setState(() {
      documentIdCart = docRef.id;
    });
  }

  Future<void> deleteFromFavorite(String documentId) async {
    await _favoriteProduct.doc(documentId).delete();
  }
}
