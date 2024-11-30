import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> images = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
    'assets/9.jpg',
    'assets/10.jpg',
  ];
  int? hoveredIndex;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                image ?? 'assets/4.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 800,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Container(
                          width: 800,
                          height: 500,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(10, (index) {
                                return MouseRegion(
                                  onEnter: (_) {
                                    setState(() {
                                      hoveredIndex = index;
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      hoveredIndex = null;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        image = images[index];
                                      });
                                    },
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.005)
                                        ..rotateX(
                                            (hoveredIndex == index ? 0 : 0.5))
                                        ..scale(
                                            (hoveredIndex == index ? 1 : 1.5))
                                        ..rotateY(
                                            (hoveredIndex == index ? 0 : -0.5)),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        padding: const EdgeInsets.all(5),
                                        curve: Curves.easeInOut,
                                        width: hoveredIndex == index ? 90 : 70,
                                        height:
                                            hoveredIndex == index ? 300 : 230,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: hoveredIndex == index
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    blurRadius: 10,
                                                  )
                                                ]
                                              : [],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            'assets/${index + 1}.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ))),
          ],
        ));
  }
}
