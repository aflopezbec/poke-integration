# Pokemon Application (PokeFL + poke_detail)

A comprehensive Pokemon application that combines a native Android experience using Kotlin with a Flutter module for detailed Pokemon information. This project demonstrates how to integrate Flutter modules into existing native Android applications.

## Project Overview

This repository contains two main components:

- **PokeFL**: A native Android application written in Kotlin that serves as the main container app
- **poke_detail**: A Flutter module that provides detailed Pokemon information with rich UI components

The project showcases modern mobile development practices including modular architecture, cross-platform integration, and shared UI components.

## Repository Structure

```
root/
├── PokeFL/            # Android Kotlin application
│   ├── app/           # Android app module
│   ├── gradle/        # Gradle configuration
│   └── ...
│
├── poke_detail/       # Flutter module
│   ├── lib/           # Dart source code
│   ├── assets/        # Images and resources
│   └── ...
│
└── README.md          # Project documentation
```

## Architecture

The application uses a hybrid architecture:

- The Android app (PokeFL) handles navigation, data retrieval, and platform integration
- The Flutter module (poke_detail) provides detailed Pokemon screens with rich animations and cross-platform UI
- Communication between the two is handled through platform channels

## Prerequisites

Before setting up the project, ensure you have the following installed:

- Android Studio (latest version)
- Flutter SDK (stable channel)
- JDK 11 or newer
- Git

## Setup Instructions

### Clone the repository

```bash
git clone https://github.com/yourusername/pokemon-application.git
cd pokemon-application
```

### Setting up the Flutter Module (poke_detail)

1. Navigate to the Flutter module directory:
```bash
cd poke_detail
```

2. Get Flutter dependencies:
```bash
flutter pub get
```

3. Run Flutter tests to ensure everything is working:
```bash
flutter test
```

### Setting up the Android App (PokeFL)

1. Navigate to the Android app directory:
```bash
cd ../PokeFL
```

2. Open the project in Android Studio:
- Launch Android Studio
- Select "Open an existing Android Studio project"
- Navigate to the PokeFL directory

3. Let Gradle sync the project dependencies

## Dependencies

### Android App Dependencies

- Kotlin Coroutines for asynchronous programming
- Retrofit for API requests
- Glide for image loading
- Flutter module integration

### Flutter Module Dependencies

- Flutter SDK
- Provider for state management
- http package for API requests
- flutter_svg for rendering SVG files

## Running the Application

### Running the complete application

1. Ensure the Flutter module is properly set up
2. Open the PokeFL project in Android Studio
3. Connect an Android device or start an emulator
4. Click the "Run" button in Android Studio

### Running just the Flutter module for development

```bash
cd poke_detail
flutter run
```

## Development Workflow

1. Make changes to the Flutter module for Pokemon detail screens
2. Test those changes using `flutter run` within the poke_detail directory
3. Once satisfied, integrate the changes into the Android app
4. Run the full application to verify integration

## Troubleshooting

### Common Issues

- **Flutter module not found**: Ensure the Flutter module path is correctly specified in the Android app's settings.gradle
- **Incompatible Flutter version**: Make sure your Flutter SDK version matches the one specified in the Flutter module's pubspec.yaml

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any questions or suggestions, please open an issue in this repository.

