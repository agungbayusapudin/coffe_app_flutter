import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseweb/dasboard/dashboard_pages.dart';
import 'package:firebaseweb/intro/intro_pages.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  // inissilisasi untuk mengcontrol tiap tex yang di inputkan
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

  // firebase colection
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('coffe_aplication')
      .doc('data')
      .collection('users');

  // user credential
  ValueNotifier userCredential = ValueNotifier('');

  // selectecd button check
  bool _selected = false;

  // message for error
  String _errormessage = '';
  bool isLoading = true;
  bool isSuccess = true;
  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: userCredential,
            builder: (context, value, child) {
              return (userCredential.value == '')
                  ? Stack(
                      children: [
                        Container(
                          height: height,
                          width: width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: SizedBox(
                              height: height / 1.5,
                              child: Column(
                                children: [
                                  Container(
                                    height: height / 3,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/image_1.png'),
                                            fit: BoxFit.cover),
                                        borderRadius: (_selected == true)
                                            ? const BorderRadius.only(
                                                bottomLeft: Radius.circular(50))
                                            : const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(50))),
                                  ), // Lottie.asset('assets/animation/coffe3.json',
                                  //     height: height / 3),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: (_selected == true)
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(50))
                                            : const BorderRadius.only(
                                                topRight: Radius.circular(50))),
                                    height: height - height / 3,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 40),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _selected
                                                ? const Text(
                                                    'SIGN UP',
                                                    style: TextStyle(
                                                        fontFamily: 'Sora',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 35,
                                                        color: Colors.black),
                                                  )
                                                : const Text(
                                                    'LOGIN',
                                                    style: TextStyle(
                                                        fontFamily: 'Sora',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 35,
                                                        color: Colors.black),
                                                  ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selected = !_selected;
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              child: _selected
                                                  ? const Text('Login',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Sora'))
                                                  : const Text('Sign up',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Sora')),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 10,
                                        ),
                                        AnimatedContainer(
                                          duration: const Duration(seconds: 2),
                                          child: _selected
                                              ? Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          _namaController,
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  'Name'),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons
                                                                    .person_outline_outlined,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              )),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _emailController,
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  'Email'),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons.email,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              )),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _passwordController,
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  'Password'),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons.key,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              )),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      controller:
                                                          _emailController,
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  'Email'),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons.email,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              )),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextField(
                                                      obscureText:
                                                          (visiblePassword ==
                                                                  true)
                                                              ? true
                                                              : false,
                                                      controller:
                                                          _passwordController,
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  'Password'),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              suffix:
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          visiblePassword =
                                                                              !visiblePassword;
                                                                        });
                                                                      },
                                                                      icon: Icon((visiblePassword ==
                                                                              true)
                                                                          ? Icons
                                                                              .remove_red_eye_rounded
                                                                          : Icons
                                                                              .remove_red_eye_outlined)),
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons.key,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              )),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        SizedBox(
                                          height: height / 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_selected == true) {
                                              registerEmailAndPassword();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            } else {
                                              setState(() {
                                                signinEmailAndPassword();
                                                isLoading = false;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: _selected
                                              ? const Text(
                                                  'SIGN UP',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Sora'),
                                                )
                                              : const Text('LOGIN',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Sora')),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height / 4,
                          left: width / 4,
                          bottom: height / 2,
                          child: SizedBox(
                            height: height / 3,
                            width: width / 2,
                            child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: isLoading
                                    ? Container()
                                    : Lottie.asset(
                                        (isSuccess == true)
                                            ? 'assets/animation/verification_succes.json'
                                            : 'assets/animation/verification_failed.json',
                                        onLoaded: (p0) {
                                        Future.delayed(
                                            const Duration(milliseconds: 1700),
                                            () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                        });
                                      }, fit: BoxFit.contain)),
                          ),
                        )
                      ],
                    )
                  : Container();
            }));
  }

  Future<void> signinEmailAndPassword() async {
    try {
      // mengecek data apakah ada dalam firebase auth
      setState(() {
        isSuccess = true;
      });
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      setState(() {
        this.userCredential.value = userCredential;
        _errormessage;
      });

      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const IntroPages()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errormessage = e.message ?? 'An unknow error occured';
        isSuccess = false;
      });
    }
  }

  Future<void> registerEmailAndPassword() async {
    try {
      // memasukan email dan password ke dalam firebase auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      setState(() {
        this.userCredential.value = userCredential;
        _errormessage;
      });

      // menambahkan data user ke dalam firestore
      await FirebaseFirestore.instance
          .collection('coffe_aplication')
          .doc('data')
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'nama': _namaController.text,
        'uid': userCredential.user?.uid,
        'email': _emailController.text
      });

      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const IntroPages()));

      //  error feedback
    } on FirebaseAuthException catch (e) {
      Lottie.asset('assets/animation/verification_failed.json');
      _errormessage = e.message ?? 'An unknow error occured';
    }
  }
}

// animasi untuk pindah page agar lebih smooth
Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const IntroPages(),
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
