import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:irregation/controller/NotificationController.dart';
import 'package:irregation/main.dart';
import 'package:irregation/notification/NotificationApi.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timezone/timezone.dart' as tz;

class InfoPage extends StatelessWidget {
  InfoPage({super.key, this.plant, required this.data});
  List<dynamic> data;
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
            child: SingleChildScrollView(
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      GetBuilder<NotificationController>(
                        init: NotificationController(),
                        builder: (controller) => Container(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, top: 20, bottom: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const Text(
                                        "Reminder Every day",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  child: hourMinute12HCustomStyle(),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(200, 50)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(255, 8, 63, 10)),
                                    ),
                                    onPressed: () {
                                      print(data.isNotEmpty
                                          ? data[0].toString()
                                          : "none");
                                      NotificationApi
                                          .showDailyScheduledNotification(
                                        scheduledDate: controller.time!,
                                        title: plant["plantName"],
                                        payload: data.isNotEmpty
                                            ? data[0].toString()
                                            : "none",
                                        body: plant["plantDisc"],
                                        image: plant["plantImageUrl"]
                                            .split(",")[0],
                                        icon: plant["plantImageUrl"]
                                            .split(",")[0],
                                      );
                                      Get.back();
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin:
                        const EdgeInsets.only(top: 50, bottom: 10, right: 40),
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Color.fromARGB(255, 108, 154, 62),
                    ),
                  ),
                ),
                Container(
                  width: Get.width - 80,
                  height: 250,
                  margin: const EdgeInsets.only(bottom: 20),
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
                  margin: EdgeInsets.only(bottom: 20),
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
                data.length > 0
                    ? Container(
                        margin: EdgeInsets.only(
                            left: 40, right: 40, bottom: 30, top: 20),
                        child: SfCartesianChart(
                            legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom),
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries<int, double>>[
                              StackedColumnSeries<int, double>(
                                dataSource: [1, 2, 3, 4],
                                xValueMapper: (int s, _) => s.toDouble(),
                                yValueMapper: (int s, _) =>
                                    double.parse(data[s - 1]),
                                name: "water Evaporated",
                              ),
                            ]),
                      )
                    : Container(),
              ]),
            ),
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

  Widget hourMinute12HCustomStyle() {
    return GetBuilder<NotificationController>(
      builder: (controller) => TimePickerSpinner(
        is24HourMode: false,
        normalTextStyle: TextStyle(fontSize: 20, color: Colors.grey),
        highlightedTextStyle:
            TextStyle(fontSize: 20, color: Color.fromARGB(255, 108, 154, 62)),
        spacing: 40,
        itemHeight: 40,
        isForce2Digits: true,
        minutesInterval: 1,
        onTimeChange: (time) {
          controller.time = Time(time.hour, time.minute);
        },
      ),
    );
  }
}
