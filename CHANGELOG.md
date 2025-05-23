# Changelog

All notable changes to the Fo Nu project will be documented in this file.

## [0.1.2] - 2023-09-15

### Added
- Improved error handling for file sharing intents
- Updated method calls for receive_sharing_intent package compatibility
- Enhanced clipboard monitoring with better error feedback

### Technical Implementation Details
- **Package Compatibility Updates**: 
  - Updated method calls for `receive_sharing_intent` package
  - Fixed method references from `getInitialMedia()` to `getInitialFiles()`
  - Changed `getMediaStream()` to `getSharedFiles()` for proper stream handling

- **Error Handling Improvements**:
  - Added try-catch blocks around sharing intent operations
  - Implemented proper error logging for debugging purposes
  - Added user-friendly error messages for failed operations

- **Code Structure Enhancements**:
  - Refactored clipboard monitoring for better reliability
  - Improved UI feedback during processing operations
  - Optimized overlay window management

### Known Issues
- Dictionary is still limited to only 10 phrases
- No support for partial matches or sentence parsing
- Transcription still uses placeholder instead of actual TFLite implementation

### Next Steps
- Implement TensorFlow Lite for audio transcription
- Expand Ewe dictionary with more phrases
- Add support for sentence parsing and partial matches
- Improve UI/UX for better user interaction
- Add settings page for customization options

## [0.1.1] - 2023-08-10

### Added
- Implemented basic Ewe dictionary with common phrases
- Enhanced translation function with dictionary lookup
- Improved overlay UI for displaying translated text
- Added tap-to-copy functionality for translated text
- Implemented automatic overlay dismissal after copying

### Technical Implementation Details
- **Dictionary Implementation**: 
  - Created `Map<String, String>` structure for English-to-Ewe translations
  - Added 10 common phrases as initial dictionary entries
  - Implemented fallback text ("Nye dzi") for unknown phrases

- **Overlay Improvements**:
  - Set fixed dimensions (200×300 pixels) for consistent user experience
  - Implemented `GestureDetector` for tap interaction
  - Added clipboard integration using `Clipboard.setData`
  - Implemented automatic overlay dismissal with `FlutterOverlayWindow.closeOverlay()`

- **UI Enhancements**:
  - Improved text styling with 18pt font size
  - Added padding (16px) around text for better readability
  - Used clean white background for maximum contrast

### Known Issues
- Dictionary is limited to only 10 phrases
- No support for partial matches or sentence parsing
- Transcription still uses placeholder instead of actual TFLite implementation
- No feedback mechanism for unknown words

### Next Steps
- Expand dictionary with more Ewe phrases
- Implement TensorFlow Lite for actual audio transcription
- Add support for sentence parsing and partial matches
- Implement user feedback mechanism for unknown words
- Add pronunciation guides or audio playback for Ewe phrases

## [0.1.0] - 2023-07-15

### Added
- Initial project setup with Flutter framework
- Basic UI structure with Material Design theme
- Floating button implementation for clipboard monitoring
- Placeholder functions for audio transcription and Ewe translation
- Integration with `flutter_overlay_window` for overlay functionality
- Integration with `share_plus` for handling shared files
- Integration with `path_provider` for file path management
- Basic clipboard monitoring functionality
- Android manifest configuration for share intents
- Support for receiving audio files from other apps (WhatsApp)
- File type checking for supported audio formats (.mp3, .m4a, .aac, .ogg)
- Asynchronous processing pipeline for shared files
- Placeholder UI for displaying translated text

### Technical Implementation Details
- **Future-based Functions**: Implemented asynchronous functions using Dart's Future API
  - `handleSharedFiles()`: Processes files shared from other apps
  - `transcribeAudio()`: Placeholder for audio transcription functionality
  - Both functions use async/await pattern for clean asynchronous code

- **XFile Handling**: Added support for cross-platform file representation
  - Processing of `List<XFile>` objects from share intents
  - Extraction of file paths and properties
  - Platform-independent file access

- **Variable Management**: 
  - Used `final` keyword for immutable variable declarations
  - Implemented proper scoping for shared data
  - Created clear data flow from file receipt to processing

- **Asynchronous Operations**:
  - Implemented `await` operations for sequential processing
  - Added proper error handling structure
  - Ensured UI responsiveness during file processing

- **Share Intent Handling**:
  - Added route checking for share intents (`/share`)
  - Implemented `Share.getInitialFiles()` for retrieving shared content
  - Set up callback system for processing files

- **Flutter Initialization**:
  - Added `WidgetsFlutterBinding.ensureInitialized()` for proper plugin setup
  - Implemented correct startup sequence for overlay functionality
  - Ensured platform channels are available before use

- **Android Configuration**:
  - Updated AndroidManifest.xml with intent filters
  - Added support for `ACTION_SEND` and `ACTION_SEND_MULTIPLE` intents
  - Configured MIME type filtering for audio files (`audio/*`)
  - Set appropriate activity attributes for sharing functionality

### Known Issues
- Transcription functionality is currently a placeholder
- Translation to Ewe is not yet implemented
- UI for displaying translated text needs improvement
- Overlay permission handling needs more robust error checking
- Limited to audio file formats only

### Next Steps
- Implement actual audio transcription using TensorFlow Lite
- Develop Ewe translation engine or API integration
- Improve UI for displaying translated text
- Add support for text sharing from other apps
- Implement caching for better performance
- Add user settings for customization
