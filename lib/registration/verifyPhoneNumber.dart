import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_receiver/sms_receiver.dart';

class VerifyPhoneNumber extends StatefulWidget {
  final String phoneNumber;
  VerifyPhoneNumber(this.phoneNumber);
  @override
  VerifyPhoneNumberState createState() =>
      VerifyPhoneNumberState(this.phoneNumber);
}

class VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  bool buttonEnabled = false;
  String phoneNumber;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String code;
  VerifyPhoneNumberState(this.phoneNumber) {
    sendCode();
  }

  sendCode() async {
    //print("Start");
    var s = SmsReceiver((String str) {
      print("MESSAGE");
      print(str);
    },onTimeout:(){
      print("Timeout");
    },onFailureListener: (){
      print("Failed"); 
    });
    s.startListening();
    
    
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (String code, [int _code]) {
          //print(code);
          //print(_code);
        },
        verificationCompleted: (AuthCredential credentials) {
          //print(credentials);
        },
        verificationFailed: (AuthException exception) {
          //print(exception.message);
        },
        codeAutoRetrievalTimeout: (String c) {
          //print(c);
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Verify Phone number'),
      ),
      child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Please enter the verification code that we sent to: " +
                  phoneNumber),
              CupertinoTextField(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                clearButtonMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.number,
                maxLength: 6,
                autocorrect: false,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ),
                placeholder: 'Enter code',
                autofocus: true,
                onChanged: (String value) {
                  setState(() {
                    buttonEnabled = value.length > 3;
                    if (buttonEnabled)
                      buttonEnabled = int.tryParse(value) != null;
                    code = value;
                  });
                },
              ),
              Container(
                child: CupertinoButton.filled(
                  child: Text('Verify'),
                  onPressed: buttonEnabled
                      ? () {
                          print(buttonEnabled);

                          Navigator.push(context, CupertinoPageRoute<void>(
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                  child: Center(
                                child: Text("Hello"),
                              ));
                            },
                          ));
                        }
                      : null,
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          )),
    );
  }
}
