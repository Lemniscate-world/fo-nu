- Provider or Riverpod for State Management: A simple state management solution to handle the overlay’s visibility and processed text

- Service-Like Logic: singleton or background process to manage the overlay, mimicking Android’s Service behavior.




flutter_overlay_window: A Flutter package to create overlays on Android.

flutter_clipboard_manager: Captures copied text from WhatsApp.

share_plus: Receives shared voice notes from WhatsApp.

path_provider: Accesses temporary storage for audio files.

tflite_flutter (TensorFlow Lite): Runs transcription/translation models (e.g., Whisper).




Floating Button: A draggable FloatingActionButton or custom widget as the overlay.

Pop-up Output: A small AlertDialog or custom overlay widget to show Ewe text.


Overlay Permission: Request Android’s "Draw Over Other Apps" via flutter_overlay_window.

Share Intent: Handle incoming audio files with share_plus.



Temporary Files: Store voice notes in path_provider’s temp directory.

Caching: Use a Dart Map for quick dictionary lookups.

