import 'package:flutter_overlay_window/flutter_overlay_window.dart'; // Package for Everything Overlay
import 'package:flutter/material.dart'; // For Simple UI
import 'package:fo_nu/floating_button.dart'; 
import 'package:flutter/services.dart'; // For Clipboard


// Clipboard monitoring //////////////
// Calling this function when the floating button is tapped (FloatingButton)
void monitorClipboard() {
  Clipboard.getData(Clipboard.kTextPlain).then((clip) {
    if (clip?.text != null) {
      String eweText = translateToEwe(clip!.text!);
      showEweOutput(eweText);
    }
  });
}

String translateToEwe(String text) {
  // Implement translation logic here
  // Will be using Izzy Api Gateway or whisper by tensorflowlite flutter package or Hugging face API
  return "Ewe: " + text;
}

void showEweOutput(String text) {
  // Implement display logic here
  // Some UI Design and Notification Handling here
  print("Translated text: $text");
}

//////////////////////////////////////




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fo Nu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

void main() async {
  runApp(MyApp());
  if (await FlutterOverlayWindow.isPermissionGranted()) {
    FlutterOverlayWindow.showOverlay(
      height: 100,
      width: 100,
      alignment: OverlayAlignment.center,
    );
  } else {
    FlutterOverlayWindow.requestPermission();
  }
}

@pragma("vm:entry-point")
void overlayMain() {
  runApp(MaterialApp(
    home: Scaffold(
      body: FloatingButton(),
    ),
  ));
}

// The Floating Button and Its World Here ////////////

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => monitorClipboard(),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(child: Text("Ewe", style: TextStyle(color: Colors.white))),
      ),
    );
  }
}

///////////////////////////////////////////////////////