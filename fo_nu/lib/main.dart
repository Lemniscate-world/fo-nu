import 'package:flutter_overlay_window/flutter_overlay_window.dart'; // Package for Everything Overlay
import 'package:flutter/material.dart'; // For Simple UI
import 'package:flutter/services.dart'; // For Clipboard
import 'package:share_plus/share_plus.dart'; // Package for shared files
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fo Nu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("Ewe Transcriber")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  if (await FlutterOverlayWindow.isPermissionGranted()) {
                    FlutterOverlayWindow.showOverlay(
                      height: 100,
                      width: 100,
                      alignment: OverlayAlignment.center,
                    );
                  } else {
                    FlutterOverlayWindow.requestPermission();
                  }
                },
                child: Text("Start Overlay"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => processInput(context),
                child: Text("Process Clipboard"),
              ),
              SizedBox(height: 40),
              Text(
                "Fo Nu - Ewe Translator",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Copy text to clipboard or share audio files to translate to Ewe",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void processInput(BuildContext context) {
    monitorClipboard(); // Check clipboard
    // Show a snackbar to indicate processing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Checking clipboard for text to translate...")),
    );
  }
}

// Add this function to handle shared files from the main UI
Future<void> receiveSharedFile() async {
  try {
    // Fixed: Using getInitialFiles() instead of getInitialMedia() or getInitialFile()
    final List<SharedMediaFile>? sharedMediaFiles =
        // .instance provides access to the singleton instance of the sharing intent handler initialized when WidgetsFlutterBinding.ensureInitialized() is called
        await ReceiveSharingIntent.instance.getInitialMedia();

    if (sharedMediaFiles != null && sharedMediaFiles.isNotEmpty) {
      final List<XFile> files =
          sharedMediaFiles.map((file) => XFile(file.path)).toList();
      await handleSharedFiles(files);
    }
  } catch (e) {
    print("Error receiving shared files: $e");
  }
}

// Update main function to use the new MyApp implementation
void main() async {
  // Initializes the binding between the Flutter framework and the device
  WidgetsFlutterBinding.ensureInitialized();
  // Ensures Flutter engine is properly setup

  // Setting up and sharing intent handling
  final args = WidgetsBinding.instance.platformDispatcher.defaultRouteName;
  if (args.startsWith('/share')) {
    // This is a share intent
    try {
      // Fixed: Using getSharedFiles() instead of getSharedMedia() or getMediaStream()
      ReceiveSharingIntent.instance.getMediaStream().listen(
        (List<SharedMediaFile> sharedMediaFiles) {
          if (sharedMediaFiles.isNotEmpty) {
            final List<XFile> files =
                sharedMediaFiles.map((file) => XFile(file.path)).toList();
            handleSharedFiles(files);
          }
        },
        onError: (e) {
          print("Error handling share intent stream: $e");
        },
      );
    } catch (e) {
      print("Error handling share intent: $e");
    }
  }

  runApp(const MyApp());
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
      // Here we got the root of the widget tree
      home: Scaffold(body: FloatingButton()),
    ),
  );
}

// -----------------------------------------------------------------

// The Floating Button and Its World Here ////////////

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

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
