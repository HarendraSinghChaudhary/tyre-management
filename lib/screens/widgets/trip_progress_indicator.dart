import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/trip/trip_controller.dart';
import 'CustomeProgressIndicator.dart';

class TripProgressIndicator extends StatefulWidget {
  const TripProgressIndicator({Key? key}) : super(key: key);

  @override
  State<TripProgressIndicator> createState() => _TripProgressIndicatorState();
}

class _TripProgressIndicatorState extends State<TripProgressIndicator> {
  TripController tripController = Get.find();
 List<TripProgress> destinations=List.empty();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<TripProgress> load() {
    destinations =
        tripController.tripData?.data?.intermediary?.map<TripProgress>((e) {
              switch (e.serviceName) {
                case "Refuel":
                  return TripProgress(
                      name: e.town?.name??"Refuel",
                      active: false,
                      progressType: ProgressType.REFUEL);
                case "End Trip":
                  return TripProgress(
                      name: e.town?.name??"End trip",
                      active: false,
                      progressType: ProgressType.END_TRIP);

                case "Loading":
                  return TripProgress(
                     name: e.town?.name??"Loading",
                      active: false,
                      progressType: ProgressType.LOADING);

                case "Customer":
                  return TripProgress(
                     name: e.town?.name??"Customer",
                      active: false,
                      progressType: ProgressType.LOADING);

                case "Trip Start":
                  return TripProgress(
                     name: e.town?.name??"Start",
                      active: false,
                      progressType: ProgressType.START_TRIP);
              }
              return TripProgress(
                  name: "Start",
                  active: false,
                  progressType: ProgressType.START_TRIP);
            }).toList() ??
            List<TripProgress>.empty();
             tripController.tripData?.data?.isActive??false?destinations.insert(0,
               TripProgress(
                  name: "${ tripController.tripData?.data?.town?.name}",
                  active: destinations.length==0?true:false,
                  progressType: ProgressType.START_TRIP)
             ):null;
    return destinations;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripController>(
      builder: (controller) => GestureDetector(
          onTap: () {
            print("${tripController.tripData?.toJson()}");
          },
          child: CustomeProgressIndicator(
            currentstep: 1.obs,
            tripProgress: load(),
          )),
    );
    return GetBuilder<TripController>(
      builder: (controller) => GestureDetector(
          onTap: () {
            print("${tripController.tripData?.toJson()}");
          },
          child: Text("${load().length}")),
    );
    return Container(
        child: CustomeProgressIndicator(
      currentstep: RxInt(0),
      tripProgress: load(),
    ));
    // return Container(
    //   child: Obx(
    //     () => tripController.tripData?.data?.intermediary?.map<Widget>((e) => Text(e.serviceName))??Text("null").t,
    //   ),
    // );
  }
}
