import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartPages extends StatefulWidget {
  const CartPages({super.key});

  @override
  State<CartPages> createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  final CollectionReference _cartCollection = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('cart');
  // jumlah dari pesanan
  int jumlah = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('cart'),
        ),
        body: ListView(
          children: [
            Container(
              child: StreamBuilder(
                  stream: _cartCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var items = snapshot.data!.docs;

                    List<Map<String, dynamic>> listData = items.map((doc) {
                      return doc.data() as Map<String, dynamic>;
                    }).toList();

                    return Wrap(
                        children: listData.map((dataItem) {
                      String nama = dataItem['nama'];
                      String jenis = dataItem['jenis'];
                      int rating = dataItem['rating'];
                      int harga = dataItem['harga'];
                      String img = dataItem['img'];

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: height / 3.8,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(5, 4),
                                    blurRadius: 7)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      img,
                                      height: height / 8,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 20),
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
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Rp. ${harga.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Sora',
                                              color: Colors.green,
                                              fontSize: 23)),
                                      Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      (jumlah == 0)
                                                          ? jumlah
                                                          : jumlah--;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.minimize_rounded,
                                                    size: 30,
                                                    color: Colors.green,
                                                  )),
                                              Text(jumlah.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Sora',
                                                      fontSize: 17)),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      jumlah++;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 30,
                                                    color: Colors.green,
                                                  ))
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList());
                  }),
            )
          ],
        ));
  }
}
