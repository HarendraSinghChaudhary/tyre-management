import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:ui' as ui;

import '../../controllers/auth/auth_controller.dart';

class SignatureWidget extends StatefulWidget {
  ScreenshotController  capture;

  SignatureWidget({Key? key, required this.capture,})
      : super(key: key);

  @override
  _SignatureWidgetState createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  Rx<DrawnLine> line = DrawnLine([Offset.zero], Colors.black, 1).obs;
  AuthController controller = Get.find();
  GlobalKey _globalKey = new GlobalKey();
  
  ui.Image? image;
  @override
  void initState() {
  
    // TODO: implement initState
    super.initState();
  }

  void onPanStart(DragStartDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = details.localPosition;
    line(DrawnLine([point], Colors.black, 1));
  }

  void onPanUpdate(DragUpdateDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = details.localPosition;
    print("pan update");
    List<Offset> path = List.from(line.value.path)..add(point);

    line(DrawnLine(path, Colors.black, 1));

    // currentLineStreamController.add(line);
  }

  void onPanEnd(DragEndDetails details) {
    //linesStreamController.add(lines);
  }

 

 

  GestureDetector buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          color: Colors.transparent,
          width: ScreenSize.width * 0.7,
          height: ScreenSize.width * 0.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(ScreenSize.height * 0.01),
      width: ScreenSize.width * 0.8,
      height: ScreenSize.width * 0.60,
      decoration: BoxDecoration(
          color: lightGrey,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1.2,
                offset: Offset(0, 3),
                color: Colors.black.withOpacity(0.3))
          ],
          borderRadius: BorderRadius.circular(ScreenSize.width * 0.01)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenSize.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Signature",
                    style: getStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenSize.height * 0.022,
                    )),
                InkWell(
                    onTap: () {
                      line(DrawnLine([Offset.zero], Colors.black, 1));
                    },
                    child: Icon(Icons.undo))
              ],
            ),
          ),
          RepaintBoundary(
            child: Screenshot(
              controller: widget.capture ,
              child: Container(
                width: ScreenSize.width * 0.7,
                height: ScreenSize.width * 0.40,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        ClipRect(
                          child: Container(
                            width: ScreenSize.width * 0.7,
                            height: ScreenSize.width * 0.32,
                            child: Obx(
                              () => RepaintBoundary(
                                key: _globalKey,
                                child: CustomPaint(painter: SignaturePainter(lines: line.value)),
                              ),
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        ),
                        buildCurrentPath(context)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenSize.width * 0.03),
                                child: Text(
                                  "Signed by : ${AuthController.userInfo.data?.firstName?.toUpperCase() ?? ""}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10),
                                ))
                          ],
                        )),
                        Icon(
                          Icons.point_of_sale,
                          size: ScreenSize.height * 0.02,
                        ),
                        SizedBox(
                          width: ScreenSize.width * 0.03,
                        ),
                        Icon(
                          Icons.upload,
                          size: ScreenSize.height * 0.030,
                        ),
                        SizedBox(
                          width: ScreenSize.width * 0.04,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawnLine {
  final List<Offset> path;
  final Color color;
  final double width;

  DrawnLine(this.path, this.color, this.width);
}

class SignaturePainter extends CustomPainter {
  late DrawnLine lines;
  SignaturePainter({required this.lines, image}) {}
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    for (int j = 0; j < lines.path.length - 1; ++j) {
      if (lines.path[j] != null && lines.path[j + 1] != null) {
        paint.color = lines.color;
        paint.strokeWidth = lines.width;
        canvas.drawLine(lines.path[j], lines.path[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
