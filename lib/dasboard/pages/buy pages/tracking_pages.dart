import 'package:flutter/material.dart';

class TrackingPages extends StatefulWidget {
  const TrackingPages({super.key});

  @override
  State<TrackingPages> createState() => _TrackingPagesState();
}

class _TrackingPagesState extends State<TrackingPages> {
  @override
  Widget build(BuildContext context) {
    // ukuran layar
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
      ),
      body: Container(height: height, width: width, color: Colors.amber),
    );
  }
}
