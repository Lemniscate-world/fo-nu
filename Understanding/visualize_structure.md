MyApp (StatelessWidget)
  |
  ├── MaterialApp (Core widget that implements Material Design)
  |     | - Properties: title, theme (ThemeData)
  |     | - Purpose: Provides navigation, theming, and localization
  |     |
  |     └── MyHomePage (Your main screen)
  |           | - Properties: Various UI elements
  |           | - Purpose: Main interface for user interaction
  |
  └── FlutterOverlayWindow (Plugin for creating overlay windows)
        | - Properties: height, width, alignment
        | - Purpose: Creates floating UI elements over other apps
        | - Requires: SYSTEM_ALERT_WINDOW permission
        |
        └── FloatingButton (Custom widget)
              | - Properties: GestureDetector with Container
              | - Purpose: Provides a tappable floating button
              | - Size: 60x60 pixels circular blue button
              | - Event: onTap triggers monitorClipboard()
              |
              └── monitorClipboard() (Asynchronous function)
                    | - Input: None
                    | - Process: Retrieves clipboard text asynchronously
                    | - Output: Passes text to translation function
                    |
                    ├── translateToEwe() (Synchronous function)
                    |     | - Input: String text
                    |     | - Process: Translates text to Ewe language
                    |     | - Output: Translated string
                    |     | - Note: Currently a placeholder
                    |
                    └── showEweOutput() (Synchronous function)
                          | - Input: String text
                          | - Process: Displays translated text
                          | - Output: UI update or notification
                          | - Note: Currently just prints to console