import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'verifyPhoneNumber.dart';

class InputPhoneNumber extends StatefulWidget{

   @override
  InputPhoneNumberState createState() => InputPhoneNumberState();
}

class InputPhoneNumberState extends State<InputPhoneNumber> {

  bool buttonEnabled = false;
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('ChatApp'),
      ),
      child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: CupertinoPicker(
                  backgroundColor: CupertinoColors.white,
                  diameterRatio: 1,
                  children: <Widget>[
                    Center(
                        child: Text(
                      "India",
                    )),
                  ],
                  itemExtent: 50,
                  onSelectedItemChanged: (int index) {},
                ),
                height: 50,
              ),
              CupertinoTextField(
                prefix: Row(children: <Widget>[
                  Icon(
                    CupertinoIcons.phone_solid,
                    color: CupertinoColors.lightBackgroundGray,
                    size: 28,
                  ),
                   Text("+91")
                  
                ]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                clearButtonMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.number,
                maxLength: 10,
                
                autocorrect: false,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ),
                placeholder: 'Enter phone number',
                autofocus: true,
                onChanged: (String value){                  
                    setState(() {
                      
                      buttonEnabled=value.length==10;
                      if(buttonEnabled)
                        buttonEnabled = int.tryParse(value)!=null;
                      phoneNumber = '+91'+value;
                    }); 
                },
              ),
              Container(
                child: CupertinoButton.filled(
                  child: Text('Next'),
                  onPressed: buttonEnabled?() {
                  
                    Navigator.push(context, CupertinoPageRoute<void>(
                      builder: (context)=>VerifyPhoneNumber(phoneNumber),
                    ));
                  }:null,
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          )),
    );
  }
}
