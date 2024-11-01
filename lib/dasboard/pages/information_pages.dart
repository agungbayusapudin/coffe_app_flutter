import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InformationPages extends StatefulWidget {
  const InformationPages({super.key});

  @override
  State<InformationPages> createState() => _InformationPagesState();
}

class _InformationPagesState extends State<InformationPages> {
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('users');

  // variabel users
  String uidusers = '';
  String namaUser = '';
  String emailUsers = '';

  @override
  void initState() {
    getUidUser();
    getUserAccount(uidusers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ukuran layar
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: height / 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 10,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        emailUsers,
                        style:
                            const TextStyle(fontFamily: 'Sora', fontSize: 20),
                      ),
                      Text(
                        namaUser,
                        style:
                            const TextStyle(fontFamily: 'Sora', fontSize: 15),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: height / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 10,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Row(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Settings',
                              style:
                                  TextStyle(fontFamily: 'Sora', fontSize: 16)),
                          Spacer(),
                          Icon(Icons.navigate_next)
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Row(
                        children: [
                          Icon(
                            Icons.card_travel,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Pesanan',
                              style:
                                  TextStyle(fontFamily: 'Sora', fontSize: 16)),
                          Spacer(),
                          Icon(Icons.navigate_next)
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  void getUidUser() async {
    User? users = FirebaseAuth.instance.currentUser;

    if (users != null) {
      setState(() {
        uidusers = users.uid;
        emailUsers = users.email!;
      });
    }
  }

  Future<void> getUserAccount(String uidusers) async {
    try {
      DocumentSnapshot snapshot = await _userCollection.doc(uidusers).get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;

        setState(() {
          namaUser = data['nama'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
