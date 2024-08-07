library flutter_validation;

import 'package:flutter/material.dart';

/// An abstract class representing a validation rule for a form field.
abstract class Validation<T> {
  const Validation();

  /// Validates the given [value] within the context of [context].
  /// Returns an error message as a [String] if the validation fails,
  /// otherwise returns `null`.
  String? validate(BuildContext context, T? value);
}

/// A utility class for applying validations to form fields.
class Validator {
  // Private constructor to prevent instantiation.
  const Validator._();

  /// Applies a list of [validations] to a form field.
  ///
  /// Iterates through each validation and returns the first error message
  /// found. If all validations pass, returns `null`.
  ///
  /// - [context]: The build context of the form field.
  /// - [validations]: A list of validation rules to apply.
  ///
  /// Returns a [FormFieldValidator] function.
  static FormFieldValidator<T> apply<T>(
    BuildContext context,
    List<Validation<T>> validations,
  ) {
    return (T? value) {
      for (final validation in validations) {
        final error = validation.validate(context, value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Applies a single [validation] to a form field.
  ///
  /// - [context]: The build context of the form field.
  /// - [validation]: The validation rule to apply.
  ///
  /// Returns a [FormFieldValidator] function.
  static FormFieldValidator<T> applyOne<T>(
    BuildContext context,
    Validation<T> validation,
  ) {
    return (T? value) => validation.validate(context, value);
  }
}
