import 'dart:io';
import 'package:festival_post_maker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCheck = false;
  List<Color> bgColor = [
    const Color(0xffffc8dd),
    const Color(0xffa2d2ff),
    const Color(0xff81b29a),
    const Color(0xffa8dadc),
    const Color(0xffcdb4db),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (val, res) async {
        if (val) {
          return;
        }
        bool canPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Alert Dialog !!"),
            content: const Text("Are you sure you want to EXIT?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("YES"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("NO"),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        if (canPop && context.mounted) {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Festivals",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isCheck = !isCheck;
                });
              },
              icon: isCheck
                  ? const Icon(Icons.grid_view_rounded)
                  : const Icon(Icons.list_rounded),
            ),
          ],
          backgroundColor: const Color(0xFFF6E7D8).withOpacity(0.6),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "lib/assets/images/bg1.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isCheck
                ? CardSwiper(
                    cardsCount: allFestival.length,
                    cardBuilder: (BuildContext context,
                        int index,
                        int horizontalOffsetPercentage,
                        int verticalOffsetPercentage) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailpage,
                            arguments: allFestival[index],
                          );
                        },
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: 500,
                            width: 300,
                            decoration: BoxDecoration(
                              color: bgColor[index % bgColor.length],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 400,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            allFestival[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    allFestival[index].name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    itemCount: allFestival.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailpage,
                            arguments: allFestival[index],
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor[index % bgColor.length],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(allFestival[index].image),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  allFestival[index].name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
