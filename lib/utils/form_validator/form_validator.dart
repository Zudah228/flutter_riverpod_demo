import 'package:form_validator/form_validator.dart';

const formValidator = FormValidator._();

typedef ValidationCallback = String? Function(Object? value);

class FormValidator {
  const FormValidator._();

  static FormValidatorLocale locale = ValidationBuilder.globalLocale;

  ValidationBuilder string() => ValidationBuilder();
  ObjectValidationBuilder object<T>() => ObjectValidationBuilder();
}

class ObjectValidationBuilder {
  final List<ValidationCallback> validations = [];

  ObjectValidationBuilder required([String? message]) => add(
        (v) => v == null
            ? message ?? FormValidator.locale.required()
            : null,
      );

  ObjectValidationBuilder add(ValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  String? test(Object? value) {
    for (var validate in validations) {
      // Otherwise execute validations
      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  /// Returns a validator function for FormInput
  ValidationCallback build() => test;
}
