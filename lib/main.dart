import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yieldapp/login.dart';
import 'package:yieldapp/models.dart';
import 'package:yieldapp/single_field.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps Demo',
      home: SignIn(),
    );
  }
}

class MapAnimation extends StatefulWidget {
  const MapAnimation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MapAnimationState createState() => _MapAnimationState();
}

class _MapAnimationState extends State<MapAnimation> {
  late GoogleMapController _controller;
  List<Marker> allMarkers = [];
  late PageController _pageController;
  late int prevPage = 0;
  Set<Polygon> allPolygons = {};
  String? selectedFarm;
  String? selectedField;

  late List<String> allUserFarms = [];

  late List<String> allFieldNamesOfThatFarm = [];

  getFieldsForThatFarm() async {
    setState(() {
      allFieldNamesOfThatFarm = [];
      selectedField = null;
    });
    List<Farms> farm =
        allFarms.where((element) => element.farmName == selectedFarm).toList();
    List<String> fieldNames = farm[0].fieldNames;

    setState(() {
      allFieldNamesOfThatFarm = fieldNames;
    });
  }

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? userLocation;

  Future<void> getUserLocation() async {
    Location location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      userLocation = locationData;
    });
  }

  @override
  void initState() {
    super.initState();

    for (var farm in allFarms) {
      allUserFarms.add(farm.farmName);
    }

    for (var element in allFields) {
      allPolygons.add(element.polygon);
    }
    for (var element in allFields) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.fieldName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.fieldName, snippet: element.fieldName),
          position: element.locationCoords));
    }
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
    getUserLocation();
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 145.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  Center(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleField(
                                  fieldName: allFields[index].fieldName,
                                  polygon: allFields[index].polygon,
                                  position: allFields[index].locationCoords,
                                )),
                      );
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 165.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Row(children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: SvgPicture.asset('assets/polygon.svg',
                                color: allFields[index].color,
                                height: 10,
                                fit: BoxFit.fitHeight),
                          ),
                          const SizedBox(width: 5.0),
                          SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allFields[index].fieldName,
                                    style: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    allFields[index].status,
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 170.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        allFields[index].hacters,
                                        style: const TextStyle(
                                            fontSize: 11.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ]),
                          )
                        ])),
                  ))
                ]),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            color: Colors.black87,
            height: 50,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset('assets/leaf.svg',
                        color: Colors.green, height: 10, fit: BoxFit.fitHeight),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Yields App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Farm',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.2,
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border(
                      left: BorderSide(width: 2.0, color: Colors.black54),
                      right: BorderSide(width: 2.0, color: Colors.black54),
                      top: BorderSide(width: 2.0, color: Colors.black54),
                      bottom: BorderSide(width: 2.0, color: Colors.black54),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      dropdownElevation: 0,
                      focusColor: Colors.transparent,
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Select.',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: allUserFarms
                          .map((itemd) => DropdownMenuItem<String>(
                                value: itemd,
                                child: Text(
                                  itemd,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedFarm,
                      onChanged: (valued) {
                        setState(() {
                          selectedFarm = valued as String;
                        });

                        getFieldsForThatFarm();
                      },
                      icon: const Icon(
                        Icons.arrow_downward,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black54,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 40,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Fields',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.2,
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border(
                      left: BorderSide(width: 2.0, color: Colors.black54),
                      right: BorderSide(width: 2.0, color: Colors.black54),
                      top: BorderSide(width: 2.0, color: Colors.black54),
                      bottom: BorderSide(width: 2.0, color: Colors.black54),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      dropdownElevation: 0,
                      focusColor: Colors.transparent,
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: allFieldNamesOfThatFarm
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedField,
                      onChanged: (value) {
                        setState(() {
                          selectedField = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_downward,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black54,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 40,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  // height: height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    polygons: allPolygons,
                    mapType: MapType.hybrid,
                    initialCameraPosition: userLocation == null
                        ? const CameraPosition(
                            target:
                                LatLng(-1.2650938545992512, 36.81187471264449),
                            zoom: 15.0)
                        : CameraPosition(
                            target: LatLng(userLocation!.latitude!.toDouble(),
                                userLocation!.longitude!.toDouble()),
                            zoom: 20.0),
                    markers: Set.from(allMarkers),
                    onMapCreated: mapCreated,
                  ),
                ),
                Positioned(
                  bottom: 5.0,
                  child: SizedBox(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: allFields.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _coffeeShopList(index);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: allFields[_pageController.page!.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
