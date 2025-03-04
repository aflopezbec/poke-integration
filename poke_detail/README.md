# poke_detail

## 1. Presentation Layer (UI)
- Uses **Flutter BLoC** for state management
- The main screen is `PokemonDetailScreen` which displays Pokemon information
- Routing is handled with **auto_route** package
- UI components are organized into widgets (like `PokemonDetailWidget`)

## 2. Domain Layer
- Contains business logic in Use Cases (e.g., `GetPokemonUseCase`)
- Includes domain models (e.g., `Pokemon`)
- Defines repository interfaces (e.g., `PokemonRepository`)

## 3. Data Layer
- Repository implementations (e.g., `PokemonRepositoryImpl`)
- Data Transfer Objects (DTOs) for network responses (e.g., `PokemonDto`)
- Local database for caching (`PokemonDatabase`)
- Network communication using **Dio** HTTP client

## 4. Core Infrastructure
- Dependency Injection using **GetIt** and **injectable**
- Network handling with error management
- Router configuration with **auto_route**
- Design system with tokens for colors and text styles

## Key Architecture Patterns:
1. **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
2. **Repository Pattern**: Abstracts data sources from the rest of the application
3. **BLoC Pattern**: State management using events and states
4. **Dependency Injection**: Provides dependencies using GetIt

## Flow of Data:
1. UI triggers events in the BLoC
2. BLoC calls use cases from the domain layer
3. Use cases retrieve data through repositories
4. Repositories fetch data from network or local database
5. Data flows back through the same path, transforming from DTOs to domain models
6. BLoC updates state and UI refreshes

The app is specifically focused on Pokemon details, displaying information about a Pokemon with a given ID, including its abilities and moves, which are fetched from an API.