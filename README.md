# Awari — Flutter Technical Assessment

A faithful Flutter reproduction of the [Lumière fashion app Dribbble design](https://dribbble.com/shots/24747396-Lumi-re-Fashion-mobile-app) built with **zero external packages**.

---

## Getting Started

```bash
flutter pub get
flutter run
```

> Requires Flutter ≥ 3.10.

---

## Implementation Details

- **Responsive Design**: Implemented a custom responsive layout system in `lib/core/utils/size_utils.dart` to maintain visual integrity across different screen sizes without external packages.
- **Architecture**: Follows **Domain-Driven Design (DDD)** principles for clean separation of concerns.
- **Styling**: Utilizes a centralized `AppTextStyle` and `AppColors` system for consistent branding and aesthetic replication.

---

## Architecture

The project follows **Domain-Driven Design (DDD)** layered into three top-level concerns:

```
lib/
├── core/                        # App-wide cross-cutting concerns
│   ├── constants/               #   AppColors · AppTextStyle · AppImages
│   ├── navigation/              #   RouteEnum · RouteConfig · MainNavigationShell
│   ├── theme/              #   AppTheme (MaterialApp ThemeData)
│   └── utils/                   #   SizeUtils
│
├── features/
│   ├── entry/                   # Screen 1 — Landing
│   │   ├── data/
│   │   │   ├── datasource/      #   
│   │   │   ├── models/          #   
│   │   │   └── repository_impl/ #   
│   │   ├── domain/
│   │   │   ├── entity/          #   
│   │   │   └── repositories/    #   
│   │   └── presentation/
│   │       ├── providers/       #   
│   │       ├── screens/         #   EntryScreen
│   │       └── widgets/         # 
│   │
│   └── home/                    # Screen 2 + Screen 3
│       ├── data/
│       │   ├── datasource/      #   ProductLocalDatasource
│       │   ├── models/          #   ProductModel
│       │   └── repository_impl/ #   ProductRepositoryImpl
│       ├── domain/
│       │   ├── entity/          #   Product Entity
│       │   └── repositories/    #   ProductRepository 
│       └── presentation/
│           ├── providers/       #   HomeProvider · HomeProviderScope
│           ├── screens/         #   HomeScreen · ProductScreen
│           └── widgets/         #   ProductCard · CategoryChipWidget · SearchBarWidget · SizeChip
│                             
│
└── shared/
    └── widgets/                 # CustomIconButton · AppBottomNavBar
```
---