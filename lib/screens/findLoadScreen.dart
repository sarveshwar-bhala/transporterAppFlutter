import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy/constants/borderWidth.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:liveasy/functions/loadApis/runFindLoadApiGet.dart';
import 'package:liveasy/providerClass/providerData.dart';
import 'package:liveasy/widgets/availableLoadsTextWidget.dart';
import 'package:liveasy/widgets/buttons/filterButton.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/loadDisplayCard.dart';
import 'package:liveasy/widgets/loadingPointImageIcon.dart';
import 'package:liveasy/widgets/loadingWidget.dart';
import 'package:liveasy/widgets/noCardDisplay.dart';
import 'package:liveasy/widgets/unloadingPointImageIcon.dart';
import 'package:provider/provider.dart';
import 'package:liveasy/widgets/addressInputWidget.dart';

class FindLoadScreen extends StatefulWidget {
  @override
  _FindLoadScreenState createState() => _FindLoadScreenState();
}

class _FindLoadScreenState extends State<FindLoadScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  var findLoadApiData;
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData =
        Provider.of<ProviderData>(context, listen: false);
    //
    // if (Provider.of<ProviderData>(context).loadingPointCity != "") {
    //   print(transporterIdController.transporterId);
    //   controller1 = TextEditingController(
    //       text:
    //           ("${providerData.loadingPointCity} (${providerData.loadingPointState})"));
    //   findLoadApiData = runFindLoadApiGet(
    //       providerData.loadingPointCity, providerData.unloadingPointCity);
    // }
    findLoadApiData = runFindLoadApiGet("delhi", "");

    if (Provider.of<ProviderData>(context).unloadingPointCity != "") {
      controller2 = TextEditingController(
          text:
              ("${providerData.unloadingPointCity} (${providerData.unloadingPointState})"));
      findLoadApiData = runFindLoadApiGet(
          providerData.loadingPointCity, providerData.unloadingPointCity);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            providerData.clearLoadingPoint();
                            providerData.clearUnloadingPoint();
                          },
                          child: Icon(Icons.arrow_back_ios_rounded),
                        ),
                        SizedBox(
                          width: space_3,
                        ),
                        HeadingTextWidget("Find Load"),
                        // HelpButtonWidget(),
                      ],
                    ),
                    FilterButtonWidget(),
                  ],
                ),
                SizedBox(
                  height: space_5,
                ),
                AddressInputWidget(
                    hintText: "Loading Point",
                    icon: LoadingPointImageIcon(
                      height: space_2 + 2,
                      width: space_2 + 2,
                    ),
                    controller: controller1,
                    onTap: () {
                      providerData.clearLoadingPoint();
                    }),
                SizedBox(
                  height: space_4,
                ),
                AddressInputWidget(
                  hintText: "Unloading Point",
                  icon: UnloadingPointImageIcon(
                    height: space_2 + 2,
                    width: space_2 + 2,
                  ),
                  controller: controller2,
                  onTap: () {
                    providerData.clearUnloadingPoint();
                  },
                ),
                SizedBox(
                  height: space_3,
                ),
                Container(
                  color: lightGrayishBlue,
                  height: borderWidth_12,
                ),
                SizedBox(
                  height: space_4,
                ),
                findLoadApiData == null
                    ? Container()
                    : FutureBuilder(
                        future: findLoadApiData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.2),
                                child: LoadingWidget());
                          } else if (snapshot.data.length == 0) {
                            return NoCardDisplay();
                          }
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AvailableLoadsTextWidget(),
                                  FilterButtonWidget()
                                ],
                              ),
                              SizedBox(
                                height: space_4,
                              ),
                              Container(
                                height: 450,
                                //TODO to be modified
                                //alternative-(MediaQuery.of(context).size.height-(previous height))
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(),
                                  itemCount: (snapshot.data.length),
                                  itemBuilder: (BuildContext context, index) =>
                                      LoadApiDataDisplayCard(
                                    loadApiData: snapshot.data[index],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
