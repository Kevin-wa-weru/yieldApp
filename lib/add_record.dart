import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:yieldapp/add_images.dart';
import 'package:yieldapp/models.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key, required this.fieldName}) : super(key: key);
  final String fieldName;
  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  int maxLines = 5;
  final commentController = TextEditingController();
  final percentageController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  String? selectedSection;
  String? selectedIssue;
  String? selectedFindings;
  String? severity;
  String? selectedCrop;

  resolveSelectedCrop() {}

  final List<String> allSections = [];

  final List<String> allIssues = [
    'Pest',
    'Disease',
    'Nutritional Disorder',
  ];

  final List<String> allFindings = [
    'Pest',
    'Crop disease',
  ];

  final List<String> allSeverities = [
    'Low',
    'Medium',
    'High',
  ];

  getCropGrownInThatSection() {
    List<Field> allfields = allFields
        .where((element) => element.fieldName == widget.fieldName)
        .toList();

    List<Map<dynamic, dynamic>> allsections = allfields[0].sections;

    List<Map<dynamic, dynamic>> specificsection = allsections
        .where((element) => element['sectionName'] == selectedSection)
        .toList();

    setState(() {
      selectedCrop = specificsection[0]['crop'];
    });
  }

  bool checkBoxValue = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.green,
              ),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    List<Field> field = allFields
        .where((element) => element.fieldName == widget.fieldName)
        .toList();

    List<Map<dynamic, dynamic>> allsections = field[0].sections;

    for (var section in allsections) {
      allSections.add(section['sectionName']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
                          color: Colors.green,
                          height: 10,
                          fit: BoxFit.fitHeight),
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
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      'New Scouting',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.black54),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.fieldName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.black54),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border(
                            left: BorderSide(width: 2.0, color: Colors.green),
                            right: BorderSide(width: 2.0, color: Colors.green),
                            top: BorderSide(width: 2.0, color: Colors.green),
                            bottom: BorderSide(width: 2.0, color: Colors.green),
                          ),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(selectedDate!)
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Section',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.green),
                        right: BorderSide(width: 2.0, color: Colors.green),
                        top: BorderSide(width: 2.0, color: Colors.green),
                        bottom: BorderSide(width: 2.0, color: Colors.green),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: allSections
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedSection,
                        onChanged: (value) {
                          setState(() {
                            selectedSection = value as String;
                          });

                          getCropGrownInThatSection();
                        },
                        icon: const Icon(
                          Icons.arrow_downward,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.green,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 40,
                        buttonWidth: 160,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
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
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Crop',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.green),
                        right: BorderSide(width: 2.0, color: Colors.green),
                        top: BorderSide(width: 2.0, color: Colors.green),
                        bottom: BorderSide(width: 2.0, color: Colors.green),
                      ),
                    ),
                    child: selectedCrop == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 15),
                            child: Text(
                              selectedCrop!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.green),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Issue Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.green),
                        right: BorderSide(width: 2.0, color: Colors.green),
                        top: BorderSide(width: 2.0, color: Colors.green),
                        bottom: BorderSide(width: 2.0, color: Colors.green),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: allIssues
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedIssue,
                        onChanged: (value) {
                          setState(() {
                            selectedIssue = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_downward,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.green,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 40,
                        buttonWidth: 160,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
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
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Findings',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.green),
                        right: BorderSide(width: 2.0, color: Colors.green),
                        top: BorderSide(width: 2.0, color: Colors.green),
                        bottom: BorderSide(width: 2.0, color: Colors.green),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: allFindings
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedFindings,
                        onChanged: (value) {
                          setState(() {
                            selectedFindings = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_downward,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.green,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 40,
                        buttonWidth: 160,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
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
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Severity',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.green),
                        right: BorderSide(width: 2.0, color: Colors.green),
                        top: BorderSide(width: 2.0, color: Colors.green),
                        bottom: BorderSide(width: 2.0, color: Colors.green),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: allSeverities
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: severity,
                        onChanged: (value) {
                          setState(() {
                            severity = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_downward,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.green,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 40,
                        buttonWidth: 160,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
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
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  '% Area affected ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border(
                        left: BorderSide(width: 2.0, color: Colors.green),
                        right: BorderSide(width: 2.0, color: Colors.green),
                        top: BorderSide(width: 2.0, color: Colors.green),
                        bottom: BorderSide(width: 2.0, color: Colors.green),
                      ),
                    ),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: percentageController,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 30),
                Text(
                  'Comment',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width / 1.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 20.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border(
                              left: BorderSide(width: 2.0, color: Colors.green),
                              right:
                                  BorderSide(width: 2.0, color: Colors.green),
                              top: BorderSide(width: 2.0, color: Colors.green),
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.green),
                            ),
                          ),
                          child: SizedBox(
                            height: maxLines * 24.0,
                            child: TextFormField(
                              maxLines: maxLines,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  filled: true,
                                  hintStyle: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: commentController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 35,
                ),
                Text(
                  'Photos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddImages()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset('assets/photo.svg',
                          color: Colors.green,
                          height: 10,
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
