import 'package:firebaseweb/dasboard/pages/cart_pages.dart';
import 'package:firebaseweb/dasboard/pages/favotite_pages.dart';
import 'package:firebaseweb/dasboard/pages/home_pages.dart';
import 'package:firebaseweb/dasboard/pages/information_pages.dart';
import 'package:flutter/material.dart';

class DashboardPages extends StatefulWidget {
  const DashboardPages({super.key});

  @override
  State<DashboardPages> createState() => _DashboardPagesState();
}

class _DashboardPagesState extends State<DashboardPages> {
  final List Pages = [
    const HomePages(),
    const FavotitePages(),
    const CartPages(),
    const InformationPages()
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: Pages[index],
        bottomNavigationBar: Container(
          height: 100,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2)),
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    icon: Image.asset('assets/icons/home.png')),
                IconButton(
                    onPressed: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    icon: Image.asset('assets/icons/heart.png')),
                IconButton(
                    onPressed: () {
                      setState(() {
                        index = 2;
                      });
                    },
                    icon: Image.asset('assets/icons/shopping-bag.png')),
                IconButton(
                    onPressed: () {
                      setState(() {
                        index = 3;
                      });
                    },
                    icon: Image.asset('assets/icons/bell.png'))
              ],
            ),
          ),
        ));
  }
}
