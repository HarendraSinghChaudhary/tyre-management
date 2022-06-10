import 'package:PrimeMetrics/screens/driver/confirm_trip.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';

typedef TimeCaptured = void Function(DateTime dateTime);

class DatePicker extends StatefulWidget {
  String title;
  bool disabled;
  TimeCaptured? timeCaptured;
    String? bodyText;
  String? buttonText;
  DatePicker(
      {Key? key,
      this.timeCaptured,
      this.title = "Date of Arrival",
      required this.bodyText,
      required this.buttonText,
      this.disabled = false})
      : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  RxBool manual = false.obs;
  late Rx<DateTime> date = DateTime.now().obs;
  late Rx<TimeOfDay> timeOfDay;
  TextEditingController dateController = TextEditingController();

  TextEditingController hourController = TextEditingController();
  TextEditingController minController = TextEditingController();

  TextEditingController meridian = TextEditingController();
  RxBool timePicked = false.obs;
  @override
  void initState() {
    timeOfDay = TimeOfDay(hour: date.value.hour, minute: date.value.minute).obs;
    timeOfDay.listen((p0) {
      hourController.text = p0.hour.toString().padLeft(2, '0');
      minController.text = p0.minute.toString().padLeft(2, '0');
      meridian.text = p0.period.toString().split(".")[1].toUpperCase();
      if (this.widget.timeCaptured != null) {
        // this.widget.timeCaptured!(date);
      }
      print("add ${timeOfDay} ");
      
    date(date.value.add(Duration(
          hours: timeOfDay.value.hour, minutes: timeOfDay.value.minute)));
      print("date changed on time ${date.toString()}");
    });
    date.listen((p0) {
      date.value.add(Duration(
          hours: timeOfDay.value.hour, minutes: timeOfDay.value.minute));
      print("date changed ${date.toString()}");
    });

    //   int y = int.tryParse(yearController.text) ?? 1970;
    //   int m = int.tryParse(monthController.text) ?? 01;
    //   int d = int.tryParse(dayController.text) ?? 01;
    //   int h = int.tryParse(hourController.text) ?? 01;
    //   int M = int.tryParse(minController.text) ?? 01;

    //  DateTime picker= DateTime(y, m, d, h, M);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.widget.title),
            ObxValue(
                (RxBool manual) => InkWell(
                      onTap: () {
                        if (!this.widget.disabled) {
                          manual(!manual.value);
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            manual.isFalse ? "Add Manually" : "Cancel",
                            style: getStyle(
                                color: !this.widget.disabled
                                    ? Colors.green
                                    : Colors.green.withOpacity(0.6),
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: ScreenSize.width * 0.01,
                          ),
                          (this.widget.disabled && this.manual.isFalse)
                              ? Icon(
                                  Icons.lock,
                                  size: ScreenSize.width * 0.02,
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                manual),
          ],
        ),
        ObxValue((RxBool manual) {
          FocusNode().requestFocus();
          if (manual.isFalse) {
            return InkWell(
              onTap: () {
                Get.to(ConfirmTrip(
                  bodyText: this.widget.bodyText,
                  buttonText: this.widget.buttonText ,
                  onCaptureTime: (dateTime) {
                    date(dateTime);
                    timePicked(true);
                    Get.back();
                    print("time ${dateTime.toString()}");
                  },
                  onCancelCaptureTime: () {
                    timePicked(false);
                    Get.back();
                    print("Canceled");
                  },
                ));
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: ScreenSize.height * 0.01),
                child: Obx(
                  () => Text(
                      !timePicked.value
                          ? "Capture Automatically"
                          : DateFormat.yMMMMEEEEd()
                              .add_jm()
                              .format(DateTime.now()),
                      style: getStyle(
                        color: Colors.green,
                        fontSize: ScreenSize.width * 0.03,
                      )),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenSize.width * 0.1)),
                width: ScreenSize.width,
                height: ScreenSize.height * 0.07,
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(vertical: ScreenSize.width * 0.01),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return CalendarDatePicker(
                                onDateChanged: (value) {
                                  date(value);
                                  dateController.text = value.toString();
                                  Get.back();
                                },
                                initialDate: date.value,
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 30)));
                          });
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenSize.width * 0.23,
                                  height: ScreenSize.height * 0.07,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.04),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 1.2,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenSize.height * 0.01),
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("${date.value.day}"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenSize.width * 0.23,
                                  height: ScreenSize.height * 0.07,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.04),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 1.2,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenSize.height * 0.01),
                                      ),
                                      color: Colors.white),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text("${date.value.month}"),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenSize.width * 0.23,
                                  height: ScreenSize.height * 0.07,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.04),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 1.2,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenSize.height * 0.01),
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("${date.value.year}"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenSize.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var time = await showTimePicker(
                                    context: context,
                                    initialTime: timeOfDay.value) ??
                                TimeOfDay.fromDateTime(DateTime.now());
                            timeOfDay(time);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenSize.width * 0.23,
                                  height: ScreenSize.height * 0.07,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.04),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 1.2,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenSize.height * 0.01),
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: hourController,
                                          keyboardType: TextInputType.name,
                                          enabled: false,
                                          decoration: InputDecoration(
                                              hintText: "00:00",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              border: InputBorder.none),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var time = await showTimePicker(
                                    context: context,
                                    initialTime: timeOfDay.value) ??
                                TimeOfDay.fromDateTime(DateTime.now());
                            timeOfDay(time);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenSize.width * 0.23,
                                  height: ScreenSize.height * 0.07,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.04),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 1.2,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenSize.height * 0.01),
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.none,
                                          controller: minController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                              hintText: "00:00",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              border: InputBorder.none),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var time = await showTimePicker(
                                    context: context,
                                    initialTime: timeOfDay.value) ??
                                TimeOfDay.fromDateTime(DateTime.now());
                            timeOfDay(time);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenSize.width * 0.23,
                                  height: ScreenSize.height * 0.07,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.04),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 1.2,
                                            offset: const Offset(0, 3),
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenSize.height * 0.01),
                                      ),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            print(value);
                                          },
                                          enabled: false,
                                          keyboardType: TextInputType.name,
                                          controller: meridian,
                                          decoration: InputDecoration(
                                              hintText: "AM/PM",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              border: InputBorder.none),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }, manual),
      ]),
    );
  }
}
