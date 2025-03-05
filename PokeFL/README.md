# PokeFL Project Architecture Analysis

Based on my exploration of the codebase, here's an overview of the PokeFL project architecture:

## Project Structure

The PokeFL project is an Android application written in Kotlin that integrates Flutter components.
It follows a clean architecture pattern with clear separation of concerns.

## Key Components

### Application Layer

- **App.kt**: The application class that initializes Koin for dependency injection. It sets up
  several modules:
    - networkModule
    - localModule
    - repositoryModule
    - useCaseModule
    - viewModelModule
    - flutterModule

### Navigation

- **AppNavigator.kt**: Manages navigation using Jetpack Compose's Navigation component
    - Main routes: splash → home
- **MainActivity.kt**: Entry point that initializes the AppNavigator

### UI Layer (Compose)

- **SplashScreen.kt**: Initial loading screen with a Lottie animation
- **HomeScreen.kt**: Main screen of the application, likely containing the Pokedex
- **PokedexViewModel.kt**: Manages the UI state and logic for the Pokedex screen

### Flutter Integration

- **flutterModule.kt**: Sets up Flutter integration
    - Creates and caches a FlutterEngine instance
    - Establishes a MethodChannel for communication between Kotlin and Flutter
    - Uses the channel "com.aflopezbec.poke_detail_channel" for communication
    - Handles navigation events from Flutter

### Domain Layer

- **Pokemon.kt**: Domain model representing Pokemon entities
- Use cases (from useCaseModule)

### Data Layer

- **Remote**: Contains DTOs like PokemonDetailsResponseDto for API responses
- **Local**: Database components for local storage
- **Repositories**: Bridge between data sources and domain layer

## Architecture Pattern

The app follows a clean architecture approach with:

1. **Presentation Layer**: Compose UI components and ViewModels
2. **Domain Layer**: Business logic, models, and use cases
3. **Data Layer**: Repositories, remote (API) and local (database) data sources

## Key Technologies

- **Kotlin** as the primary language
- **Jetpack Compose** for UI
- **Koin** for dependency injection
- **Flutter** integration for certain screens (likely the Pokemon detail screen)
- **Navigation Component** for screen navigation
- **MethodChannel** for Flutter-Kotlin communication

## Hybrid Approach

The app demonstrates a hybrid approach combining native Android (Kotlin) and Flutter:

- Main navigation and screens built with Jetpack Compose
- Pokemon detail view appears to be implemented in Flutter
- Communication between the platforms handled via MethodChannel

This architecture allows the app to leverage both the native Android capabilities and Flutter's
cross-platform features where appropriate.