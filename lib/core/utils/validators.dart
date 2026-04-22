/// Common input validators used across all domains.
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegex = RegExp(
    r'^\+?[0-9]{10,15}$',
  );

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? '$fieldName is required' : 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, fieldName: 'Email');
    if (requiredError != null) return requiredError;

    if (!_emailRegex.hasMatch(value!.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = required(value, fieldName: 'Password');
    if (requiredError != null) return requiredError;

    if (value!.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    final requiredError = required(value, fieldName: 'Confirm password');
    if (requiredError != null) return requiredError;

    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? phone(String? value) {
    final requiredError = required(value, fieldName: 'Phone');
    if (requiredError != null) return requiredError;

    if (!_phoneRegex.hasMatch(value!.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? fieldName}) {
    final requiredError = required(value, fieldName: fieldName);
    if (requiredError != null) return requiredError;

    if (value!.trim().length < min) {
      return '${fieldName ?? 'Field'} must be at least $min characters';
    }
    return null;
  }
}
