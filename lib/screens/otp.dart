import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video/screens/phone.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/logo.png', height: 250, width: 250),
        Text(
          'Enter OTP',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        Pinput(
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) => print(pin),
          onChanged: (value) {
            code = value;
          },
        ),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Did not get otp?',
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '+91' + Phone.ph,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  Phone.verify = verificationId;
                  Navigator.pushNamed(context, "otp");
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            },
            child: Text('Resend',
                style: GoogleFonts.lato(fontWeight: FontWeight.w800)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[200],
                foregroundColor: Colors.white),
          ),
        ]),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: Phone.verify, smsCode: code);

                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);
                Navigator.pushNamedAndRemoveUntil(
                    context, 'record', (route) => false);
              } catch (e) {
                Navigator.pushNamed(context, 'otp');
              }
            },
            child: Text('Get Started',
                style: GoogleFonts.lato(fontWeight: FontWeight.w800)),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).hintColor,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(height: 25),
        Container(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
              child: Text('Back',
                  style: GoogleFonts.lato(fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).hintColor,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'phone');
              }),
        ),
      ]),
    ));
  }
}
