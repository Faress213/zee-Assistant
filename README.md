# 🤖 Zee Assistant - AI Chat Application

A modern, beautiful Flutter chat application powered by AI that provides intelligent conversations with real-time connectivity monitoring and elegant user experience.

## ✨ Features

- **🤖 AI-Powered Chat**: Intelligent conversations using Llama 3.3 70B model
- **🌐 Real-time Connectivity**: Automatic internet connection monitoring
- **🎨 Beautiful UI**: Modern design with custom toast notifications
- **🌙 Theme Support**: Automatic light/dark theme switching
- **📱 Cross-Platform**: Supports Android, iOS, Web, Windows, macOS, and Linux
- **⚡ Real-time Updates**: Live connection status with smooth animations
- **🔄 Auto-scroll**: Automatic message scrolling for better UX
- **💾 Message History**: Persistent chat history during session

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Faress213/zee-Assistant.git
   cd newvirus
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Settings**
   - Open `lib/utils/texts.dart`
   - Add your API endpoint and key:
   ```dart
   static const String endpoint = "YOUR_API_ENDPOINT";
   static const String apikey = "YOUR_API_KEY";
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 📦 Dependencies

### Main Dependencies
- **provider**: State management
- **connectivity_plus**: Network connectivity monitoring
- **http**: API requests
- **flutter_lottie**: Animations (if using Lottie files)

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code analysis

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── Chat.dart            # Chat model
│   └── Message.dart         # Message model with roles
├── providers/
│   └── ChatProvider.dart    # Main state management
├── screens/
│   └── ChatScreen.dart      # Main chat interface
├── utils/
│   ├── colors.dart          # App color scheme
│   └── texts.dart           # Text constants and API config
└── widgets/
    ├── appAppBar.dart       # Custom app bar
    ├── Assistantmessage.dart     # AI message bubble
    ├── Assistantmessageloading.dart # Loading indicator
    ├── Chatmessage.dart     # Base message widget
    ├── messagefield.dart    # Input field
    └── Usermessage.dart     # User message bubble
```

## 🎯 Key Features Explained

### Real-time Connectivity Monitoring
```dart
// Automatically monitors internet connection
bool get isOnline => _connectivityStatus != ConnectivityResult.none;

// Shows beautiful toast notifications for connection issues
void _showConnectionToast(BuildContext context, String message)
```

### AI Chat Integration
```dart
// Powered by Llama 3.3 70B model
"model": "llama-3.3-70b-versatile"

// Configurable parameters
"temperature": 0.7,
"max_tokens": 1000
```

### Custom Toast Notifications
- **Gradient backgrounds** for visual appeal
- **Auto-dismiss** after 3 seconds
- **Smooth animations** with overlay positioning
- **Context-aware icons** (WiFi, error states)

## 🎨 Customization

### Themes
The app automatically adapts to system theme:
```dart
themeMode: ThemeMode.system // Follows system theme
```

### Colors
Customize app colors in `lib/utils/colors.dart`:
```dart
class AppColors {
  static const Color messagebubblecolorLIGHTMODE = Color(0xFFE3F2FD);
  static const Color messagebubblecolorDARKMODE = Color(0xFF263238);
}
```

### Messages
Update system messages and UI text in `lib/utils/texts.dart`

## 🔧 Configuration

### API Setup
1. Get your API key from your AI provider
2. Update the endpoint URL in `texts.dart`
3. Configure model parameters as needed

### Firebase (Optional)
The project includes Firebase configuration files for additional features:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

## 📱 Platform Support

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11+)
- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux** (Ubuntu 18.04+)

## 🚦 Usage

1. **Start Chatting**: Open the app and start typing your message
2. **Connection Status**: App automatically monitors your internet connection
3. **Offline Mode**: Get notified when offline with beautiful toast messages
4. **Theme Switching**: App follows your system theme automatically

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Groq/Meta** for the Llama model API
- **Flutter Community** for packages and inspiration

## 📞 Support

If you have any questions or need help:
- Create an issue on GitHub
- Check the Flutter documentation
- Join the Flutter community discussions

---

**Made with ❤️ using Flutter**

> **Note**: Remember to keep your API keys secure and never commit them to version control. Use environment variables or secure configuration files in production.
