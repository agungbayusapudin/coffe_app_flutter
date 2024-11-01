import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavotitePages extends StatefulWidget {
  const FavotitePages({super.key});

  @override
  State<FavotitePages> createState() => _FavotitePagesState();
}

class _FavotitePagesState extends State<FavotitePages> {
  final CollectionReference _favoriteProduct = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('favorite');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Favorite',
          style: TextStyle(),
        )),
        body: ListView(
          children: [
            Container(
              child: StreamBuilder(
                  stream: _favoriteProduct.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var items = snapshot.data!.docs;

                    List<Map<String, dynamic>> dataList = items.map((doc) {
                      return doc.data() as Map<String, dynamic>;
                    }).toList();

                    return Wrap(
                        children: dataList.map((itemData) {
                      String nama = itemData['nama'];
                      String jenis = itemData['jenis'];
                      String img = itemData['img'];
                      int harga = itemData['harga'];
                      int rating = itemData['rating'];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: height / 7,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(4, 2),
                                    blurRadius: 10)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(img),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nama,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Sora',
                                            fontSize: 20),
                                      ),
                                      Text(jenis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Sora',
                                              fontSize: 15)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('Rp. ${harga.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Sora',
                                              fontSize: 20)),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(rating.toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 15, top: height / 15),
                                  child: IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList());
                  }),
            ),
          ],
        ));
  }
}
