import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validation/flutter_validation.dart';

// An example of a specific implementation of validation
class RequiredValidation<T> extends Validation<T> {
  final String errorMessage;

  RequiredValidation(this.errorMessage);

  @override
  String? validate(BuildContext context, T? value) {
    return value == null || (value is String && value.isEmpty) ? errorMessage : null;
  }
}

void main() {
  group('Validator', () {
    testWidgets('apply should return error message for failed validation', (WidgetTester tester) async {
      // Create a test widget to obtain a BuildContext
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(), // A simple widget
        ),
      ));

      final context = tester.element(find.byType(Container));

      final validations = [
        RequiredValidation<String>('Field is required'),
      ];

      final validator = Validator.apply<String>(context, validations);

      expect(validator(''), 'Field is required');
      expect(validator('valid value'), null);
    });

    testWidgets('apply should return null if all validations pass', (WidgetTester tester) async {
      // Create a test widget to obtain a BuildContext
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(), // A simple widget
        ),
      ));

      final context = tester.element(find.byType(Container));

      final validations = [
        RequiredValidation<String>('Field is required'),
      ];

      final validator = Validator.apply<String>(context, validations);

      expect(validator('valid value'), null);
    });

    testWidgets('applyOne should return error message for failed validation', (WidgetTester tester) async {
      // Create a test widget to obtain a BuildContext
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(), // A simple widget
        ),
      ));

      final context = tester.element(find.byType(Container));

      final validation = RequiredValidation<String>('Field is required');
      final validator = Validator.applyOne<String>(context, validation);

      expect(validator(''), 'Field is required');
      expect(validator('valid value'), null);
    });
  });
}
