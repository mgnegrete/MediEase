# MediEase

MediEase is a mobile application designed to streamline the scheduling and management of medical appointments. The app allows patients to easily book, view, and manage their appointments with healthcare providers. With a clean and user-friendly interface, MediEase provides a seamless experience for both patients and healthcare professionals. The app is built using Flutter, ensuring cross-platform compatibility, and includes essential features such as appointment reminders, patient details management, and appointment history tracking.

## Getting Started

Follow these steps to get the project up and running on your local machine:

### Prerequisites

Make sure you have the following installed on your computer:

- [Flutter](https://flutter.dev/docs/get-started/install) (Flutter 3.7 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development, if you're working on macOS)
- [Android Studio](https://developer.android.com/studio) or any other IDE of your choice (VS Code, IntelliJ IDEA, etc.)
- An emulator or physical device for running the app

### Clone the Repository

Clone the project to your local machine using Git:

```bash
git clone https://github.com/your-username/mediease.git
```

Navigate into the project directory:

```bash
cd mediease
```

### Install Dependencies

Run the following command to install the required dependencies:

```bash
flutter pub get
```

This will download the necessary packages listed in the `pubspec.yaml` file.

### Run the Application

1. Make sure you have a device or emulator running.
2. To run the app, use the following command:

```bash
flutter run
```

This will launch the app on your connected device or the emulator.

### Running on iOS

For iOS development, make sure you have Xcode installed and set up. You can run the app on an iOS simulator or a connected iOS device using:

```bash
flutter run --ios
```

### Running on Android

For Android, make sure Android Studio is installed and the Android emulator is running. You can run the app on an Android device or emulator using:

```bash
flutter run --android
```
### Running on Chrome

To run on Chrome

```bash
flutter run -d chrome
```


### Hot Reload

Flutter supports hot reload, which allows you to quickly view changes made to the code without restarting the app. To use hot reload, simply save your changes and the app will update automatically.

### Testing

Run the tests using the following command:

```bash
flutter test
```

This will run all the unit tests in the `test/` directory.

## Project Structure

Here's an overview of the project's folder structure:

- `lib/` – Contains the Dart code for the app (UI, logic, etc.)
- `assets/` – Contains images, fonts, and other static resources
- `test/` – Contains unit tests for the app
