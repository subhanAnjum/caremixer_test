# Caremixer Assessment

A Flutter application demonstrating clean architecture, state management with Riverpod, and modern UI design patterns. This project showcases three main features: a timeline view, Pokemon API integration, and a chat interface.

## 🎯 Features

### 🟢 Timeline List
- **Vertical timeline** with 12+ hardcoded healthcare entries
- **Animated timeline dots** with different colors and icons based on entry type
- **Smooth animations** with staggered entry animations
- **Card-based design** with author information and timestamps
- **Type-based styling** (note, audit, alert, success)

### 🟡 Pokemon API Integration
- **Pokemon grid** displaying names and images from PokeAPI
- **Infinite scroll pagination** with automatic loading
- **Search functionality** with real-time filtering
- **Pull-to-refresh** capability
- **Loading and error states** with retry functionality
- **Cached network images** for optimal performance

### 🔴 Chat Interface
- **Real-time chat simulation** with bot responses
- **Sender/receiver message bubbles** with distinct styling
- **Message animations** with slide and fade effects
- **Auto-scroll** to latest messages
- **Participant header** showing chat participants
- **Message timestamps** and clear chat functionality

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       ├── app_utils.dart
│       └── pokemon_utils.dart
├── models/
│   ├── timeline_entry.dart
│   ├── pokemon.dart
│   ├── pokemon_details.dart
│   └── chat_message.dart
├── services/
│   └── pokemon_api_service.dart
├── providers/
│   ├── pokemon_provider.dart
│   ├── pokemon_details_provider.dart
│   ├── theme_provider.dart
│   └── chat_provider.dart
├── views/
│   ├── timeline/
│   │   └── timeline_view.dart
│   ├── pokemon_details/
│   │   └── pokemon_details_view.dart
│   ├── pokemon/
│   │   └── pokemon_view.dart
│   └── chat/
│       └── chat_view.dart
└── widgets/
    ├── chat_bubble.dart
    ├── chat_input_field.dart
    ├── chat_participants_header.dart
    ├── pokemon_card.dart
    ├── pokemon_grid.dart
    ├── pokemon_search_bar.dart
    ├── pokemon_shimmer.dart
    ├── stat_dial.dart
    ├── timeline_entry_widget.dart
    └── timeline_list.dart

```

### State Management
- **Riverpod** for state management with `StateNotifierProvider`
- **AsyncValue** pattern for handling loading, data, and error states
- **Controllers** managed within providers for better state centralization
- **Provider composition** for complex state dependencies

#### Why Riverpod?
Riverpod was chosen for its **simplicity and power** in Flutter state management:

- **Type Safety**: Compile-time safety with provider types
- **Testability**: Easy to mock and test providers in isolation
- **Performance**: Automatic disposal and efficient rebuilds
- **Composition**: Providers can depend on other providers naturally
- **AsyncValue Pattern**: Built-in handling of loading, data, and error states
- **Scoped State**: Each provider has its own lifecycle and scope

#### Implementation Strategy:
- **Pokemon Provider**: Manages API calls, pagination, search, and UI controllers
- **Chat Provider**: Handles local chat state with simulated bot responses
- **Separation of Concerns**: Business logic in providers, UI in widgets
- **Reactive Updates**: UI automatically updates when state changes

### Design System
- **Caremixer color palette** with semantic color usage
- **Material 3** design principles
- **Consistent theming** across light and dark modes
- **Responsive layouts** with proper spacing and typography
- **Accessible colors** and contrast ratios

## 🚀 Getting Started

### Prerequisites
- Flutter 3.x
- Dart 3.x
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation
1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

### Dependencies
- `flutter_riverpod: ^2.5.1` - State management
- `http: ^1.2.2` - HTTP requests
- `cached_network_image: ^3.3.1` - Image caching

## 🎨 Design Features

### Color Palette
- **Primary Orange**: `#f05226` - Main brand color
- **Success Green**: `#84cc8f` - Success states
- **Light Coral**: `#ffd8cf` - Note entries
- **Light Green**: `#e2f7e6` - Audit entries
- **Dark Red**: `#bd3b27` - Alert states
- **Dark Green**: `#345136` - Text and dark mode

### Animations
- **Timeline entries**: Staggered fade-in with slide animations
- **Pokemon cards**: Scale animation on load
- **Chat messages**: Slide-in from left/right with fade
- **Smooth transitions** between states

## 🔧 Technical Implementation

### Key Patterns
- **Provider pattern** for dependency injection
- **Repository pattern** for data access
- **Widget composition** for reusable components
- **Separation of concerns** between UI and business logic

### Performance Optimizations
- **Cached network images** for Pokemon sprites
- **Lazy loading** with infinite scroll
- **Efficient state updates** with Riverpod
- **Memory management** with proper controller disposal

### Error Handling
- **Comprehensive error states** with user-friendly messages
- **Retry mechanisms** for failed operations
- **Graceful degradation** when services are unavailable
- **Loading indicators** for better UX

## 📱 Screenshots

The app features three main screens accessible via bottom navigation:

1. **Timeline** - Healthcare activity timeline with animated entries
2. **Pokemon** - Grid of Pokemon with search and infinite scroll
3. **Chat** - Real-time chat interface with bot simulation

## 🧪 Testing

### Testing Approach
This project emphasizes **manual testing techniques** to ensure quality and functionality:

- **UI/UX Testing**: Verify all three main screens (Timeline, Pokemon, Chat) render correctly
- **Navigation Testing**: Test bottom navigation between different views
- **Search Functionality**: Test Pokemon search with various queries and clear functionality
- **Chat Interaction**: Test message sending, bot responses, and chat clearing
- **Theme Testing**: Verify light/dark mode switching works across all components
- **Responsive Testing**: Test on different screen sizes and orientations
- **Error Handling**: Test network failures, empty states, and edge cases
- **Performance Testing**: Verify smooth animations and scroll performance


## 🚀 Future Enhancements

- **Offline support** with local data persistence
- **Push notifications** for chat messages
- **Advanced search** with filters and sorting
- **User authentication** and profiles
- **Real-time collaboration** features

## 📄 License

This project is part of a technical assessment for Caremixer and is for demonstration purposes only.

---

**Built with ❤️ using Flutter & Riverpod**