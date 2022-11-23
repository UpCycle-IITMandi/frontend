import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/my_account.dart';
import 'package:frontend/services/local_save.dart';
import 'package:frontend/services/remote_service.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:rounded_modal/rounded_modal.dart';

import 'package:google_fonts/google_fonts.dart';

File file = File("");

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String photoUrl;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController program = TextEditingController();
  TextEditingController upiId = TextEditingController();
  TextEditingController hostel = TextEditingController();
  TextEditingController campus = TextEditingController();

  Future<bool> getData() async {
    Map user = await getUser();
    firstname.text = user['username'];
    email.text = user["email"];
    photoUrl = user["photoUrl"];
    campus.text = user["campus"];
    hostel.text = user["hostel"];
    upiId.text = user["upi"];
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 244, 242, 242),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20, right: 15, left: 15, bottom: 70),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundColor:
                                          Color.fromARGB(255, 108, 108, 108),
                                      child: CircleAvatar(
                                        radius: 71,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 69,
                                          backgroundImage:
                                              NetworkImage(photoUrl),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();

                                          if (result != null) {
                                            file = File(
                                                result.files.single.path ?? "");
                                          } else {
                                            file = File("");
                                          }
                                        },
                                        child: CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                                "https://t4.ftcdn.net/jpg/02/83/72/41/360_F_283724163_kIWm6DfeFN0zhm8Pc0xelROcxxbAiEFI.jpg")),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "USER NAME",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: firstname,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Enter User name',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "UPI ID",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: upiId,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Enter Default UPI id',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "EMAIL",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: email.text,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "CAMPUS",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: campus,
                                      cursorHeight: 18,
                                      readOnly: true,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        showRoundedModalBottomSheet(
                                            context: context,
                                            radius: 20,
                                            builder: (context) {
                                              List<String> options = [
                                                "North Campus",
                                                "South Campus"
                                              ];
                                              var selectedIndex;
                                              return Container(
                                                height: 300,
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  150.0,
                                                                  10.0,
                                                                  150.0,
                                                                  20.0),
                                                          child: Container(
                                                            height: 8.0,
                                                            width: 80.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: Text(
                                                            "Select Campus",
                                                            style: GoogleFonts
                                                                .openSans(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    StatefulBuilder(builder:
                                                        (BuildContext context,
                                                            StateSetter
                                                                mystate) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 75,
                                                                bottom: 50),
                                                        child: ListView.builder(
                                                          itemCount:
                                                              options.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Column(
                                                              children: [
                                                                ListTile(
                                                                  title: Text(
                                                                      options[
                                                                          index]),
                                                                  leading: (selectedIndex ==
                                                                          index)
                                                                      ? Icon(
                                                                          Icons
                                                                              .check_circle,
                                                                          color:
                                                                              Color(0xFF0D47A1),
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .circle_outlined,
                                                                          color:
                                                                              Colors.grey),
                                                                  onTap: () {
                                                                    selectedIndex =
                                                                        index;
                                                                    mystate(() {
                                                                      selectedIndex =
                                                                          index;
                                                                    });
                                                                  },
                                                                ),
                                                                Divider()
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: FlatButton(
                                                          onPressed: () {
                                                            campus.text = options[
                                                                selectedIndex];
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            height: 45,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xFF0D47A1),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                            child: Center(
                                                              child: Text(
                                                                "Save",
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Colors.black,
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Select Campus',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: Text(
                                      "HOSTEL",
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 47,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: TextField(
                                      controller: hostel,
                                      cursorHeight: 18,
                                      cursorColor: Colors.blue,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 2,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                        hintText: 'Hostel Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ]),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child:
            // ),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey),
            ),
          ),
          child: FlatButton(
            onPressed: () async {
              String? authToken =
                  await FirebaseAuth.instance.currentUser?.getIdToken();
              String base64Image = "";
              if (file.path != "") {
                List<int> imageBytes = file.readAsBytesSync();
                base64Image = base64Encode(imageBytes);
              }

              if (authToken != null) {
                Response res = await RemoteService().updateUser(
                    authToken,
                    base64Image,
                    firstname.text,
                    upiId.text,
                    campus.text,
                    hostel.text);
                print(res.body);
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => myAccount()));
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                print("object");
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: Center(
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
