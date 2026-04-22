# Lamma3ly 🚀

Lamma3ly is a high-performance, scalable multi-domain Flutter application designed as a service platform. It caters to three distinct user groups: **Customers**, **Servicers**, and **Admins**, all within a single unified codebase.

## 🏗️ Architecture & Design Patterns

The project follows a strict **Clean Architecture** approach combined with **MVVM (Model-View-ViewModel)** to ensure scalability, maintainability, and testability.

- **Clean Architecture**: Separation of concerns across Data, Domain, and Presentation layers.
- **MVVM + BLoC**: State management is handled using `flutter_bloc`, providing a predictable and reactive UI.
- **Feature-First Structure**: Each domain (Customer, Servicer, Admin) is encapsulated within its own module in the `features` directory.

## 🛠️ Tech Stack

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Networking**: [dio](https://pub.dev/packages/dio) (with interceptors for logging and auth)
- **Navigation**: [go_router](https://pub.dev/packages/go_router) (Role-based routing)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Local Storage**: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- **Localization**: [intl](https://pub.dev/packages/intl) (Support for Multi-language AR/EN)
- **Logging**: [logger](https://pub.dev/packages/logger)

## 📂 Project Structure

```bash
lib/
├── app/                # App-level configuration (DI, Environments, App Widget)
├── core/               # Shared core logic (Networking, Storage, Theme, Utils)
├── features/           # Domain-specific features
│   ├── admin/          # Admin-specific modules
│   ├── customer/       # Customer-specific modules
│   └── servicer/       # Servicer-specific modules
├── l10n/               # Localization files (ARB)
├── routing/            # GoRouter configuration and routes
└── shared/             # Shared UI widgets and constants across domains
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Check `pubspec.yaml` for minimum version)
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd lamma3ly
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 🌍 Localization

The app supports multiple languages. To generate localization files after adding new keys in `lib/l10n`:
```bash
flutter gen-l10n
```

## 🧪 Development

The project includes multiple entry points for different environments:
- `lib/main_dev.dart`: Development environment
- `lib/main_prod.dart`: Production environment

---
Built with ❤️ by the Lamma3ly Team.
