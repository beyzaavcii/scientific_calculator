# 🧮 Scientific Calculator (Flutter)

A cross-platform scientific calculator application built with **Flutter** and **Dart** as part of a university Mobile Application Development course.

---

## Overview

This repository contains the source code and multi-platform project structure for a scientific calculator built using Flutter. The project was developed to practice mobile UI design, state/expression handling, and cross-platform application structuring with Dart.

---

## Key Highlights

- **Cross-Platform Flutter Structure:** Includes project targets for Android, iOS, Web, Windows, macOS, and Linux generated via Flutter.
- **Core Application Logic (`lib/`):** Contains the Dart application implementation and UI components.
- **Test & Quality Setup (`test/`, `analysis_options.yaml`):** Includes widget/unit test scaffolding and Dart lint rules.

---

## Repository Structure

```text
scientific_calculator/
├── android/              # Android platform project files
├── ios/                  # iOS platform project files
├── lib/                  # Main Dart source code and UI implementation
├── linux/                # Linux desktop target files
├── macos/                # macOS desktop target files
├── test/                 # Automated test files
├── web/                  # Web target files
├── windows/              # Windows desktop target files
├── .gitignore            # Files ignored by Git
├── .metadata             # Flutter tool metadata
├── analysis_options.yaml # Dart static analysis / lint configuration
├── pubspec.lock          # Locked dependency versions
├── pubspec.yaml          # Flutter dependencies and project configuration
└── README.md             # Project documentation
```
---

## Getting Started

### Prerequisites
- Flutter SDK and Dart installed
- An IDE such as VS Code or Android Studio with Flutter/Dart extensions

### Run Locally
```bash
git clone [https://github.com/beyzaavcii/scientific_calculator.git](https://github.com/beyzaavcii/scientific_calculator.git)
cd scientific_calculator
flutter pub get
flutter run
```
