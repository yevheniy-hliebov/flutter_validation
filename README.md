<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# flutter_validation

## Description

A Flutter package for flexible and reusable form field validations. This package provides an abstract class for defining validation rules and a utility class to apply these rules to form fields. It simplifies the process of validating user input in Flutter applications. The code is adapted and structured from the article [Flutter Form Validation Beyond Basics](https://medium.com/@payam-zahedi/flutter-form-validation-beyond-basics-76443e768624) by Payam Zahedi, with additional test coverage.

    ⚠️ I don't claim ownership of the code, created for the sake of reusing the package without the need to write from scratch.

## Features

- **Custom Validation Rules**: Define your own validation rules by extending the `Validation` class.
- **Multiple Validations**: Apply a list of validations to a single form field.
- **Single Validation**: Apply a single validation rule to a form field.
- **Reusable Validators**: Easily integrate validation logic into your forms with `Validator.apply` and `Validator.applyOne`.

## Getting Started

### Prerequisites

- Flutter SDK installed.
- Basic understanding of Flutter form handling.

### Installation

Add `flutter_validation` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_validation:
    git:
      url: https://github.com/yevheniy-hliebov/flutter_validation.git
```

Run `flutter pub get` to install the package.

## Usage

### Example

Here’s a simple example demonstrating how to use the `flutter_validation` package:

1. **Define a Validation Rule**

   ```dart
   class RequiredValidation<T> extends Validation<T> {
     const RequiredValidation();

     @override
     String? validate(BuildContext context, T? value) {
       return value == null || (value is String && value.isEmpty) ? 'Field is required' : null;
     }
   }
   ```

2. **Apply Validations to a Form Field**

   ```dart
   final context = /* Obtain BuildContext from your widget tree */;

   final validations = [
     const RequiredValidation<String>(),
   ];

   final validator = Validator.apply<String>(context, validations);

   // Use validator in your form field
   ```

3. **Example in a Widget**

   ```dart
   class MyForm extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return Form(
         child: Column(
           children: [
             TextFormField(
               validator: Validator.apply<String>(
                 context,
                 [const RequiredValidation()],
               ),
             ),
           ],
         ),
       );
     }
   }
   ```
