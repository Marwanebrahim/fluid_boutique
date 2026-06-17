# Fluid Boutique

A modern Flutter application that provides a smooth authentication experience with onboarding, user registration, login, password recovery, and Firebase integration.

## 📱 Overview

Fluid Boutique is built using Flutter and follows a feature-based architecture with state management powered by BLoC. The application provides a scalable and maintainable structure while integrating Firebase Authentication and Cloud Firestore for user management.

## ✨ Features

- Splash Screen
- Onboarding Flow
- User Registration
- User Login
- Forgot Password
- Google Sign-In
- Firebase Authentication
- Cloud Firestore Integration
- Persistent Onboarding State using Hive
- Responsive UI Components
- Clean Feature-Based Architecture
- Dependency Injection using GetIt
- State Management using Flutter Bloc

---

## 🏗️ Architecture

The project follows a layered architecture inspired by Clean Architecture principles.

```text
lib
│
├── core
│   ├── configs
│   ├── dialogs
│   ├── error
│   ├── helpers
│   └── routing
│
├── features
│   ├── app
│   │   ├── data
│   │   └── presentation
│   │
│   └── auth
│       ├── data
│       └── presentation
│
├── shared
│   └── widgets
│
├── injection_container.dart
└── main.dart
```

---

## 🛠️ Tech Stack

### Framework
- Flutter

### State Management
- Flutter Bloc

### Backend & Database
- Firebase Authentication
- Cloud Firestore

### Local Storage
- Hive

### Dependency Injection
- GetIt

### Functional Programming
- Dartz

### UI
- Google Fonts
- Flutter SVG
- Smooth Page Indicator

---

## 📦 Packages Used

```yaml
flutter_bloc
firebase_core
firebase_auth
cloud_firestore
google_sign_in
get_it
hive
hive_flutter
dartz
equatable
google_fonts
flutter_svg
smooth_page_indicator
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Firebase Project

---

### Installation

#### 1. Clone the repository

```bash
git clone https://github.com/your-username/fluid-boutique.git
```

#### 2. Navigate to project directory

```bash
cd fluid-boutique
```

#### 3. Install dependencies

```bash
flutter pub get
```

#### 4. Configure Firebase

Add your Firebase configuration files:

##### Android

```text
android/app/google-services.json
```

##### iOS

```text
ios/Runner/GoogleService-Info.plist
```

---

#### 5. Run the application

```bash
flutter run
```

---

## 🔐 Authentication Flow

1. User launches app.
2. Splash Screen checks onboarding state.
3. New users see onboarding screens.
4. User can:
   - Sign Up
   - Login
   - Login with Google
   - Reset Password
5. Authentication handled through Firebase Auth.
6. User data stored in Cloud Firestore.

---

## 📂 Main Features

### Onboarding
- Multi-page onboarding experience
- Skip functionality
- Saved locally using Hive

### Authentication
- Email & Password Sign Up
- Email & Password Login
- Google Sign-In
- Forgot Password

### State Management
- BLoC Pattern
- Events & States separation
- Predictable state flow

---

## 🔮 Future Improvements

- Home Screen Implementation
- Product Catalog
- Favorites
- Shopping Cart
- Profile Management
- Dark Mode
- Localization (Arabic & English)
- Push Notifications

---

## 👨‍💻 Developer

**Marwan Ebrahim**

Flutter Developer 

---

## 📄 License

This project is for educational .