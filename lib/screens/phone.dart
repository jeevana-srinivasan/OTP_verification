import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  static String verify = "";
  static String ph = "";

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    countrycode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/logo.png', height: 250, width: 250),
        SizedBox(height: 50),
        Text(
          'Enter mobile number',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black87, width: 1)),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '+91',
                      hintStyle: TextStyle(color: Colors.black54),
                      contentPadding: EdgeInsets.all(8)),
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                width: 25,
                height: 12,
              ),
              SizedBox(
                  height: 40,
                  width: 15,
                  child: Text(
                    '|',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  )),
              Expanded(
                child: TextField(
                    onChanged: (value) {
                      phone = value;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mobile number',
                        hintStyle: TextStyle(color: Colors.black54),
                        contentPadding: EdgeInsets.all(8))),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: countrycode.text + phone,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  Phone.verify = verificationId;
                  Phone.ph = phone;
                  Navigator.pushNamed(context, "otp");
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            },
            child: Text('Next',
                style: GoogleFonts.lato(fontWeight: FontWeight.w800)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).hintColor),
          ),
        )
      ]),
    ));
  }
}
