# fuel_checker_app

A new Flutter project.

## Getting Started

### Building the APK
To build the APK for the Fuel Checker app, follow these steps:

1. Ensure you have Flutter installed on your machine. You can check this by running:
   ```bash
   flutter --version
   ```

2. Navigate to the project directory:
   ```bash
   cd path/to/your/project/FuelChecker
   ```

3. Install the dependencies:
   ```bash
   flutter pub get
   ```

4. Build the APK:
   ```bash
   flutter build apk
   ```

5. The generated APK can be found in the `build/app/outputs/flutter-apk/` directory.


## Firebase Setup

This project is configured to use Firebase services, including:

- **Firestore**: A flexible, scalable database for mobile, web, and server development.
- **Authentication**: Securely manage users and authenticate them.
- **Storage**: Store and serve user-generated content, such as images and videos.
- **Functions**: Run backend code in response to events triggered by Firebase features and HTTPS requests.

### Configuration Files

- Ensure that the `lib/assets/google-services.json` and `lib/assets/GoogleService-Info.plist` files are correctly configured for your Firebase project.

### Running the Project

After making changes to the dependencies, run the following command to install the necessary packages:

```bash
flutter pub get
```


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
