import 'package:flutter/material.dart';
import 'package:yieldapp/models.dart';

class ScoutingExpandavle extends StatefulWidget {
  const ScoutingExpandavle({Key? key}) : super(key: key);

  @override
  State<ScoutingExpandavle> createState() => _ScoutingExpandavleState();
}

class _ScoutingExpandavleState extends State<ScoutingExpandavle> {
  List<Scoutings> allScoutings = [
    Scoutings(
        date: 'Aug 2, 2022', scoutingName: 'Whitefly', section: 'Section A'),
    Scoutings(
        date: 'Sept 5, 2022', scoutingName: 'Thrips', section: 'Section B'),
    Scoutings(
        date: 'OCt 10, 2022', scoutingName: 'Whitefly', section: 'Section A'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        Column(
            children: allScoutings
                .map((scoutings) => Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 120,
                              // color: Colors.yellow,
                              child: Text(
                                scoutings.date,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: 120,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  scoutings.scoutingName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              // width: 100,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  scoutings.section,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider()
                      ],
                    ))
                .toList())
      ],
    ));
  }
}
