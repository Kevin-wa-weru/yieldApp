import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddImages extends StatefulWidget {
  const AddImages({Key? key}) : super(key: key);

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  String? selectedCrop;
  final List<String> allCrops = [
    'Tomatoes',
    'Corn',
    'Carrot',
  ];

  List<dynamic> selectedPhotos = List<dynamic>.filled(5, null);
  final picker = ImagePicker();

  Future getImageFromGallery(picNumber) async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    var tempImage = File(pickedImage!.path);
    if (picNumber == 0) {
      setState(() {
        selectedPhotos[0] = tempImage;
      });
    }
    if (picNumber == 1) {
      setState(() {
        selectedPhotos[1] = tempImage;
      });
    }
    if (picNumber == 2) {
      setState(() {
        selectedPhotos[2] = tempImage;
      });
    }

    if (picNumber == 3) {
      setState(() {
        selectedPhotos[3] = tempImage;
      });
    }

    if (picNumber == 4) {
      setState(() {
        selectedPhotos[4] = tempImage;
      });
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
                        'Proceed',
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
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Crop',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 30,
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
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: allCrops
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedCrop,
                    onChanged: (value) {
                      setState(() {
                        selectedCrop = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.green,
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
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: const [
              SizedBox(
                width: 10,
              ),
              Text(
                'Upload photos of the infested crops ( 5max photos )',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: selectedPhotos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    key: Key('pic$index'),
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey[300]),
                        margin: const EdgeInsets.only(right: 10),
                        width: 250,
                        height: 200,
                        child: selectedPhotos[index] == null
                            ? TextButton(
                                onPressed: () {
                                  getImageFromGallery(index);
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  getImageFromGallery(index);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.file(
                                    selectedPhotos[index],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Photo ${index + 1}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black54),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Row(
            children: const [
              SizedBox(
                width: 10,
              ),
              Text(
                'I have detected leasions on leaf. I have a few questions to ask ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Do you see target like lessions on the leaf? ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black54),
              ),
              Container(
                width: 40,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Center(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Center(
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
