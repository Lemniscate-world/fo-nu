import 'package:flutter_overlay_window/flutter_overlay_window.dart'; // Package for Everything Overlay
import 'package:flutter/material.dart'; // For Simple UI
import 'package:fo_nu/floating_button.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:share_plus/share_plus.dart'; // Package for shared files
// Package for file paths
// Library for input/output

// Dictionary for Ewe translations //////////////////////////////////////////////////
// A Map is a collection that stores key-value pairs, similar to dictionaries or hash tables in other languages:
Map<String, String> eweDictionary = {
  "Hello": "Shalom",
  "Good": "Eƒe",
  "Thank you": "Akpe",
  "Welcome": "Woezɔ",
  "Goodbye": "Heyi",
  "Yes": "Ɛe",
  "No": "Ao",
  "Please": "Meɖekuku",
  "Sorry": "Taflatse",
  "Friend": "Xɔlɔ̃",
};
// Will be finding some way to use good logic here, import or create my own dictionary
//////////////////////////////////////////////////////////////////////////////////////

// Function to handle shared files (particularly audio files from WhatsApp) //////////////
// XFile is a cross-platform file representation part of the share_plus package
// It provides convenient methods to access file properties and content
Future<void> handleSharedFiles(List<XFile> files) async {
  if (files.isNotEmpty) {
    // Get the first shared file
    // final is a variable modifier that makes a variable immutable (can't be reassigned after initialization)
    final XFile file = files.first;

    // Get file path
    final String filePath = file.path;

    // Check if it's an audio file (basic check)
    if (filePath.endsWith('.mp3') ||
        filePath.endsWith('.m4a') ||
        filePath.endsWith('.aac') ||
        filePath.endsWith('.ogg')) {
      // Pauses execution of an async function until a Future completes, unwraps the Future and returns its value
      // Transcribe the audio file is a <Future>
      await transcribeAudio(filePath);
    }
  }
}

// Function to transcribe audio to text -----
Future<void> transcribeAudio(String filePath) async {
  // This is a placeholder for actual transcription logic
  //  tflite_flutter or an API
  print("Transcribing audio file: $filePath");

  // Placeholder for transcription result
  String transcribedText =
      "This is a placeholder for transcribed text from: $filePath";

  // Translate the transcribed text to Ewe
  String eweText = translateToEwe(transcribedText);

  // Display the translated text
  showEweOutput(eweText);
}

///////////////////////////////////////////////////////////////

// Clipboard monitoring //////////////
// Calling this function when the floating button is tapped (FloatingButton)
// Accessing the system clipboard, requesting text data specifically, and using .then() because clipboard access is asynchronous
void monitorClipboard() {
  Clipboard.getData(Clipboard.kTextPlain).then((clip) {
    if (clip?.text != null) {
      String eweText = translateToEwe(clip!.text!);
      // Display the translated text
      showEweOutput(eweText);
    }
  });
}

// Function that translates text to Ewe -----
String translateToEwe(String text) {
  // Implement translation logic here
  // Will be using Izzy Api Gateway or whisper by tensorflowlite flutter package or Hugging face API

  // Check if the text exists in our dictionary
  return eweDictionary[text] ?? "Nye dzi"; // Default is "Nye dzi" if not found
}

// Function to display translated text -----
Future<void> showEweOutput(String text) async {
  // Implement display logic here
  // Some UI Design and Notification Handling here
  await FlutterOverlayWindow.showOverlay(
    height: 200,
    width: 300,
    alignment: OverlayAlignment.center,
  );

  // Display the translated text in the overlay
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              // Copy the translated text to clipboard when tapped
              Clipboard.setData(ClipboardData(text: text));
              // Close the overlay after copying
              FlutterOverlayWindow.closeOverlay();
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Text(text, style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    ),
  );
}

//////////////////////////////////////

// Principal App Class //////////////
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fo Nu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

// async function meaning it is running independently of main program flow or in background
void main() async {
  // Initializes the binding between the Flutter framework and the device
  WidgetsFlutterBinding.ensureInitialized();
  // Ensures Fluter engine is properly setup

  // Setting up and sharing intent handling
  // Share intent handling is a mechanism for apps to receive content shared from other apps
  // Require registration in the app manifest which i did
  // Enables features like "Share to" functionality from other apps
  final args = WidgetsBinding.instance.platformDispatcher.defaultRouteName;
  if (args.startsWith('/share')) {
    // This is a share intent
    Share.getInitialFiles().then((List<XFile> files) {
      if (files.isNotEmpty) {
        handleSharedFiles(files);
      }
    });
  }

  runApp(MyApp());

  // Setting up overlay window
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

///////////////////////////////////////

// pragma for overlay, pragma is a directive to the Dart compiler
// It means the following function should be included in the final binary and never be optimized
// even if it appears to be unused
// Here is entry-point of the App
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    MaterialApp(
      // Here we got the root of thewidget tree
      home: Scaffold(body: FloatingButton()),
    ),
  );
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
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: Center(
          child: Text("Ewe", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////
