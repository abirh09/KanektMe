class ValidatorClass {

  String? noValidationRequired(String? value) {
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter email";
    } else if (!RegExp('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
      return "Please enter valid email";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter phone number";
    }
    final RegExp phoneRegExp = RegExp(r'^\+?[0-9\s\-\(\)]{10,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter password";
    } else if (value.length<6) {
      return "Password too short";
    }
    return null;
  }

}