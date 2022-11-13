import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/HomePage/home_page_screen.dart';
import 'package:frontend/services/remote_service.dart';
import 'package:frontend/shared/local_save.dart';

import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String selectedCampus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 75, 20, 20),
            child: SignUp_Form(context)));
  }

  String name = "", campus = "", upiID = "", hostel = "";

  Form SignUp_Form(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(children: [
        const Text(
          "Sign up for Village Square",
          textScaleFactor: 2.0,
        ),
        TextFormField(
          onSaved: (val) => name = val!,
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        TextFormField(
          onSaved: (val) => upiID = val!,
          decoration: const InputDecoration(
            labelText: 'UPI Id',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your UPI ID';
            }
            return null;
          },
        ),
        DropdownButtonFormField(
            onSaved: (val) => campus = val.toString(),
            decoration: const InputDecoration(
              labelText: 'Campus',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow),
              ),
            ),
            hint: const Text("Select option", maxLines: 1),
            items: <String>['North Campus', 'South Campus']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCampus = newValue!;
              });
            }),
        TextFormField(
          onSaved: (val) => hostel = val!,
          decoration: const InputDecoration(
            labelText: 'Hostel',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Hostel';
            }
            return null;
          },
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate() && selectedCampus != null) {
              formKey.currentState?.save();
              FirebaseAuth auth = FirebaseAuth.instance;
              String? authToken = await auth.currentUser?.getIdToken();
              Response res = await RemoteService()
                  .updateUser(authToken!, name, upiID, campus, hostel);

              if (res.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User successfully registered')),
                );

                localSave('username', name);
                localSave('campus', campus);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => HomePageScreen())),
                    (route) => false);
              }

              // Else will never work, res response await hi karta reh jayega if server is offline

              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('An error occurred')),
                );
              }
            }
          },
          child: const Text('Submit'),
        ),
      ]),
    );
  }
}
