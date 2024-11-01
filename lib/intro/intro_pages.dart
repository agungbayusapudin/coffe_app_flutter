import 'package:firebaseweb/dasboard/dashboard_pages.dart';
import 'package:flutter/material.dart';

class IntroPages extends StatefulWidget {
  const IntroPages({super.key});

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  bool cliked = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height / 2,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/image_1.png'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              top: height / 2,
              child: Container(
                height: height / 2,
                width: width,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Coffe so good,your taste budswill love it.',
                      style: TextStyle(
                          fontFamily: 'Sora',
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'The best grain, the finest roast, the powerful flavor',
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'Sora', color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(_createRoute());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: width,
                          height: 70,
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const DashboardPages(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Animasi slide dari kanan
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 600));
}
