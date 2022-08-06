import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yieldapp/add_record.dart';
import 'package:yieldapp/alerts.dart';
import 'package:yieldapp/models.dart';
import 'package:yieldapp/scouting.dart';
import 'package:yieldapp/treatment.dart';

class SingleField extends StatefulWidget {
  const SingleField(
      {Key? key,
      required this.position,
      required this.fieldName,
      required this.polygon})
      : super(key: key);
  final LatLng position;
  final String fieldName;
  final Polygon polygon;

  @override
  // ignore: library_private_types_in_public_api
  _SingleFieldState createState() => _SingleFieldState();
}

class _SingleFieldState extends State<SingleField> {
  late GoogleMapController _controller;
  List<Marker> allMarkers = [];
  late PageController _pageController;
  late int prevPage = 0;
  late LatLng selectedLocation = const LatLng(0, 0);

  handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      selectedLocation = tappedPoint;
      allMarkers = [];
      allMarkers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
    });
  }

  List<ExpandableWidget> expansionItems = [
    ExpandableWidget(
        title: 'Treatments',
        alertCount: '6',
        expandedContent: const TreatmentExpandavle(),
        svgUrl: 'assets/kit.svg',
        isExpanded: false),
    ExpandableWidget(
        title: 'Alerts',
        alertCount: '4',
        expandedContent: const AlertExpandavle(),
        svgUrl: 'assets/alert2.svg',
        isExpanded: false),
    ExpandableWidget(
        title: 'Scouting history',
        alertCount: '',
        expandedContent: const ScoutingExpandavle(),
        svgUrl: 'assets/eye.svg',
        isExpanded: false),
  ];

  @override
  void initState() {
    super.initState();

    allMarkers.add(Marker(
      markerId: MarkerId(widget.fieldName),
      draggable: false,
      infoWindow:
          InfoWindow(title: widget.fieldName, snippet: widget.fieldName),
      position: widget.position,
    ));
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
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
          Expanded(
            child: SizedBox(
              // height: height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                polygons: {
                  widget.polygon,
                },
                mapType: MapType.hybrid,
                initialCameraPosition:
                    CameraPosition(target: widget.position, zoom: 16.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                onTap: handleTap,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                color: Colors.white,
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    // color: Colors.blue,
                    // margin: const EdgeInsets.symmetric(
                    //   vertical: 20.0,
                    //   horizontal: 8,
                    // ),
                    padding: const EdgeInsets.only(left: 5.0),
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: ExpansionPanelList(
                        elevation: 3,
                        expansionCallback: (index, isExpanded) {
                          setState(() {
                            expansionItems[index].isExpanded = !isExpanded;
                          });
                        },
                        animationDuration: const Duration(milliseconds: 600),
                        children: expansionItems
                            .map(
                              (item) => ExpansionPanel(
                                canTapOnHeader: true,
                                backgroundColor: item.isExpanded == true
                                    ? Colors.white
                                    : Colors.white,
                                headerBuilder: (_, isExpanded) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(item.svgUrl,
                                              color: Colors.green,
                                              height: 10,
                                              fit: BoxFit.fitHeight),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          item.title,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        item.alertCount == ''
                                            ? Container()
                                            : Text(
                                                ' (${item.alertCount})',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                      ],
                                    )),
                                body: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: item.expandedContent,
                                ),
                                isExpanded: item.isExpanded!,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ))),
          ),
          InkWell(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddRecord(
                              fieldName: widget.fieldName,
                            )),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 40,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Add Scouting Record',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
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
