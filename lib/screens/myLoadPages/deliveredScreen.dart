import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/functions/bookingApiCalls.dart';
import 'package:liveasy/functions/loadOnGoingDeliveredData.dart';
import 'package:liveasy/widgets/deliveredCard.dart';
import 'package:liveasy/widgets/loadingWidget.dart';

class DeliveredScreen extends StatelessWidget {
  final BookingApiCalls bookingApiCalls = BookingApiCalls();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.67,
        child: FutureBuilder(
          //getTruckData returns list of truck Model
          future: bookingApiCalls.getDataByPostLoadIdDelivered(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return LoadingWidget();
            }
            print('delivered snapshot length :' +
                '${snapshot.data.length}'); //number of cards

            if (snapshot.data.length == 0) {
              return Container(
                margin: EdgeInsets.only(top: 153),
                child: Column(
                  children: [
                    Image(
                      image:
                          AssetImage('assets/images/TruckListEmptyImage.png'),
                      height: 127,
                      width: 127,
                    ),
                    Text(
                       'Looks like you have not added any Loads!',
                      style: TextStyle(fontSize: size_8, color: grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: loadAllData(snapshot.data[index]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return SizedBox();
                          }
                          return DeliveredCard(
                            loadingPoint: snapshot.data['loadingPoint'],
                            unloadingPoint: snapshot.data['unloadingPoint'],
                            companyName: snapshot.data['companyName'],
                            truckNo: snapshot.data['truckNo'],
                            driverName: snapshot.data['driverName'],
                            startedOn: snapshot.data['startedOn'],
                            endedOn: snapshot.data['endedOn'],
                            // imei: snapshot.data['imei'],
                            // phoneNum: snapshot.data['phoneNum'],
                          );
                        });
                  } //builder

                  );
            } //else
          },
        ));
  }
} //class end
