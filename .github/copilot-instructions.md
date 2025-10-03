# NutriScan AI Coding Assistant Guide

Welcome to NutriScan! This guide is designed to help AI coding assistants like GitHub Copilot understand our project's structure, conventions, and workflows. By following these instructions, you can contribute effectively and maintain code quality.

## Project Overview

NutriScan is a Flutter-based mobile application designed to provide nutritional information through barcode scanning and manual search. Our goal is to create a user-friendly tool that helps people make informed decisions about their diet.

### Key Features:
- **Barcode Scanning:** Quickly retrieve product information by scanning its barcode.
- **Manual Search:** Find nutritional details for a wide range of food items.
- **Personalized Tracking:** Log meals and monitor daily intake.

## Getting Started

To get started with NutriScan, you'll need to have Flutter installed on your system. You can find instructions on how to do this [here](https://flutter.dev/docs/get-started/install).

Once you have Flutter set up, you can clone the repository and run the app:

```bash
git clone https://github.com/your-username/nutriscan.git
cd nutriscan
flutter pub get
flutter run
```

## Project Structure

Our project follows the standard Flutter layout, with a few key directories to be aware of:

- **`lib/`**: This is where all the Dart code for the application resides.
  - **`main.dart`**: The entry point of the application.
  - **`screens/`**: Contains the different screens or pages of the app.
  - **`widgets/`**: Reusable UI components.
  - **`services/`**: Business logic, API calls, and other services.
- **`assets/`**: Static assets like images, fonts, and configuration files.
- **`test/`**: Unit and widget tests.

## Coding Conventions

We follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style) to ensure our code is consistent and readable. We also use `flutter_lints` to enforce these conventions automatically.

### Naming Conventions:
- **Files:** `snake_case.dart`
- **Classes:** `PascalCase`
- **Variables and Functions:** `camelCase`

## State Management

For state management, we use the **Provider** package, which allows for a simple and efficient way to manage the app's state. When working with state, please adhere to the following principles:

- **Keep it Simple:** Only use Provider for state that needs to be shared across multiple widgets.
- **Separate Concerns:** Keep business logic out of your UI code by using services and models.

## API Integration

NutriScan integrates with the Open Food Facts API to retrieve nutritional information. All API-related code should be placed in the `lib/services/` directory. When adding new API calls, please ensure they are well-documented and handle potential errors gracefully.

## Testing

We aim for high test coverage to ensure the app is stable and reliable. When adding new features, please include corresponding tests:

- **Unit Tests:** For testing individual functions and classes.
- **Widget Tests:** For testing UI components in isolation.

You can run all tests using the following command:

```bash
flutter test
```

Thank you for helping us build NutriScan! By following these guidelines, you'll be able to contribute effectively and help us create a high-quality application.
