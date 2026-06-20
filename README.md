# Fluid Boutique 🛍️

> **THE LIQUID CURATOR** — A luxury e-commerce Flutter app built as a portfolio project targeting Flutter Developer internships.

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter + Dart |
| State Management | BLoC |
| Architecture | Clean Architecture |
| Auth + DB | Firebase (Auth + Firestore) |
| Push Notifications | FCM |
| Products API | [DummyJSON](https://dummyjson.com) |
| Navigation | `onGenerateRoute` |
| Dependency Injection | GetIt |
| HTTP Client | Dio |
| Local Storage | Hive |
| Functional Programming | dartz (`Either`, `Unit`) |
| Icons | Flutter Material Icons |
| Fonts | Google Fonts (Manrope + Inter) |

---

## ✅ Features

### User App
- [x] Splash Screen with animated loader
- [x] Onboarding Flow (3 screens, seen-once logic)
- [x] Email + Password Sign Up / Login
- [x] Google Sign-In
- [x] Forgot Password (Firebase email reset)
- [x] Home Screen (Carousel + Categories + Featured + New Arrivals)
- [x] Bottom Navigation Bar (5 tabs)
- [ ] Product Details Screen
- [ ] Search + Filter
- [ ] Cart (Firestore)
- [ ] Wishlist (Firestore)
- [ ] Orders + Checkout (Firestore)
- [ ] Push Notifications (FCM)
- [ ] Profile + Edit Profile

### Admin Panel
- [ ] Admin Login
- [ ] Dashboard (revenue, orders, users)
- [ ] All Orders viewer + status update
- [ ] Order Details

---

## 🗂️ Project Structure

```
lib/
├── core/
│   ├── configs/         → AppColors, AppTextStyles, AppTheme, CategoryIcons
│   ├── error/           → Exceptions, Failures
│   ├── helpers/         → HiveHelper, ImageHelper
│   ├── network/         → NetworkInfo (internet checker)
│   ├── dialogs/         → AuthDialog
│   └── routing/         → AppRouter, AppRoutes
├── features/
│   ├── app/             → Splash + Onboarding (AppBloc)
│   ├── auth/            → Email + Google Auth (AuthBloc)
│   └── products/        → Home + Search + Product Details (ProductBloc)

├── shared/widgets/      → CustomButtonWidget, CustomTextFormField
├── injection_container.dart
└── main.dart
```

---

## 🏛️ Clean Architecture — Per Feature

```
feature/
├── data/
│   ├── datasources/     → API (Dio) / Firebase / Hive
│   ├── mapper/          → Model → Entity extensions
│   ├── models/          → JSON parsing (fromJson / toMap)
│   └── repositories/    → implements domain interface
├── domain/
│   ├── entities/        → Pure Dart classes, no dependencies
│   ├── repositories/    → Abstract interfaces
│   └── usecases/        → Single responsibility, calls repository
└── presentation/
    ├── bloc/            → Event / State / Bloc
    ├── screens/         → UI screens
    └── widgets/         → Feature-specific widgets
```

---

## 🔄 Error Handling Pattern

```
DataSource  →  throws Exception      (ServerException, CacheException, OfflineException)
Repository  →  catches Exception     →  returns Either<Failure, T>
BLoC        →  receives Either       →  fold() → emits State
UI          →  listens to State      →  shows error / success
```

---

## 💉 Dependency Injection (GetIt)

Registration order — always **DataSource → Repository → UseCase → BLoC**

| Type | Method | Reason |
|---|---|---|
| DataSource | `registerLazySingleton` | One instance is enough |
| Repository | `registerLazySingleton` | One instance is enough |
| UseCase | `registerLazySingleton` | Stateless |
| BLoC | `registerFactory` | New instance per screen |

---

## 🔑 Environment Setup

1. Clone the repo
```bash
git clone https://github.com/your-username/fluid-boutique.git
cd fluid-boutique
```

2. Install dependencies
```bash
flutter pub get
```

3. Add Firebase config
```
Place your google-services.json in android/app/
```

4. Run the app
```bash
flutter run
```

---

## 👤 Developer

**Marwan** — 2nd year Software & Multimedia, Alexandria University
Target: Flutter Developer Internship @ Instabug / Paymob / Rabbit / Breadfast

---

## 📄 License

This project is for portfolio and educational purposes.