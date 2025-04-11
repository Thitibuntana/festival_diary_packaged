import 'dart:io';

import 'package:festival_diary_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import "package:image_picker/image_picker.dart";
import 'package:festival_diary_app/models/fest.dart';

class AddFestUI extends StatefulWidget {
  int? userId;
  AddFestUI({super.key, this.userId});

  @override
  State<AddFestUI> createState() => _AddFestUIState();
}

class _AddFestUIState extends State<AddFestUI> {
  TextEditingController festNameCtrl = TextEditingController(text: '');
  TextEditingController festDetailCtrl = TextEditingController(text: '');
  TextEditingController festNumDayCtrl = TextEditingController(text: '');
  TextEditingController festCostCtrl = TextEditingController(text: '0');
  TextEditingController festStateCtrl = TextEditingController(text: '');

  showwarningsnackbar(context, mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        mes,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }

  showcompletesnackbar(context, mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        mes,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 6, 107, 9),
    ));
  }

  File? festFile;
  Future<void> openCamera() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (img == null) return;

    setState(() {
      festFile = File(img.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        centerTitle: true,
        title: Text(
          "Add Festival Diary",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Add Festival Details',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                InkWell(
                    onTap: () async {
                      await (openCamera());
                    },
                    child: festFile == null
                        ? Icon(
                            Icons.person_add_alt_1,
                            size: 100,
                            color: Color(mainColor),
                          )
                        : Image.file(
                            festFile!,
                            width: 125,
                            height: 125,
                            fit: BoxFit.cover,
                          )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Festival Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextField(
                  controller: festNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.abc_sharp)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Festival Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextField(
                  controller: festDetailCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.deck_outlined)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'How long was the festival',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextField(
                  controller: festNumDayCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timelapse)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Festival Cost',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextField(
                  controller: festCostCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.money)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Festival State',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextField(
                  controller: festStateCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(mainColor)),
                    onPressed: () async {
                      if (festNameCtrl.text.trim().isEmpty) {
                        showwarningsnackbar(
                            context, 'Please enter Festival Name');
                      } else if (festDetailCtrl.text.trim().isEmpty) {
                        showwarningsnackbar(
                            context, 'Please enter Festival Details');
                      } else if (festNumDayCtrl.text.trim().isEmpty) {
                        showwarningsnackbar(
                            context, 'Please enter Festival Duration');
                      } else if (festCostCtrl.text.trim().isEmpty) {
                        showwarningsnackbar(
                            context, 'Please enter Festival Cost');
                      } else if (festStateCtrl.text.trim().isEmpty) {
                        showwarningsnackbar(
                            context, 'Please enter Festival State');
                      } else {
                        Fest fest = Fest(
                          festName: festNameCtrl.text.trim(),
                          festDetail: festDetailCtrl.text.trim(),
                          festNumDay: int.parse(festNumDayCtrl.text.trim()),
                          festCost: int.tryParse(festCostCtrl.text.trim()) ?? 0,
                          userId: widget.userId,
                          festState: festStateCtrl.text.trim(),
                        );
                        if (await FestAPI().AddFest(fest, festFile)) {
                          showcompletesnackbar(
                            context,
                            'Added successfully',
                          );
                        } else {
                          showwarningsnackbar(
                            context,
                            'Added failed',
                          );
                        }
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.065,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
