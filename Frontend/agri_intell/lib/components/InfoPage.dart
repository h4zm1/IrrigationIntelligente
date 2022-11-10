import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, this.plant});

  final plant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 108, 154, 62),
            ),
          ),
          Container(
            height: Get.size.height - 150,
            width: Get.size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(160.0)),
            ),
            child: Column(children: [
              Container(
                width: Get.width - 80,
                height: 250,
                margin: const EdgeInsets.only(top: 60, bottom: 20),
                child: CarouselSlider.builder(
                  options: CarouselOptions(),
                  itemCount: plant["plantImageUrl"].split(",").length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40)),
                      child: Image.network(
                        plant["plantImageUrl"].split(",")[itemIndex],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    Text(plant["plantName"],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    const SizedBox(height: 20),
                    Text(
                      plant["plantDisc"],
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height - 125, left: 50, right: 50),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.st,
                  children: [
                    Icon(
                      Icons.straighten,
                      color: Colors.white,
                      size: 45,
                    ),
                    Text("Height",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    Text('25cm-30cm',
                        style: TextStyle(fontSize: 15, color: Colors.white))
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.thermostat,
                      color: Colors.white,
                      size: 45,
                    ),
                    Text("Temperature",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    Text('22°C-30°C',
                        style: TextStyle(fontSize: 15, color: Colors.white))
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                      size: 45,
                    ),
                    const Text("Humidity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                    Text(plant['plantWaterUsage'].toString(),
                        style: TextStyle(fontSize: 15, color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
