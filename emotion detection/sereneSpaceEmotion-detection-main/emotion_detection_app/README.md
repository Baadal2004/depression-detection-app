# EmotionAI: Real-Time Emotion Detection App

EmotionAI is a sleek, modern Flutter application that performs on-device emotion detection using machine learning. It uses a Convolutional Neural Network (CNN) converted to TensorFlow Lite to classify facial expressions into seven distinct emotions in real-time.

## 🚀 Key Features

- **Real-Time Detection**: Analyzes camera frames every 500ms.
- **On-Device AI**: Powered by TensorFlow Lite; no internet connection required.
- **High Performance**: Uses Google ML Kit for lightning-fast face detection.
- **Premium UI**: Dark-themed design with glassmorphism effects and smooth animations.
- **Privacy-First**: No images or data ever leave your device.

## 🧠 Detected Emotions

The app accurately identifies seven universal emotions:
- 😊 **Happy**
- 😢 **Sad**
- 😠 **Angry**
- 😲 **Surprised**
- 😨 **Fearful**
- 🤢 **Disgusted**
- 😐 **Neutral**

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.7 or higher)
- [Android Studio](https://developer.android.com/studio) / [VS Code](https://code.visualstudio.com/)
- An Android device or emulator with camera support.

## 📥 Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd emotion_detection_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   Connect your device and run:
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

- `lib/services/emotion_classifier.dart`: TFLite model inference logic.
- `lib/screens/home_screen.dart`: Camera feed and real-time processing.
- `lib/widgets/emotion_display.dart`: Animated UI for results.
- `assets/model.tflite`: The optimized on-device machine learning model.

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for the full text.
