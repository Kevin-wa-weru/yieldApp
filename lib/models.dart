import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Farms {
  String farmName;
  List<String> fieldNames;

  Farms({
    required this.farmName,
    required this.fieldNames,
  });
}

List<Farms> allFarms = [
  Farms(farmName: 'Farm A', fieldNames: [
    'Trial Feild1 - Tomato',
    'Trial Feild2 - Vegetables',
  ]),
  Farms(
      farmName: 'Farm B',
      fieldNames: ['Trial Feild4 - Onion', 'Trial Feild5 - Rice']),
];

class Field {
  String fieldName;
  String status;
  String hacters;
  LatLng locationCoords;
  Color color;
  Polygon polygon;
  List<Map> sections;

  Field({
    required this.fieldName,
    required this.status,
    required this.hacters,
    required this.color,
    required this.locationCoords,
    required this.polygon,
    required this.sections,
  });
}

final List<Field> allFields = [
  Field(
      fieldName: 'Trial Feild1 - Tomato',
      status: 'All good',
      hacters: '7 hacters',
      locationCoords: const LatLng(-1.2650938545992512, 36.81187471264449),
      color: Colors.green,
      polygon: const Polygon(
          strokeWidth: 5,
          strokeColor: Colors.green,
          fillColor: Colors.transparent,
          polygonId: PolygonId('polygonOne'),
          points: [
            LatLng(-1.2650938545992512, 36.81187471264449),
            LatLng(-1.2655827368927743, 36.81455409809251),
            LatLng(-1.2655827368927743, 36.81455409809251),
            LatLng(-1.2692117882596214, 36.81247077140683),
          ]),
      sections: [
        {
          'sectionName': 'Section A',
          'crop': 'tomatoe',
        },
        {
          'sectionName': 'Section B',
          'crop': 'cherry',
        },
        {
          'sectionName': 'Section C',
          'crop': 'Onion',
        },
        {
          'sectionName': 'Section D',
          'crop': 'Corn',
        },
      ]),
  Field(
      fieldName: 'Trial Feild2 - Vegetables',
      status: 'All good',
      hacters: '72 hacters',
      locationCoords: const LatLng(-1.2568264192149101, 36.802059071795156),
      color: Colors.redAccent,
      polygon: const Polygon(
          strokeWidth: 5,
          strokeColor: Colors.red,
          fillColor: Colors.transparent,
          polygonId: PolygonId('polygonOne'),
          points: [
            LatLng(-1.2568264192149101, 36.802059071795156),
            LatLng(-1.2588238850138054, 36.8050837418938),
            LatLng(-1.2613762001963695, 36.803335538075316),
            LatLng(-1.259129053265069, 36.801892576193396),
          ]),
      sections: [
        {
          'sectionName': 'Section A',
          'crop': 'tomatoe',
        },
        {
          'sectionName': 'Section B',
          'crop': 'cherry',
        },
        {
          'sectionName': 'Section C',
          'crop': 'Onion',
        },
        {
          'sectionName': 'Section D',
          'crop': 'Corn',
        },
      ]),
  Field(
      fieldName: 'Trial Feild3 - Corn',
      status: 'All good',
      hacters: '12 hacters',
      locationCoords: const LatLng(-1.2495350877087108, 36.80647270890487),
      color: Colors.black,
      polygon: const Polygon(
          strokeWidth: 5,
          strokeColor: Colors.black,
          fillColor: Colors.transparent,
          polygonId: PolygonId('polygonOne'),
          points: [
            LatLng(-1.2495350877087108, 36.80647270890487),
            LatLng(-1.2501357307572316, 36.81096891365646),
            LatLng(-1.2533644556695631, 36.8105012224634),
            LatLng(-1.2527707708570919, 36.804804883711654),
          ]),
      sections: [
        {
          'sectionName': 'Section A',
          'crop': 'tomatoe',
        },
        {
          'sectionName': 'Section B',
          'crop': 'cherry',
        },
        {
          'sectionName': 'Section C',
          'crop': 'Onion',
        },
        {
          'sectionName': 'Section D',
          'crop': 'Corn',
        },
      ]),
  Field(
      fieldName: 'Trial Feild4 - Onion',
      status: 'All good',
      hacters: '10 hacters',
      locationCoords: const LatLng(-1.2590773795241652, 36.835359275595565),
      color: Colors.blue,
      polygon: const Polygon(
          strokeWidth: 5,
          strokeColor: Colors.blue,
          fillColor: Colors.transparent,
          polygonId: PolygonId('polygonOne'),
          points: [
            LatLng(-1.2590773795241652, 36.835359275595565),
            LatLng(-1.250584036558509, 36.84670437203445),
            LatLng(-1.2623564475792075, 36.853264096041784),
            LatLng(-1.2660655523614586, 36.84320943711252),
          ]),
      sections: [
        {
          'sectionName': 'Section A',
          'crop': 'tomatoe',
        },
        {
          'sectionName': 'Section B',
          'crop': 'cherry',
        },
        {
          'sectionName': 'Section C',
          'crop': 'Onion',
        },
        {
          'sectionName': 'Section D',
          'crop': 'Corn',
        },
      ]),
  Field(
      fieldName: 'Trial Feild5 - Rice',
      status: 'All good',
      hacters: '2 hacters',
      locationCoords: const LatLng(-1.2045661664689244, 36.78970471645678),
      color: Colors.yellow,
      polygon: const Polygon(
          strokeWidth: 5,
          strokeColor: Colors.yellow,
          fillColor: Colors.transparent,
          polygonId: PolygonId('polygonOne'),
          points: [
            LatLng(-1.1878678889239311, 36.78985256112785),
            LatLng(-1.2093621201250822, 36.7790485275756),
            LatLng(-1.2247988133509875, 36.79506937482829),
            LatLng(-1.2089686923386311, 36.82825679326641),
            LatLng(-1.1878678889239311, 36.78985256112785),
          ]),
      sections: [
        {
          'sectionName': 'Section A',
          'crop': 'tomatoe',
        },
        {
          'sectionName': 'Section B',
          'crop': 'cherry',
        },
        {
          'sectionName': 'Section C',
          'crop': 'Onion',
        },
        {
          'sectionName': 'Section D',
          'crop': 'Corn',
        },
      ])
];

class ExpandableWidget {
  final String title;
  final String alertCount;
  final String svgUrl;
  final Widget expandedContent;
  bool? isExpanded;
  ExpandableWidget(
      {required this.title,
      required this.alertCount,
      required this.isExpanded,
      required this.svgUrl,
      required this.expandedContent});
}

class TreatMents {
  final String date;
  final String treatMentName;
  final String dosageAmount;

  bool? isApplied;

  TreatMents({
    required this.date,
    required this.treatMentName,
    required this.dosageAmount,
    required this.isApplied,
  });
}

class Alerts {
  final String date;
  final String alertDescription;

  Alerts({
    required this.date,
    required this.alertDescription,
  });
}

class Scoutings {
  final String date;
  final String scoutingName;
  final String section;

  Scoutings({
    required this.date,
    required this.scoutingName,
    required this.section,
  });
}
