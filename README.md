# Entry Mid Level Task

This is an Entry Mid Level task where essential skills are demonstrated through a Flutter application.

## Features Overview

API integration was implemented following the documentation from: https://dummyjson.com/

This application features:

### Authentication & Navigation
- **Login Page** - Secure authentication with token management
- **Profile Section** - Accessible via app bar, displays personal information with theme switching capability
- **GoRouter Navigation** - Modern declarative routing with deep linking support

### Product Management (Tab 1)
- **Product List** - Paginated list of all products with infinite scroll
- **Product Details** - Detailed view for each product with image carousel
- **Efficient Loading** - Implements pagination for optimal performance

### Performance Demo (Tab 2)
- **Sorting Algorithm** - Demonstrates QuickSort implementation on large datasets
- **Asynchronous Processing** - Generates and sorts 25 million random numbers using Dart Isolates
- **Responsive UI** - Heavy computations don't block the main thread
- **Real-time Timer** - Displays elapsed time during sorting operation

## Technical Implementation

### Architecture & State Management
- **Flutter BLoC** - State management following clean architecture principles
- **Service Locator** - Dependency injection using GetIt
- **Repository Pattern** - Clean separation of data layer
- **SOLID Principles** - Adherence to software design best practices

### Security & Storage
- **Flutter Secure Storage** - Encrypted token storage for sensitive data
- **Refresh Token** - Automatic token refresh on expiration
- **Hive** - Local NoSQL database for user profile caching
- **Shared Preferences** - Persistent key-value storage for app settings

### UI/UX Features
- **Theme Switching** - Light/Dark mode support with persistent storage
- **Splash Screen** - Native splash screen during app initialization
- **Cached Network Images** - Optimized image loading and caching
- **Skeleton Loading** - Shimmer effect for better loading experience
- **Hero Animations** - Smooth transitions between screens
- **Pull-to-Refresh** - Intuitive data refresh mechanism

### Network & API
- **Dio HTTP Client** - Advanced HTTP client with interceptors
- **Error Handling** - Comprehensive error handling with user-friendly messages
- **Connectivity Check** - Network status monitoring
- **Token Interceptor** - Automatic token injection in requests
- **Retry Logic** - Automatic retry on token expiration

### Code Quality
- **Clean Code** - Readable, maintainable, and well-documented
- **Type Safety** - Leverages Dart's strong type system
- **Functional Programming** - Uses Dartz for Either type (Result pattern)
- **BLoC Observer** - Centralized state change logging
- **Equatable** - Value equality for state management

## Demo

