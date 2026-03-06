/// Reusable validators for form fields
class Validators {
  Validators._();

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    
    return null;
  }

  /// Password validation
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    
    return null;
  }

  /// Required field validation
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Username validation
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
  }


  /// Validate multiple form fields at once
  /// 
  /// Returns true if ALL fields are valid (all validators return null)
  /// Returns false if ANY field is invalid (any validator returns non-null)
  /// 
  /// Example:
  /// ```dart
  /// final isValid = Validators.isValidForm([
  ///   Validators.email(emailController.text),
  ///   Validators.password(passwordController.text),
  /// ]);
  /// ```
  static bool isValidForm(List<String?> validationResults) {
    for (final result in validationResults) {
      if (result != null && result.isNotEmpty) {
        return false;
      }
    }
    return true;
  }
}