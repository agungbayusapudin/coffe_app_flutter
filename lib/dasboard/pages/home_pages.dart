import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseweb/dasboard/pages/detail_pages.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  // colection untuk data product
  final CollectionReference _productCollection = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('product');

  final CollectionReference _cartCollection = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('cart');

  // item dari data user
  String uidUser = '';
  String nameUser = '';

  // selected untuk jenis kopi
  int index = 0;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(100, height),
            child: Container(
              width: width,
              height: 120,
              color: Colors.black,
              child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (nameUser == '')
                          ? const Text('kesalahan Login')
                          : Text(
                              nameUser,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                      Container(
                        height: 100,
                        width: 60,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/trailing.png'),
                                fit: BoxFit.contain)),
                      )
                    ],
                  )),
            )),
        // body list view agar dapat discroll
        body: ListView(
          children: [
            // stack berupa gamabr yang di tindih unutk home page
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: height / 4,
                      width: width,
                      color: Colors.black,
                      child: Column(
                        children: [
                          // form pencarian pada
                          Form(
                              child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 91, 90, 90),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                suffixIcon: const Icon(
                                  Icons.filter_list,
                                  size: 30,
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 60, 139, 63),
                                prefixIcon: const Icon(
                                  Icons.coffee,
                                  color: Colors.white,
                                  size: 25,
                                )),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      // widget terpisah dibawah dengan widget nama widget row
                      child: list_product(),
                    )
                  ],
                ),
                // gambar yang berada di tengah antara 2 warna hitam dan putih
                Positioned(
                  left: 40,
                  right: 40,
                  top: height / 8,
                  child: Stack(
                    children: [
                      Container(
                        height: height / 4,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/image_2.png'),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        top: height / 20,
                        left: width / 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: height / 30,
                              width: width / 4,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Promo',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Sora'),
                              ),
                            ),
                            SizedBox(
                              height: height / 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height / 20,
                              width: width / 2,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: const Text(
                                'Buy one get',
                                style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: width / 50,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height / 20,
                              width: width / 2,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: const Text(
                                'one FREE',
                                style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
                height: height / 1.6,
                width: width,
                child: StreamBuilder(
                    stream: _productCollection.snapshots(),
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
                        String deskripsi = itemData['deskripsi'];
                        int rating = itemData['rating'];

                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(26, 127, 125, 125)),
                            height: height / 4,
                            width: width / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height / 8,
                                  width: width / 2.5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(img),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    nama,
                                    style: const TextStyle(
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    jenis,
                                    style: const TextStyle(
                                        fontFamily: 'Sora',
                                        color:
                                            Color.fromARGB(255, 125, 125, 125),
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'RP. ${harga.toString()}',
                                        style: const TextStyle(
                                            fontFamily: 'Sora',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailOrder(
                                                          nama: nama,
                                                          jenis: jenis,
                                                          harga: harga,
                                                          deskripsi: deskripsi,
                                                          rating: rating,
                                                          img: img)));
                                        },
                                        icon: const Icon(Icons.add),
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList());
                    })),
          ],
        ));
  }

  Row list_product() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 0;
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: (index == 0) ? Colors.redAccent : Colors.grey),
          child: Text(
            'Capuchino',
            style: TextStyle(
                color: (index == 0) ? Colors.white : Colors.black,
                fontFamily: 'Sora'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 1;
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: (index == 1) ? Colors.redAccent : Colors.grey),
          child: Text(
            'Macchiato',
            style: TextStyle(
                color: (index == 1) ? Colors.white : Colors.black,
                fontFamily: 'Sora'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 2;
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: (index == 2) ? Colors.redAccent : Colors.grey),
          child: Text(
            'Expresso',
            style: TextStyle(
                color: (index == 2) ? Colors.white : Colors.black,
                fontFamily: 'Sora'),
          ),
        )
      ],
    );
  }

  Future<void> addItemToCart(String nama, String jenis, int harga, String img,
      String deskripsi, int rating) async {
    await _cartCollection.add({
      'nama': nama,
      'jenis': jenis,
      'harga': harga,
      'img': img,
      'deskripsi': deskripsi,
      'rating': rating
    });
  }

  void getUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        uidUser = user.uid;
        nameUser = user.email!;
      });
    }
  }
}
