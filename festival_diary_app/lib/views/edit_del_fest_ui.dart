import 'dart:io';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDelFestUI extends StatefulWidget {
  Fest? fest;

  EditDelFestUI({super.key, this.fest});

  @override
  State<EditDelFestUI> createState() => _EditDelFestUIState();
}

class _EditDelFestUIState extends State<EditDelFestUI> {
  TextEditingController festNameCtrl = TextEditingController();
  TextEditingController festDetailCtrl = TextEditingController();
  TextEditingController festNumdayCtrl = TextEditingController();
  TextEditingController festCostCtrl = TextEditingController();
  TextEditingController festStateCtrl = TextEditingController();

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
  void initState() {
    festNameCtrl.text = widget.fest!.festName!;
    festDetailCtrl.text = widget.fest!.festDetail!;
    festNumdayCtrl.text = widget.fest!.festNumDay!.toString();
    festCostCtrl.text = widget.fest!.festCost!.toString();
    festStateCtrl.text = widget.fest!.festState!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        centerTitle: true,
        title: Text(
          "Your Festival Diary",
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
                        ? widget.fest!.festImage == ''
                            ? Image.asset(
                                "assets/images/festlogo.png",
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${baseUrl}/images/fests/${widget.fest!.festImage}',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                        : Image.file(
                            festFile!,
                            width: 150,
                            height: 150,
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
                  controller: festNumdayCtrl,
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
                      } else if (festNumdayCtrl.text.trim().isEmpty) {
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
                          festNumDay: int.parse(festNumdayCtrl.text.trim()),
                          festCost: double.parse(festCostCtrl.text.trim()),
                          userId: widget.fest!.userId,
                          festState: festStateCtrl.text.trim(),
                        );
                        if (await FestAPI().updateFest(fest, festFile)) {
                          showcompletesnackbar(
                            context,
                            'Save and Edit successfully',
                          );
                        } else {
                          showwarningsnackbar(
                            context,
                            'Save and Edit  failed',
                          );
                        }
                      }
                    },
                    child: Text(
                      'Edit and Save',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.red),
                    onPressed: () async {
                      if (await FestAPI().deleteFest(widget.fest!.festId!) ==
                          true) {
                        showcompletesnackbar(context, 'Deleted Success');
                        Navigator.pop(context);
                      } else {
                        showwarningsnackbar(context, 'Delete failed');
                      }
                    },
                    child: Text(
                      'Delete',
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