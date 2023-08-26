//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: textColor),
        useMaterial3: true,
        textTheme: GoogleFonts.notoSerifTextTheme(Theme.of(context).textTheme)
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  late String input_sms;
  late String prediction = '';
  final inputController = TextEditingController();
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: size.width/1.2,  //498, //size.width/2.5 of my pc --> 1243.2
          height: size.height/1.25, 
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: defaultPadding)),
              
              Flexible(
                flex: 0,
                child: Text(
                  'SMS Spam Detector',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                    fontSize: 45,
                    fontWeight: FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
              
              
              const Padding(padding: EdgeInsets.only(top: defaultPadding+5)),
              //Text('data'),


              SizedBox(
                width: 498 - 2*defaultPadding,
                child: TextField(
                  controller: inputController,
                  onSubmitted: (value) async {
                    input_sms = inputController.text.toString();
                    //print(input_sms);
                    String apiUrlEndpoint = 'http://127.0.0.1:33/predict/' + input_sms; 
                    final res = await get(Uri.parse(apiUrlEndpoint));
                    //if (res.statusCode == 200) {  print('Data Recieved!'); }
                    setState(() {prediction = res.body;});
                  },
                  cursorColor: textColor,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 20,
                    ),
                  keyboardType: TextInputType.text,
                  minLines: 4,
                  maxLines: 8,
                  obscureText: false,
                  decoration: const InputDecoration(
                  
                    fillColor: boxColor,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 4,
                        ),
                      ),
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: 4,
                      ),
                    ),
                    hintText: '',
                    hintStyle: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                    alignLabelWithHint: true,
                    label: Text(
                      'Enter the SMS:',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        ),
                      ),
                    //floatingLabelBehavior: FloatingLabelBehavior.never,
                    //labelText: 'Enter the SMS',
                    // labelStyle: TextStyle(
                    //   color: textColor,
                    //   fontSize: 13,
                    //   ),
                  ),
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: defaultPadding+8)),

              //Button
              SizedBox(
                width: 498 - 2*defaultPadding,
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: defaultPadding/2,),),
                    
                    //Text('data', style: TextStyle(color: textColor),),
                    
                    SizedBox(
                      height: 45,
                      child: FloatingActionButton.extended(
                        backgroundColor: boxColor,
                        //focusColor: borderColor,
                        splashColor: borderColor,
                        onPressed: () async{
                          input_sms = inputController.text.toString();
                          //print(input_sms);
                          String apiUrlEndpoint = 'http://127.0.0.1:33/predict/' + input_sms; 
                          final res = await get(Uri.parse(apiUrlEndpoint));
                          //if (res.statusCode == 200) {  print('Data Recieved!'); }
                          setState(() {prediction = res.body;});
                        }, 
                        label: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25),),
                          side: BorderSide(
                            color: borderColor,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                
                    Text(
                      prediction, 
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
              
                    const Padding(padding: EdgeInsets.only(right: defaultPadding,),),
                  ],
                ),
              ),
              
              const Spacer(),

              const Text(
                'A Machine-Learning Project with Flutter front-end and Flask server back-end',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  wordSpacing: 3.5,
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: defaultPadding+4))

            ],
          ),
          
        ),
        
      ),
    );
  }
}