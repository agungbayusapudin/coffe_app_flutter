import 'package:firebaseweb/dasboard/pages/buy%20pages/tracking_pages.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BuyPages extends StatefulWidget {
  String nama;
  String jenis;
  int harga;
  int rating;
  String img;
  String ukuran;

  BuyPages(
      {super.key,
      required this.nama,
      required this.jenis,
      required this.harga,
      required this.rating,
      required this.img,
      required this.ukuran});

  @override
  State<BuyPages> createState() => _BuyPagesState();
}

class _BuyPagesState extends State<BuyPages> {
  // variabel data pada edit

  bool selectedOrder =
      false; // untuk kondisi ketika order oilihan button dipilih

  int jumlah =
      0; // variabel jumlah untuk mengatur setiap penambahan nilai pesanan

  int totalHarga = 0; // pengatur jumlah harga keseluruhan

  // text controller
  final TextEditingController _alamatUtama = TextEditingController();
  final TextEditingController _alamatLengkap = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  @override
  void dispose() {
    _alamatLengkap.dispose();
    _alamatUtama.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ukuran layar
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Order'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: height / 15,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: height / 15,
                        width: width / 2,
                        decoration: BoxDecoration(
                            color: (selectedOrder == false)
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedOrder = false;
                              });
                            },
                            child: const Text('Deliver',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontFamily: 'Sora'))),
                      ),
                    ),
                    Positioned(
                      left: width / 2.3,
                      child: Container(
                        height: height / 15,
                        width: width / 2.1,
                        decoration: BoxDecoration(
                            color: (selectedOrder == true)
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedOrder = true;
                              });
                            },
                            child: const Text('Pick Up',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontFamily: 'Sora'))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: height / 2.8,
              width: width,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 25),
                    child: SizedBox(
                      height: height / 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Delivery Address',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sora',
                                  fontSize: 18)),
                          const SizedBox(height: 10),
                          Text(_alamatUtama.text,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sora',
                                  fontSize: 16)),
                          Text(_alamatLengkap.text,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Sora',
                                  fontSize: 15)),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: height / 25,
                                width: width / 3,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              scrollable: true,
                                              title: const Text('Edit Address'),
                                              content: SizedBox(
                                                height: height / 6,
                                                width: width / 1.2,
                                                child: Form(
                                                    child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller: _alamatUtama,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Address'),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          _alamatLengkap,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Address lengkap'),
                                                    )
                                                  ],
                                                )),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Done'))
                                              ],
                                            ));
                                  },
                                  style: TextButton.styleFrom(
                                      shadowColor: Colors.grey),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.edit_calendar_sharp,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        ' Edit Address',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height / 25,
                                width: width / 3.5,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              scrollable: true,
                                              title: const Text('Edit Address'),
                                              content: SizedBox(
                                                height: height / 6,
                                                width: width / 1.2,
                                                child: Form(
                                                    child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller: _notes,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Notes'),
                                                    )
                                                  ],
                                                )),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Done'))
                                              ],
                                            ));
                                  },
                                  style: TextButton.styleFrom(
                                      shadowColor: Colors.grey),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.notes,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'Add Notes',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(
                            widget.img,
                          ),
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.nama,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Sora',
                                    fontSize: 16),
                              ),
                              Text(widget.jenis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Sora',
                                      fontSize: 13))
                            ],
                          ),
                        ),
                        // icon untuk menambhakan banyaknya jumlah pesanan
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 7, top: height / 30),
                          child: SizedBox(
                            height: height / 20,
                            width: width / 3.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        (jumlah > 0) ? jumlah-- : jumlah;
                                        totalHarga = widget.harga * jumlah;
                                      });
                                    },
                                    icon: Image.asset(
                                      'assets/icons/minus.png',
                                      height: 20,
                                    ),
                                  ),
                                ),
                                Text(jumlah.toString()),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        (jumlah < 99) ? jumlah++ : jumlah;
                                        totalHarga = widget.harga * jumlah;
                                      });
                                    },
                                    icon: Image.asset(
                                      'assets/icons/plus.png',
                                      height: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 7,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: height / 3,
                width: width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: height / 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        width: width / 1.2,
                        child: TextButton(
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.discount,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'Discount is applied',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Sora',
                                        fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.chevron_right_outlined,
                                    size: 40,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    const Text('Payment Summary',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Sora',
                            fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 16)),
                        Text(widget.harga.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 16))
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 16)),
                        Text('1000',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 16))
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Payment',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 16)),
                        Text(totalHarga.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 16))
                      ],
                    ),
                    SizedBox(
                      height: height / 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        bottomSheet: Container(
            height: height / 8,
            width: width,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(-1, -2), blurRadius: 7)
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    height: height / 15,
                    width: width / 1.3,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        if (jumlah != 0) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TrackingPages()));
                        }
                      },
                      child: const Text('Order',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sora',
                              fontSize: 20)),
                    )),
              ],
            )));
  }
}