[Click here for preview!](https://github.com/user-attachments/files/16616223/Simulator.Screen.Recording.mp4.zip)

## Project Structure

```
lib/
├── feature/              # Feature modules
│   ├── authentication/   # Login & auth logic
│   ├── products/         # Product list & details
│   ├── profile/          # User profile management
│   ├── sort/             # Sorting algorithm demo
│   └── theme/            # Theme management
├── models/               # Data models
│   ├── products/         # Product models
│   ├── user_profile/     # User profile models
│   ├── theme_entity/     # Theme models
│   └── heavy_task/       # Sorting task models
├── service/              # Business logic layer
│   ├── auth/             # Authentication service
│   ├── products/         # Products service
│   ├── theme/            # Theme service
│   ├── hive/             # Local storage setup
│   └── failure/          # Error handling
├── shared/               # Shared resources
│   ├── widgets/          # Reusable widgets
│   ├── app_colors.dart   # Color palette
│   ├── app_theme.dart    # Theme configuration
│   └── routes.dart       # App routing
└── main.dart             # Application entry point
```

## Getting Started

### Prerequisites
- Flutter SDK 3.2.3 or higher
- Dart SDK
- iOS Simulator / Android Emulator or physical device

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd entry_mid_level_task
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run code generation (for Hive)**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

### Test Credentials

Use any credentials from [DummyJSON Users](https://dummyjson.com/users) for testing authentication.

Example:
- **Username:** `emilys`
- **Password:** `emilyspass`

## Key Packages Used

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management with BLoC pattern |
| `dio` | HTTP client for API calls |
| `go_router` | Declarative routing and navigation |
| `hive_flutter` | Fast, local NoSQL database |
| `flutter_secure_storage` | Encrypted key-value storage |
| `cached_network_image` | Image caching and optimization |
| `google_fonts` | Custom fonts integration |
| `dartz` | Functional programming utilities |
| `equatable` | Value equality for models |
| `get_it` | Service locator for dependency injection |
| `connectivity_plus` | Network connectivity monitoring |
| `shared_preferences` | Persistent key-value storage |
| `carousel_slider` | Image carousel for product details |
| `flash` | Toast and snackbar notifications |

## Performance Highlights

- **Isolate-based Computing** - Heavy computations (sorting 25M numbers) run in background isolate
- **Efficient Pagination** - Loads 20 items per page with infinite scroll
- **Image Caching** - Reduces network calls and improves loading times
- **Optimized Rebuilds** - BLoC ensures minimal widget rebuilds
- **Lazy Loading** - Data fetched on-demand
- **Memory Management** - Proper disposal of resources

## Architecture Patterns

### Clean Architecture
The app follows clean architecture principles with clear separation of concerns:
- **Presentation Layer** - UI components and BLoCs
- **Domain Layer** - Business logic and use cases
- **Data Layer** - API services and local storage

### State Management
Uses BLoC pattern for predictable state management:
- **Cubits** - Simplified BLoC for straightforward state changes
- **States** - Immutable state classes using Equatable
- **Events** - Type-safe actions for state transitions

### Error Handling
Comprehensive error handling using Either type:
- **Left** - Failure cases with descriptive error messages
- **Right** - Success cases with data
- **Custom Failures** - Network, authentication, and server errors

## Features Breakdown

### 1. Authentication Flow
```
Login Screen → Validate Credentials → Store Token → Navigate to Products
                     ↓
              (If token expires)
                     ↓
         Auto Refresh Token → Continue
```

### 2. Product Pagination
```
Initial Load (20 items) → Scroll to Bottom → Load More (20 items) → Repeat
```

### 3. Sorting Performance
```
Press Button → Generate 25M Numbers → Sort in Isolate → Display Time
                                             ↓
                                    (UI remains responsive)
```

## Testing

### Manual Testing Checklist
- [ ] Login with valid credentials
- [ ] Token refresh on expiration
- [ ] Product list pagination
- [ ] Product detail navigation
- [ ] Theme switching (Light/Dark)
- [ ] Sorting algorithm execution
- [ ] Profile information display
- [ ] Logout functionality
- [ ] Network error handling
- [ ] Offline behavior

### Running Tests
```bash
flutter test
```

## Build for Production

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Known Limitations

- Currently uses DummyJSON API (mock data)
- No cart functionality implemented (UI button present but not functional)
- Limited to iOS and Android platforms (macOS, Linux, Windows not configured)

## Future Enhancements

- [ ] Implement shopping cart functionality
- [ ] Add product search and filtering
- [ ] Implement user registration
- [ ] Add product categories
- [ ] Implement favorites/wishlist
- [ ] Add unit and widget tests
- [ ] Multi-language support (i18n)
- [ ] Analytics integration

## Contributing

This is a demonstration project. For any questions or suggestions, please reach out.

## License

This project is for educational and demonstration purposes.

---

**Project Type**: Entry/Mid-Level Flutter Developer Assessment  
**Completion Status**: ✅ Complete  
**Last Updated**: October 2024

**Key Achievements**:
- ✅ Clean architecture implementation
- ✅ Secure authentication with token refresh
- ✅ Efficient state management with BLoC
- ✅ Performance optimization with Isolates
- ✅ Professional UI/UX with animations
- ✅ Comprehensive error handling
- ✅ Theme switching functionality
- ✅ Pagination and infinite scroll
- ✅ Local data caching

**Note**: This project demonstrates mid-level Flutter development skills including state management, API integration, performance optimization, clean architecture principles, and production-ready code quality.
