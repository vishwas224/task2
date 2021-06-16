import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;
//conditional import
import 'package:task2/UiFake.dart' if 
(dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: RazorPayWeb(),
    );
  }
}


class RazorPayWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //register view factory
    ui.platformViewRegistry.registerViewFactory("rzp-html",(int viewId) {
      IFrameElement element=IFrameElement();
//Event Listener
       window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if(element.data=='MODAL_CLOSED'){
          Navigator.pop(context);
        }else if(element.data=='SUCCESS'){
          print('PAYMENT SUCCESSFULL!!!!!!!');
        }
      });

      element.requestFullscreen();
      element.src='assets/html/payment.html';
      element.style.border = 'none';
      return element;
    });
    
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
          return Container(
            child: HtmlElementView(viewType: 'rzp-html'),
          );
    }));
  }

}
