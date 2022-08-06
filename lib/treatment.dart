import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yieldapp/models.dart';

class TreatmentExpandavle extends StatefulWidget {
  const TreatmentExpandavle({Key? key}) : super(key: key);

  @override
  State<TreatmentExpandavle> createState() => _TreatmentExpandavleState();
}

class _TreatmentExpandavleState extends State<TreatmentExpandavle> {
  List<TreatMents> allTreatment = [
    TreatMents(
      date: '12/04/2022',
      treatMentName: 'Lunar Tranquility',
      dosageAmount: '400g/ha',
      isApplied: false,
    ),
    TreatMents(
      date: '22/04/2022',
      treatMentName: 'Baz ',
      dosageAmount: '1.5L/ha',
      isApplied: false,
    ),
    TreatMents(
      date: '20/04//2022',
      treatMentName: 'Apllo 50',
      dosageAmount: '250g/ha',
      isApplied: false,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text('Applied',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Column(
            children: allTreatment
                .map((treatment) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset('assets/edit.svg',
                                    color: Colors.green,
                                    height: 10,
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
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
                            const SizedBox(
                              width: 2,
                            ),
                            SizedBox(
                              width: 100,
                              // color: Colors.blue,
                              child: Text(treatment.treatMentName,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  )),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(treatment.dosageAmount,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                )),
                            const SizedBox(
                              width: 2,
                            ),
                            Transform.scale(
                              scale: 0.6,
                              child: CupertinoSwitch(
                                activeColor: Colors.green,
                                trackColor: Colors.grey,
                                value: treatment.isApplied!,
                                onChanged: (value) {
                                  setState(() {
                                    treatment.isApplied = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    ))
                .toList())
      ],
    ));
  }
}
