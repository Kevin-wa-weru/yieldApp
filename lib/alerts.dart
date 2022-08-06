import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yieldapp/models.dart';

class AlertExpandavle extends StatefulWidget {
  const AlertExpandavle({Key? key}) : super(key: key);

  @override
  State<AlertExpandavle> createState() => _AlertExpandavleState();
}

class _AlertExpandavleState extends State<AlertExpandavle> {
  List<Alerts> allAlerts = [
    Alerts(
        date: 'Aug 2, 2022',
        alertDescription: 'Coffee berry borer risk is high'),
    Alerts(
        date: 'Dec 10, 2022',
        alertDescription:
            'High John, This is Tim, make sure to moniter for white fly'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        Column(
            children: allAlerts
                .map((treatment) => Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: 80,
                              child: Text(
                                treatment.date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.blue,
                              width: 160,
                              child: Text(
                                treatment.alertDescription,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  allAlerts.remove(Alerts(
                                      date: treatment.date,
                                      alertDescription:
                                          treatment.alertDescription));
                                });
                              },
                              child: Expanded(
                                child: SizedBox(
                                  // color: Colors.red,
                                  width: 50,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: SvgPicture.asset(
                                          'assets/cancel.svg',
                                          color: Colors.black54,
                                          height: 10,
                                          fit: BoxFit.fitHeight),
                                    ),
                                  ),
                                ),
                              ),
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
